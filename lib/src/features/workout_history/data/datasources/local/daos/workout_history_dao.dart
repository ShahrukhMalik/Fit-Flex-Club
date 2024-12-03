import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/tables/workout_history_set_table.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
part 'workout_history_dao.g.dart';

@DriftAccessor(tables: [WorkoutHistorySet, ExerciseSets, Exercises])
class WorkoutHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutHistoryDaoMixin {
  WorkoutHistoryDao(super.db);
  // Insert the WorkoutHistorySet entry
  Future<void> insertWorkoutHistorySet({
    required SetModel setModel,
    required String clientUid,
    required int exerciseUid,
  }) async {
    await into(workoutHistorySet).insert(
      WorkoutHistorySetCompanion(
        clientUid: Value(clientUid),
        exerciseUid: Value(exerciseUid),
        actualReps: Value(setModel.actualReps),
        actualWeight: Value(setModel.actualWeight),
        actualDistance: Value(setModel.actualDistance),
        actualTime: Value(setModel.actualTime?.inMilliseconds),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<List<WorkoutHistoryModel>> getWorkoutHistoryModels(
    String clientUid,
  ) async {
    // Perform inner joins to fetch related data
    final query = select(workoutHistorySet).join([
      innerJoin(
        exerciseSets,
        exerciseSets.id.equalsExp(workoutHistorySet.exerciseUid),
      ),
      innerJoin(
        exercises,
        exercises.id.equalsExp(exerciseSets.exerciseUid),
      ),
    ])
      ..where(workoutHistorySet.clientUid.equals(clientUid));

    // Execute query
    final results = await query.get();

    // Map results into a structure grouped by workoutLogDate
    final groupedByDate = <DateTime, List<Map<String, dynamic>>>{};

    for (final row in results) {
      final workoutHistory = row.readTable(workoutHistorySet);
      final exercise = row.readTable(exercises);
      final exerciseSet = row.readTable(exerciseSets);

      final workoutLogDate = DateTime.fromMillisecondsSinceEpoch(
        workoutHistory.createdAt,
      );

      // Group data by workoutLogDate
      groupedByDate.putIfAbsent(workoutLogDate, () => []).add({
        ...exercise.toJson(),
        'sets': exerciseSet.toJson(),
      });
    }

    // Convert grouped data to a list of WorkoutHistoryModel
    final workoutHistoryModels = groupedByDate.entries.map((entry) {
      final workoutLogDate = entry.key;
      final exercises = entry.value;

      // Map exercises to ExerciseModel
      final exerciseModels = exercises.map((exerciseData) {
        final sets = (exerciseData['sets'] as List)
            .map((set) => SetModel.fromMap(set))
            .toList();

        return ExerciseModel(
          sets,
          id: exerciseData['id'],
          name: exerciseData['name'],
          code: exerciseData['code'],
        );
      }).toList();

      return WorkoutHistoryModel.forEachElement(workoutLogDate, exerciseModels);
    }).toList();

    return workoutHistoryModels;
  }
}
