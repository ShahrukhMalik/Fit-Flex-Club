import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:injectable/injectable.dart';

abstract class WorkoutPlanManagementRemotedatasource {
  ///
  Future<List<WorkoutPlanModel>?>? getWorkoutPlans();

  ///
  Future<WorkoutPlanModel?>? getWorkoutPlanforClient(String clientId);

  ///
  Future<void> createWorkoutPlan(WorkoutPlanModel workoutPlanModel);

  ///
  Future<void> assignWorkoutPlan(WorkoutPlanModel workoutPlanModel);

  ///
  Future<void> updateWorkoutPlan(WorkoutPlanModel workoutPlanModel);

  ///
  Future<void> updateAssignedWorkoutPlan(WorkoutPlanModel workoutPlanModel);

  ///
  Future<List<ExerciseBpModel>?>? getExercises();
}

@Singleton(as: WorkoutPlanManagementRemotedatasource)
class WorkoutPlanManagementRemotedatasourceImpl
    extends WorkoutPlanManagementRemotedatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  WorkoutPlanManagementRemotedatasourceImpl({
    required this.auth,
    required this.db,
  });

  @override
  Future<void> updateWorkoutPlan(WorkoutPlanModel workoutPlanModel) async {
    try {
      final DocumentReference workoutPlanRef =
          db.collection('WorkoutPlans').doc(workoutPlanModel.uid);

      // Start a batch for main document and nested updates
      WriteBatch mainBatch = db.batch();

      // Update main workout plan document
      mainBatch.update(workoutPlanRef, workoutPlanModel.toMap());

      // Process updates for weeks, days, and exercises in a more efficient manner
      for (var week in workoutPlanModel.weeks) {
        DocumentReference weekRef =
            workoutPlanRef.collection('weeks').doc(week.id.toString());

        for (var day in week.days) {
          DocumentReference dayRef =
              weekRef.collection('days').doc(day.id.toString());

          for (var exercise in day.exercises) {
            DocumentReference exerciseRef =
                dayRef.collection('exercises').doc(exercise.id.toString());

            // Batch update exercise
            mainBatch.set(
                exerciseRef, exercise.toMap(), SetOptions(merge: true));

            // Batch handle sets
            CollectionReference setsRef = exerciseRef.collection('sets');

            // Add or update sets
            for (var set in exercise.sets) {
              DocumentReference setRef = setsRef.doc(set.id.toString());
              mainBatch.set(setRef, set.toMap(), SetOptions(merge: true));
            }

            // Batch delete obsolete sets
            final setsSnapshot = await setsRef.get();
            final existingSetIds =
                setsSnapshot.docs.map((doc) => doc.id).toList();
            final currentSetIds =
                exercise.sets.map((set) => set.id.toString()).toList();

            for (var setId in existingSetIds) {
              if (!currentSetIds.contains(setId)) {
                mainBatch.delete(setsRef.doc(setId));
              }
            }
          }
        }
      }

      // Commit all batched operations
      await mainBatch.commit();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Failed to update workout plan",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<List<WorkoutPlanModel>>? getWorkoutPlans() async {
    try {
      final CollectionReference ref = db.collection('WorkoutPlans');
      final documents = await ref.get();

      // Using await in the map to ensure async calls complete
      final List<WorkoutPlanModel> workouts = await Future.wait(
        documents.docs.map(
          (doc) => WorkoutPlanModel.fromFirestore(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>,
          ),
        ),
      );

      return workouts;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> createWorkoutPlan(WorkoutPlanModel workoutPlanModel) async {
    try {
      final CollectionReference ref = db.collection('WorkoutPlans');
      WriteBatch batch = db.batch(); // Initialize batch write

      // Save the workout plan model
      DocumentReference workoutPlanRef = ref.doc(workoutPlanModel.uid);
      batch.set(workoutPlanRef, workoutPlanModel.toMap());

      // Iterate through weeks
      for (var week in workoutPlanModel.weeks) {
        print('In Weeks Loop');
        print(week);

        // Save week
        DocumentReference weekRef =
            workoutPlanRef.collection('weeks').doc(week.id.toString());
        batch.set(weekRef, week.toMap());

        // Iterate through days
        for (var day in week.days) {
          // Save day
          DocumentReference dayRef =
              weekRef.collection('days').doc(day.id.toString());
          batch.set(dayRef, day.toMap());

          // Iterate through exercises
          for (var exercise in day.exercises) {
            // Save exercise
            final exerciseMap = exercise.toMap();
            exerciseMap['exerciseOrder'] = day.exercises.indexOf(exercise) + 1;
            DocumentReference exerciseRef =
                dayRef.collection('exercises').doc(exercise.id.toString());
            batch.set(exerciseRef, exerciseMap);

            // Iterate through sets
            for (var set in exercise.sets) {
              // Save set
              final setMap = set.toMap();
              setMap['setNumber'] = exercise.sets.indexOf(set) + 1;
              DocumentReference setRef =
                  exerciseRef.collection('sets').doc(set.id.toString());
              batch.set(setRef, setMap);
            }
          }
        }
      }

      // Commit the batch to execute all operations at once
      await batch.commit();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<List<ExerciseBpModel>?>? getExercises() async {
    try {
      final CollectionReference ref = db.collection('Exercises');
      final documents = await ref.get();

      // Using await in the map to ensure async calls complete
      final List<ExerciseBpModel> exercises = documents.docs
          .map(
            (doc) => ExerciseBpModel.fromFirestore(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ),
          )
          .toList();

      return exercises;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> assignWorkoutPlan(WorkoutPlanModel workoutPlanModel) async {
    try {
      final CollectionReference ref = db.collection('Users');
      WriteBatch batch = db.batch(); // Initialize batch write

      // Save the workout plan model
      DocumentReference clientRef = ref
          .doc(workoutPlanModel.clientId)
          .collection('workoutPlans')
          .doc(workoutPlanModel.uid);

      batch.set(clientRef, workoutPlanModel.toMap());

      // Iterate through weeks
      for (var week in workoutPlanModel.weeks) {
        // Save week
        DocumentReference weekRef =
            clientRef.collection('weeks').doc(week.id.toString());
        batch.set(weekRef, week.toMap());

        // Iterate through days
        for (var day in week.days) {
          // Save day
          DocumentReference dayRef =
              weekRef.collection('days').doc(day.id.toString());
          batch.set(dayRef, day.toMap());

          // Iterate through exercises
          for (var exercise in day.exercises) {
            // Save exercise
            final exerciseMap = exercise.toMap();
            exerciseMap['exerciseOrder'] = day.exercises.indexOf(exercise) + 1;
            DocumentReference exerciseRef =
                dayRef.collection('exercises').doc(exercise.id.toString());
            batch.set(exerciseRef, exerciseMap);

            // Iterate through sets
            for (var set in exercise.sets) {
              // Save set
              final setMap = set.toMap();
              setMap['setNumber'] = exercise.sets.indexOf(set) + 1;
              DocumentReference setRef =
                  exerciseRef.collection('sets').doc(set.id.toString());
              batch.set(setRef, setMap);
            }
          }
        }
      }

      // Commit the batch to execute all operations at once
      await batch.commit();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<WorkoutPlanModel?>? getWorkoutPlanforClient(String clientId) async {
    try {
      final CollectionReference ref = db.collection('Users');
      final documents =
          await ref.doc(clientId).collection('workoutPlans').get();

      // Using await in the map to ensure async calls complete
      if (documents.docs.isNotEmpty) {
        final workoutPlanDoc = documents.docs.first;
        //
        final workoutPlanModel = await WorkoutPlanModel.fromFirestore(
          workoutPlanDoc,
        );
        return workoutPlanModel;
      } else {
        return null;
      }
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> updateAssignedWorkoutPlan(
    WorkoutPlanModel workoutPlanModel,
  ) async {
    try {
      final DocumentReference userRef =
          db.collection('Users').doc(workoutPlanModel.clientId);
      final DocumentReference workoutPlanRef =
          userRef.collection('workoutPlans').doc(workoutPlanModel.uid);

      // Start a batch for main document and nested updates
      WriteBatch mainBatch = db.batch();

      // Update main workout plan document
      mainBatch.update(workoutPlanRef, workoutPlanModel.toMap());

      // Process updates for weeks, days, and exercises in a more efficient manner
      for (var week in workoutPlanModel.weeks) {
        DocumentReference weekRef =
            workoutPlanRef.collection('weeks').doc(week.id.toString());

        for (var day in week.days) {
          DocumentReference dayRef =
              weekRef.collection('days').doc(day.id.toString());

          for (var exercise in day.exercises) {
            DocumentReference exerciseRef =
                dayRef.collection('exercises').doc(exercise.id.toString());

            // Batch update exercise
            mainBatch.set(
                exerciseRef, exercise.toMap(), SetOptions(merge: true));

            // Batch handle sets
            CollectionReference setsRef = exerciseRef.collection('sets');

            // Add or update sets
            for (var set in exercise.sets) {
              DocumentReference setRef = setsRef.doc(set.id.toString());
              mainBatch.set(setRef, set.toMap(), SetOptions(merge: true));
            }

            // Batch delete obsolete sets
            final setsSnapshot = await setsRef.get();
            final existingSetIds =
                setsSnapshot.docs.map((doc) => doc.id).toList();
            final currentSetIds =
                exercise.sets.map((set) => set.id.toString()).toList();

            for (var setId in existingSetIds) {
              if (!currentSetIds.contains(setId)) {
                mainBatch.delete(setsRef.doc(setId));
              }
            }
          }
        }
      }

      // Commit all batched operations
      await mainBatch.commit();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Failed to update workout plan",
        errorCode: err.code,
      );
    }
  }
}
