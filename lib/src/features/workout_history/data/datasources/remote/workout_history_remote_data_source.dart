import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

abstract class WorkoutHistoryRemoteDataSource {
  ///
  Future<void> logWorkoutHistory({
    required List<SetModel> sets,
    String? clientId,
    required String exerciseId,

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
      final workoutHistorySnapshot = await ref
          .doc(clientUid ?? clientId)
          .collection('workoutHistory')
          .get();
      final Map<String, List<ExerciseModel>> groupedByDate = {};

      final List<WorkoutHistoryModel> allWorkoutHistories = [];

      final List<ExerciseModel> exercises = await Future.wait(
        workoutHistorySnapshot.docs.map((exerciseDoc) async {
          final exerciseData = exerciseDoc.data();
          final exerciseModel = ExerciseModel.fromMap(exerciseData);
          return exerciseModel;
        }),
      );

      // Group exercises by `updatedAt` date

      for (final exercise in exercises) {
        if (exercise.updatedAt != null) {
          final String formattedDate = DateFormat('yyyy-MM-dd').format(
            DateTime.fromMillisecondsSinceEpoch(exercise.updatedAt!),
          );
          groupedByDate.putIfAbsent(formattedDate, () => []).add(exercise);
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

  }) async {
    try {
      ///
      final clientUid = getIt<FirebaseAuth>().currentUser?.uid;

      ///
      final CollectionReference ref = db.collection('Users');
      WriteBatch batch = db.batch();

      ///
      final historyCollection =
          ref.doc(clientId ?? clientUid).collection('workoutHistory');

      final documents =
          await ref.doc(clientUid).collection('workoutPlans').get();

      // Using await in the map to ensure async calls complete
      // if (documents.exists) {
      final workoutPlanData = documents.docs.first.data();
      //
      final workoutPlanModel = WorkoutPlanModel.fromMap(
        workoutPlanData,
      );
      // return workoutPlanModel;
      final updatedWeeks = workoutPlanModel.weeks.map((week) {
        return week.copyWith(
          days: week.days.map((day) {
            return day.copyWith(
              exercises: day.exercises.map((exercise) {
                if (exercise.id == exerciseId) {
                  return exercise.copyWith(
                    completed: true,
                    updatedAt: DateTime.now().millisecondsSinceEpoch,
                    sets: sets,
                  );
                }
                return exercise;
              }).toList(),
            );
          }).toList(),
        );
      }).toList();

      final updatedWorkoutPlan = workoutPlanModel.copyWith(
        weeks: updatedWeeks,
      );

      batch.set(
        documents.docs.first.reference,
        updatedWorkoutPlan.toMap(),
        SetOptions(merge: true),
      );
      final completedExercise = updatedWorkoutPlan.weeks
          .expand((week) => week.days.expand((day) => day.exercises.where(
                (element) => element.completed ?? false,
              )))
          .firstWhere(
            (element) => element.id == exerciseId,
          );

      batch.set(
        historyCollection.doc(completedExercise.id),
        completedExercise.toMap(),
        SetOptions(
          merge: true,
        ),
      );
      // }

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
