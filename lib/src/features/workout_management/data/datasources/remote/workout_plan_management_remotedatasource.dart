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
  Future<void> createWorkoutPlan(WorkoutPlanModel workoutPlanModel);

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
      await ref.doc(workoutPlanModel.uid).set(workoutPlanModel.toMap());
      workoutPlanModel.weeks.map(
        (week) async {
          await ref
              .doc(workoutPlanModel.uid)
              .collection('week')
              .doc(week.id.toString())
              .set(week.toMap());
          week.days.map(
            (day) async {
              await ref
                  .doc(workoutPlanModel.uid)
                  .collection('week')
                  .doc(week.id.toString())
                  .collection('days')
                  .doc(day.id.toString())
                  .set(day.toMap());
              day.exercises.map(
                (exercise) async {
                  await ref
                      .doc(workoutPlanModel.uid)
                      .collection('week')
                      .doc(week.id.toString())
                      .collection('days')
                      .doc(day.id.toString())
                      .collection('exercises')
                      .doc(exercise.id.toString())
                      .set(exercise.toMap());
                  exercise.sets.map(
                    (set) async {
                      await ref
                          .doc(workoutPlanModel.uid)
                          .collection('week')
                          .doc(week.id.toString())
                          .collection('days')
                          .doc(day.id.toString())
                          .collection('exercises')
                          .doc(exercise.id.toString())
                          .collection('sets')
                          .doc(set.id.toString())
                          .set(set.toMap());
                    },
                  );
                },
              );
            },
          );
        },
      );
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
}
