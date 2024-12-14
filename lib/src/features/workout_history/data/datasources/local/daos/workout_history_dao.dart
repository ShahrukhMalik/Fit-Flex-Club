import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
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
    required List<SetModel> setModel,
    required String clientUid,
    required String exerciseUid,
  }) async {
    return transaction(
      () async {
        await (update(workoutPlanExercise)
              ..where((tbl) => tbl.id.equals(exerciseUid)))
            .write(
          WorkoutPlanExerciseCompanion(
              completed: Value(true),
              updatedAt: Value(DateTime.now().millisecondsSinceEpoch)),
        );
        return batch(
          (batch) {
            batch.insertAll(
              workoutHistorySet,
              setModel.map(
                (setModel) => WorkoutHistorySetCompanion(
                  id: Value(setModel.id),
                  clientId: Value(clientUid),
                  exerciseId: Value(exerciseUid),
                  actualReps: Value(setModel.actualReps),
                  actualWeight: Value(setModel.actualWeight),
                  actualDistance: Value(setModel.actualDistance),
                  actualTime: Value(setModel.actualTime?.inMilliseconds),
                  createdAt: Value(DateTime.now().millisecondsSinceEpoch),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> insertWorkoutHistorySetFromRemote({
    required List<WorkoutHistoryModel> historyList,
  }) {
    return transaction(
      () async {
        // for (f)
        // await Future.wait(
        //   historyList.map(
        //     (history) async {
        for (final history in historyList) {
          for (final exercise in history.exerciseModels) {
            await batch(
              (batch) {
                batch.insertAll(
                  workoutHistorySet,
                  exercise.sets.map(
                    (setModel) => WorkoutHistorySetCompanion(
                      id: Value(setModel.id),
                      clientId: Value(setModel.clientId ?? ""),
                      exerciseId: Value(exercise.id!),
                      actualReps: Value(setModel.actualReps),
                      actualWeight: Value(setModel.actualWeight),
                      actualDistance: Value(setModel.actualDistance),
                      actualTime: Value(setModel.actualTime?.inMilliseconds),
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
          }
        }
        // },
        //   ),
        // );
      },
    );
  }

  Future<List<WorkoutHistoryModel>> getWorkoutHistoryModels(
    String clientUid,
  ) async {
    try {
      final historySet = await (select(workoutHistorySet)
            ..where(
              (tbl) => tbl.clientId.equals(clientUid),
            ))
          .get();

      if (historySet.isEmpty) return [];

      final exercisesWithBaseAndSets = await (select(workoutPlanExercise).join([
        innerJoin(
          baseExercise,
          baseExercise.code.equalsExp(workoutPlanExercise.code),
        ),
        innerJoin(
          exerciseSets,
          exerciseSets.exerciseId.equalsExp(workoutPlanExercise.id),
        ),
        // innerJoin(
        //   workoutHistorySet,
        //   exerciseSets.exerciseId.equalsExp(workoutPlanExercise.id),
        // ),
      ])
            ..where(
              workoutPlanExercise.clientId.equals(clientUid),
            )
            ..orderBy(
              [
                OrderingTerm(
                  expression: workoutPlanExercise.createdAt,
                  mode: OrderingMode.asc,
                ),
                OrderingTerm(
                  expression: exerciseSets.setNumber,
                  mode: OrderingMode.asc,
                ),
              ],
            ))
          .get();

      // Group exercises and sets by exercise ID
      final exerciseGroups = <String, Map<String, dynamic>>{};
      // Track unique sets per exercise
      final setIds = <String>{};
      for (final row in exercisesWithBaseAndSets) {
        final workoutExercise = row.readTable(workoutPlanExercise);
        final base = row.readTable(baseExercise);
        final exerciseSet = row.readTableOrNull(exerciseSets);
        final workoutHistoryList = historySet
            .where(
              (element) => element.id == exerciseSet?.id,
              // orElse: () => [],
            )
            .toList();

        // Initialize exercise group if not present
        if (!exerciseGroups.containsKey(workoutExercise.id)) {
          exerciseGroups[workoutExercise.id] = {
            'exercise': ExerciseModel(
              [],
              dayId: workoutExercise.dayId,
              completed: workoutExercise.completed,
              clientId: workoutExercise.clientId,
              id: workoutExercise.id,
              code: base.code,
              name: base.name,
              category: base.category,
              muscleGroup: base.muscleGroup,
              exerciseOrder: workoutExercise.exerciseOrder,
              createdAt: workoutExercise.createdAt,
              updatedAt: workoutExercise.updatedAt,
              parameters: {
                'weight': base.weight,
                'reps': base.reps,
                'duration': base.duration,
              },
            ),
            'sets': <SetModel>[],
          };
        }

        // Add unique sets
        if (exerciseSet != null && workoutHistoryList.isNotEmpty) {
          final workoutHistory = workoutHistoryList[0];
          // if (workoutExercise.id == workoutHistory.exerciseId &&
          //     workoutExercise.id == exerciseSet.exerciseId) {
          (exerciseGroups[workoutExercise.id]!['sets'] as List<SetModel>).add(
            SetModel(
              exerciseId: exerciseSet.exerciseId,
              id: workoutHistory.id,
              createdAt: workoutHistory.createdAt,
              actualDistance: workoutHistory.actualDistance,
              actualReps: workoutHistory.actualReps,
              actualTime: Duration(minutes: workoutHistory.actualTime ?? 0),
              actualWeight: workoutHistory.actualWeight,
              clientId: exerciseSet.clientId,
              targetDistance: exerciseSet.targetDistance,
              targetReps: exerciseSet.targetReps,
              targetWeight: exerciseSet.targetWeight,
              targetTime: Duration(minutes: exerciseSet.targetTime ?? 0),
            ),
          );
          // }
          // }
        }
      }

      // Combine exercises and their sets into a single ExerciseModel list
      final List<ExerciseModel> exercises = exerciseGroups.values.map((group) {
        final exercise = group['exercise'] as ExerciseModel;
        final sets = group['sets'] as List<SetModel>;
        // exercise.sets.addAll(sets);
        return exercise.copyWith(sets: sets);

        // return exercise;
      }).toList();

      // Group exercises by `createdAt` date
      final Map<String, List<ExerciseModel>> groupedByDate = {};
      for (final exercise in exercises) {
        final isHistory =
            exercise.updatedAt != null && (exercise.completed ?? false);
        if (isHistory) {
          final String formattedDate = DateFormat('yyyy-MM-dd').format(
            DateTime.fromMillisecondsSinceEpoch(exercise.updatedAt!),
          );
          groupedByDate.putIfAbsent(formattedDate, () => []).add(exercise);
        }
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
