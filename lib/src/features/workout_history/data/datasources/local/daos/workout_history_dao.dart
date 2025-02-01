import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/tables/workout_history_exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/tables/workout_history_set_table.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_bp_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
part 'workout_history_dao.g.dart';

@injectable
@DriftAccessor(tables: [
  WorkoutHistorySet,
  ExerciseSets,
  WorkoutPlanExercise,
  WorkoutHistoryExercise,
  BaseExercise
])
class WorkoutHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutHistoryDaoMixin {
  WorkoutHistoryDao(super.db);
  // Insert the WorkoutHistorySet entry
  Future<void> insertWorkoutHistorySet({
    required SetModel setModel,
    required String clientUid,
    required String exerciseUid,
  }) async {
    await into(workoutHistorySet).insert(
      WorkoutHistorySetCompanion(
        id: Value(setModel.id),
        clientId: Value(clientUid),
        exerciseId: Value(exerciseUid),
        actualReps: Value(setModel.actualReps),
        actualWeight: Value(setModel.actualWeight),
        actualDistance: Value(setModel.actualDistance),
        actualTime: Value(setModel.actualTime?.inMilliseconds),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> insertWorkoutHistorySets({
    required ExerciseModel exerciseModel,
  }) async {
    return transaction(
      () async {
        await (update(workoutPlanExercise)
              ..where((tbl) => tbl.id.equals(exerciseModel.id!)))
            .write(
          WorkoutPlanExerciseCompanion(
            completed: Value(true),
            updatedAt: Value(
              DateTime.now().millisecondsSinceEpoch,
            ),
          ),
        );

        await batch(
          (batch) {
            batch.insertAll(
              workoutHistorySet,
              exerciseModel.sets.map(
                (setModel) => WorkoutHistorySetCompanion(
                  id: Value(setModel.id),
                  clientId: Value(setModel.clientId ?? ''),
                  exerciseId: Value(exerciseModel.id ?? ''),
                  actualReps: Value(setModel.actualReps),
                  actualWeight: Value(setModel.actualWeight),
                  actualDistance: Value(setModel.actualDistance),
                  actualTime: Value(setModel.actualTime?.inMinutes),
                  targetDistance: Value(setModel.targetDistance),
                  targetReps: Value(setModel.targetReps),
                  targetTime: Value(setModel.targetTime?.inMinutes),
                  targetWeight: Value(setModel.targetWeight),
                ),
              ),
            );
          },
        );

        await into(workoutHistoryExercise).insert(
          WorkoutHistoryExerciseCompanion(
            reps: Value(exerciseModel.parameters?['reps']),
            weight: Value(exerciseModel.parameters?['weight']),
            duration: Value(exerciseModel.parameters?['duration']),
            name: Value(exerciseModel.name ?? ""),
            category: Value(exerciseModel.category ?? ""),
            muscleGroup: Value(exerciseModel.muscleGroup ?? ""),
            id: Value(exerciseModel.id ?? ""),
            clientId: Value(exerciseModel.clientId),
            code: Value(exerciseModel.code ?? ""),
            completed: Value(exerciseModel.completed ?? false),
            exerciseOrder: Value(exerciseModel.exerciseOrder ?? 0),
          ),
        );
      },
    );
  }

  Future<void> insertWorkoutHistorySetFromRemote({
    required List<WorkoutHistoryModel> historyList,
  }) {
    return transaction(
      () async {
        for (final history in historyList) {
          for (final exercise in history.exerciseModels) {
            await batch(
              (batch) {
                batch.insertAll(
                  workoutHistorySet,
                  exercise.sets.map(
                    (setModel) => WorkoutHistorySetCompanion(
                      id: Value(setModel.id),
                      createdAt: Value(setModel.createdAt ?? 0),
                      clientId: Value(setModel.clientId ?? ''),
                      exerciseId: Value(exercise.id ?? ''),
                      actualReps: Value(setModel.actualReps),
                      actualWeight: Value(setModel.actualWeight),
                      actualDistance: Value(setModel.actualDistance),
                      actualTime: Value(setModel.actualTime?.inMinutes),
                      targetDistance: Value(setModel.targetDistance),
                      targetReps: Value(setModel.targetReps),
                      targetTime: Value(setModel.targetTime?.inMinutes),
                      targetWeight: Value(setModel.targetWeight),
                    ),
                  ),
                );
              },
            );
            await (update(workoutPlanExercise)
                  ..where((tbl) => tbl.id.equals(exercise.id!)))
                .write(
              WorkoutPlanExerciseCompanion(
                completed: Value(true),
                updatedAt: Value(
                  exercise.updatedAt,
                ),
              ),
            );
            await into(workoutHistoryExercise).insert(
              WorkoutHistoryExerciseCompanion(
                createdAt: Value(exercise.createdAt ?? 0),
                reps: Value(exercise.parameters?['reps']),
                weight: Value(exercise.parameters?['weight']),
                duration: Value(exercise.parameters?['duration']),
                name: Value(exercise.name ?? ""),
                category: Value(exercise.category ?? ""),
                muscleGroup: Value(exercise.muscleGroup ?? ""),
                id: Value(exercise.id ?? ""),
                clientId: Value(exercise.clientId),
                code: Value(exercise.code ?? ""),
                completed: Value(exercise.completed ?? false),
                exerciseOrder: Value(exercise.exerciseOrder ?? 0),
              ),
            );
          }
        }
      },
    );
  }

  Future<List<WorkoutHistoryModel>> getWorkoutHistoryModels(
      String clientUid) async {
    try {
      // Fetch all exercises for the given client
      final exercises = await (select(workoutHistoryExercise)
            ..where((tbl) => tbl.clientId.equals(clientUid)))
          .get();

      // Fetch all sets for the given client
      final sets = await (select(workoutHistorySet)
            ..where((tbl) => tbl.clientId.equals(clientUid)))
          .get();

      if (exercises.isEmpty) return [];

      // Group sets by exerciseId
      final setsGroupedByExercise = <String, List<WorkoutHistorySetData>>{};
      for (final set in sets) {
        setsGroupedByExercise.putIfAbsent(set.exerciseId, () => []).add(set);
      }

      // Combine exercises and their sets
      final List<ExerciseModel> exerciseModels = exercises.map((exercise) {
        final exerciseSets = setsGroupedByExercise[exercise.id] ?? [];

        final List<SetModel> setModels = exerciseSets.map((set) {
          return SetModel(
            id: set.id,
            exerciseId: set.exerciseId,
            clientId: set.clientId,
            actualReps: set.actualReps,
            actualWeight: set.actualWeight,
            actualDistance: set.actualDistance,
            actualTime: Duration(seconds: set.actualTime ?? 0),
            targetReps: set.targetReps,
            targetWeight: set.targetWeight,
            targetDistance: set.targetDistance,
            targetTime: Duration(seconds: set.targetTime ?? 0),
            createdAt: set.createdAt,
          );
        }).toList();

        return ExerciseModel(

          dayId: '',
          parameters: {
            'duration': exercise.duration,
            'reps': exercise.reps,
            'weight': exercise.weight,
          },
          name: exercise.name,
          category: exercise.category,
          muscleGroup: exercise.muscleGroup,
          setModels,
          clientId: exercise.clientId,
          id: exercise.id,
          code: exercise.code,
          completed: exercise.completed,
          exerciseOrder: exercise.exerciseOrder,
          createdAt: exercise.createdAt,
          updatedAt: exercise.updatedAt,
        );
      }).toList();

      // Group exercises by `createdAt` date
      final Map<String, List<ExerciseModel>> groupedByDate = {};
      for (final exercise in exerciseModels) {
        final String formattedDate = DateFormat('yyyy-MM-dd').format(
          DateTime.fromMillisecondsSinceEpoch(exercise.createdAt!),
        );
        groupedByDate.putIfAbsent(formattedDate, () => []).add(exercise);
      }

      // Convert grouped data into WorkoutHistoryModel list
      final List<WorkoutHistoryModel> workoutHistoryModels =
          groupedByDate.entries.map(
        (entry) {
          final DateTime workoutLogDate =
              DateFormat('yyyy-MM-dd').parse(entry.key);
          return WorkoutHistoryModel(
            workoutLogDate: workoutLogDate,
            exerciseModels: entry.value,
          );
        },
      ).toList();

      return workoutHistoryModels;
    } catch (error) {
      throw Exception('Failed to fetch workout history: $error');
    }
  }
}
