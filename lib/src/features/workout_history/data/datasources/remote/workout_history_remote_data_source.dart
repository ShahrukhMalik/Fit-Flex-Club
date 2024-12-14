import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

abstract class WorkoutHistoryRemoteDataSource {
  ///
  Future<void> logWorkoutHistory({
    required List<SetModel> sets,
    String? clientId,
    required String exerciseId,
    required String dayId,
    required String weekId,
    required String workoutPlanId,
  });

  ///
  Future<List<WorkoutHistoryModel>?> getWorkoutHistorySets(
    String? clientUid, [
    String? isTrainer,
  ]);
}

@Singleton(as: WorkoutHistoryRemoteDataSource)
class WorkoutHistoryRemoteDataSourceImpl
    implements WorkoutHistoryRemoteDataSource {
  final FirebaseFirestore db;

  WorkoutHistoryRemoteDataSourceImpl({required this.db});
  @override
  Future<List<WorkoutHistoryModel>> getWorkoutHistorySets(
    String? clientUid, [
    String? isTrainer,
  ]) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;

      // Reference to the 'Users' collection
      final CollectionReference ref = db.collection('Users');

      // Fetch workout plans for the user
      final workoutPlanSnapshot =
          await ref.doc(clientUid ?? clientId).collection('workoutPlans').get();
      final Map<String, List<ExerciseModel>> groupedByDate = {};

      // Fetch weeks, days, and exercises for each workout plan
      final List<WorkoutHistoryModel> allWorkoutHistories = [];

      for (final workoutPlanDoc in workoutPlanSnapshot.docs) {
        final weeksRef = workoutPlanDoc.reference.collection('weeks');
        final weekSnapshot = await weeksRef.get();

        for (final weekDoc in weekSnapshot.docs) {
          final daysRef = weekDoc.reference.collection('days');
          final daySnapshot = await daysRef.get();

          for (final dayDoc in daySnapshot.docs) {
            final exerciseRef = dayDoc.reference.collection('exercises');
            final exerciseSnapshot = await exerciseRef
                .where('completed', isEqualTo: true)
                .where(
                  'updatedAt',
                  isNotEqualTo: null,
                )
                .get();

            // Fetch exercise details and group them by date
            final List<ExerciseModel> exercises = await Future.wait(
              exerciseSnapshot.docs.map((exerciseDoc) async {
                final exerciseData = exerciseDoc.data();

                final setRef = exerciseDoc.reference.collection('sets');
                final setSnapshot = await setRef.get();

                final sets = setSnapshot.docs.map((setDoc) {
                  return SetModel.fromMap(setDoc.data());
                }).toList();

                // print(exerciseData);
                final exerciseModel = ExerciseModel.fromMap(exerciseData);
                print(exerciseModel.toMap());
                return exerciseModel.copyWith(sets: sets);
              }),
            );

            // Group exercises by `updatedAt` date

            for (final exercise in exercises) {
              if (exercise.updatedAt != null) {
                final String formattedDate = DateFormat('yyyy-MM-dd').format(
                  DateTime.fromMillisecondsSinceEpoch(exercise.updatedAt!),
                );
                groupedByDate
                    .putIfAbsent(formattedDate, () => [])
                    .add(exercise);
              }
            }

            // Create WorkoutHistoryModels for each date group
          }
        }
      }

      groupedByDate.forEach((date, exercisesForDate) {
        final DateTime workoutLogDate = DateFormat('yyyy-MM-dd').parse(date);

        allWorkoutHistories.add(
          WorkoutHistoryModel(
            workoutLogDate: workoutLogDate,
            exerciseModels: exercisesForDate,
          ),
        );
      });

      return allWorkoutHistories;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> logWorkoutHistory({
    required List<SetModel> sets,
    String? clientId,
    required String exerciseId,
    required String dayId,
    required String weekId,
    required String workoutPlanId,
  }) async {
    try {
      ///
      final clientUid = getIt<FirebaseAuth>().currentUser?.uid;

      ///
      final CollectionReference ref = db.collection('Users');
      WriteBatch batch = db.batch();

      ///
      final exerciseDocRef = ref
          .doc(clientId ?? clientUid)
          .collection('workoutPlans')
          .doc(workoutPlanId)
          .collection('weeks')
          .doc(weekId)
          .collection('days')
          .doc(dayId)
          .collection('exercises')
          .doc(exerciseId);

      // final exerciseMap =
      batch.set(
          exerciseDocRef,
          {
            'completed': true,
            'updatedAt': DateTime.now().millisecondsSinceEpoch
          },
          SetOptions(merge: true));

      ///
      for (final set in sets) {
        final setMap = set.toMap();
        setMap['setNumber'] = sets.indexOf(set) + 1;
        DocumentReference setRef = exerciseDocRef.collection('sets').doc(
              set.id.toString(),
            );
        batch.set(setRef, setMap, SetOptions(merge: true));
      }

      ///
      await batch.commit();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
