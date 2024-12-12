import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/tables/workout_history_set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_bp_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid_v4/uuid_v4.dart';
part 'workout_plan_dao.g.dart';

@DriftAccessor(tables: [
  WorkoutPlans,
  Weeks,
  Days,
  WorkoutPlanExercise,
  ExerciseSets,
  BaseExercise,
  Clients,
  WorkoutHistorySet
])
@singleton
class WorkoutPlanDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutPlanDaoMixin {
  WorkoutPlanDao(super.attachedDatabase);
  Future<void> updateWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    try {
      // Start a transaction to ensure atomicity
      await transaction(
        () async {
          // Update the WorkoutPlan details
          await (update(workoutPlans)
                ..where((tbl) => tbl.uid.equals(workoutPlan.uid)))
              .write(
            WorkoutPlansCompanion(
              name: Value(workoutPlan.name),
              updatedAt: Value(
                workoutPlan.updatedAt ?? DateTime.now().millisecondsSinceEpoch,
              ),
            ),
          );

          // Fetch existing exercises and sets for comparison
          final existingExercises = await (select(workoutPlanExercise)
                ..where((tbl) => tbl.dayId.isIn(workoutPlan.weeks
                    .expand((week) => week.days)
                    .map((day) => day.id))))
              .get();

          final existingSets = await (select(exerciseSets)
                ..where((tbl) => tbl.exerciseId
                    .isIn(existingExercises.map((exercise) => exercise.id))))
              .get();

          // Manage Exercises
          final updatedExerciseIds = workoutPlan.weeks
              .expand((week) => week.days)
              .expand((day) => day.exercises)
              .map((exercise) => exercise.id)
              .toSet();

          for (final week in workoutPlan.weeks) {
            for (final day in week.days) {
              for (final exercise in day.exercises) {
                if (!existingExercises
                    .any((existing) => existing.id == exercise.id)) {
                  // Insert new exercise
                  await into(workoutPlanExercise).insert(
                    WorkoutPlanExerciseCompanion(
                      dayId: Value(day.id),
                      code: Value(exercise.code!),
                      id: Value(exercise.id!),
                      exerciseOrder: Value(
                        day.exercises.indexOf(exercise) + 1,
                      ),
                    ),
                  );
                }
              }
            }
          }

// Delete removed exercises and their corresponding sets
          final removedExercises = existingExercises
              .where((exercise) => !updatedExerciseIds.contains(exercise.id));
          for (final removedExercise in removedExercises) {
            // Delete associated sets first
            await (delete(exerciseSets)
                  ..where((tbl) => tbl.exerciseId.equals(removedExercise.id)))
                .go();

            // Delete the exercise
            await (delete(workoutPlanExercise)
                  ..where((tbl) => tbl.id.equals(removedExercise.id)))
                .go();
          }
          // Manage Sets for each Exercise
          for (final exercise in workoutPlan.weeks
              .expand((week) => week.days)
              .expand((day) => day.exercises)) {
            final updatedSetIds = exercise.sets.map((set) => set.id).toSet();

            // Insert or update sets
            for (final set in exercise.sets) {
              if (existingSets.any((existing) => existing.id == set.id)) {
                // Update existing set
                await (update(exerciseSets)
                      ..where((tbl) => tbl.id.equals(set.id)))
                    .write(
                  ExerciseSetsCompanion(
                    targetReps: Value(set.targetReps),
                    targetWeight: Value(set.targetWeight),
                    targetDistance: Value(set.targetDistance),
                    targetTime: Value(set.targetTime?.inSeconds),
                    exerciseId: Value(exercise.id!),
                    id: Value(set.id),
                    updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
                    setNumber: Value(exercise.sets.indexOf(set) + 1),
                  ),
                );
              } else {
                // Insert new set
                await into(exerciseSets).insert(
                  ExerciseSetsCompanion(
                    exerciseId: Value(exercise.id!),
                    targetReps: Value(set.targetReps),
                    targetWeight: Value(set.targetWeight),
                    targetDistance: Value(set.targetDistance),
                    targetTime: Value(set.targetTime?.inSeconds),
                    id: Value(set.id),
                    setNumber: Value(exercise.sets.indexOf(set) + 1),
                  ),
                );
              }
            }

            // Delete removed sets
            final removedSets = existingSets
                .where((set) => set.exerciseId == exercise.id)
                .where((set) => !updatedSetIds.contains(set.id));
            for (final removedSet in removedSets) {
              await (delete(exerciseSets)
                    ..where((tbl) => tbl.id.equals(removedSet.id)))
                  .go();
            }
          }
        },
      );
    } catch (e) {
      // Handle errors
      print('Error updating workout plan: $e');
      rethrow;
    }
  }

  Future<List<int>> insertExerciseBps(List<ExerciseBpModel> exercisesBp) async {
    final insertedIds = <int>[];

    try {
      for (final exercise in exercisesBp) {
        // Ensure exerciseBp.parameters is not null, and provide a default empty map if it is.
        final parameters = exercise.parameters ?? {};

        // Extract values safely from the parameters map
        final reps = parameters['reps'];
        final duration = parameters['duration'];
        final weight = parameters['weight'];

        // Insert the exercise
        final id = await into(baseExercise).insert(
          BaseExerciseCompanion(
            id: Value(exercise.id ?? UUIDv4().toString()),
            code:
                exercise.code == null ? Value.absent() : Value(exercise.code!),
            category: exercise.category == null
                ? Value.absent()
                : Value(exercise.category!),
            muscleGroup: exercise.muscleGroup == null
                ? Value.absent()
                : Value(exercise.muscleGroup!),
            name:
                exercise.name == null ? Value.absent() : Value(exercise.name!),
            reps: reps == null ? Value.absent() : Value(reps),
            duration: duration == null ? Value.absent() : Value(duration),
            weight: weight == null ? Value.absent() : Value(weight),
            createdAt: Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );

        insertedIds.add(id);
      }
      return insertedIds;
    } catch (e) {
      print('Error inserting ExerciseBp: $e');
      rethrow;
    }
  }

  Future<List<BaseExerciseData>> getAllExercises() async {
    try {
      // Fetch all exercises from the database
      final exercisesList = await select(baseExercise).get();

      return exercisesList;
    } catch (e) {
      print('Error fetching exercises: $e');
      rethrow;
    }
  }

  //
  Future<List<int>> insertWorkoutPlans(
    List<WorkoutPlanModel> workoutPlans,
  ) async {
    final insertedIds = <int>[];

    for (final workoutPlan in workoutPlans) {
      final workoutPlanId = await insertWorkoutPlan(workoutPlan);
      insertedIds.add(workoutPlanId);
    }

    return insertedIds;
  }

  //
  Future<int> insertWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    // Insert the WorkoutPlan into the workoutPlans table

    final workoutPlanId = await into(workoutPlans).insert(
      WorkoutPlansCompanion(
        uid: Value(workoutPlan.uid),
        name: Value(workoutPlan.name),
        createdAt: Value(
          DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );

    if (workoutPlan.clientId != null) return Future.value(0);
    // Insert Weeks for the WorkoutPlan
    for (final week in workoutPlan.weeks) {
      await into(weeks).insert(
        WeeksCompanion(
          workoutPlanId: Value(workoutPlan.uid),
          weekNumber: Value(week.weekNumber),
          id: Value(week.id),
        ),
      );

      // Insert Days for each Week
      for (final day in week.days) {
        await into(days).insert(
          DaysCompanion(
            weekId: Value(week.id),
            dayNumber: Value(day.dayNumber),
            id: Value(day.id),
          ),
        );

        // Insert Exercises for each Day
        for (final exercise in day.exercises) {
          final exerciseId = await into(workoutPlanExercise).insert(
            WorkoutPlanExerciseCompanion(
              exerciseOrder: Value(day.exercises.indexOf(exercise) + 1),
              dayId: Value(day.id),
              code: Value(exercise.code!),
              id: Value(
                exercise.id!,
              ),
            ),
          );

          // Insert Sets for each Exercise
          for (final set in exercise.sets) {
            await into(exerciseSets).insert(
              ExerciseSetsCompanion(
                exerciseId: Value(exercise.id!),
                targetReps: Value(set.targetReps),
                targetWeight: Value(set.targetWeight),
                targetDistance: Value(set.targetDistance),
                targetTime: Value(set.targetTime?.inSeconds),
                id: Value(set.id),
                setNumber: Value(
                  exercise.sets.indexOf(set) + 1,
                ),
              ),
            );
          }
        }
      }
    }

    return workoutPlanId;
  }

  Future<void> deleteWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    try {
      final workoutPlanId = workoutPlan.uid;

      await transaction(() async {
        await (update(clients)
              ..where((tbl) => tbl.id.equals(workoutPlan.clientId!)))
            .write(
          ClientsCompanion(
            currentWorkoutPlanName: Value.absent(),
          ),
        );
        await (delete(workoutPlans)
              ..where((tbl) => tbl.uid.equals(workoutPlanId)))
            .go();

        await Future.wait(
          workoutPlan.weeks.map(
            (week) async {
              await (delete(weeks)
                    ..where((tbl) => tbl.workoutPlanId.equals(workoutPlanId)))
                  .go();
              week.days.map(
                (day) async {
                  await (delete(days)
                        ..where((tbl) => tbl.weekId.equals(week.id)))
                      .go();

                  day.exercises.map(
                    (exercise) async {
                      await (delete(workoutPlanExercise)
                            ..where((tbl) => tbl.dayId.equals(day.id)))
                          .go();
                      exercise.sets.map(
                        (set) async {
                          await (delete(exerciseSets)
                                ..where((tbl) =>
                                    tbl.exerciseId.equals(exercise.id!)))
                              .go();
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        );
        // // Step 1: Delete exercise sets associated with the workout plan
        // final exercises = await (select(workoutPlanExercise)
        //       ..where((tbl) => tbl.dayId.isInQuery(
        //             select(days)
        //               ..where((tbl) => tbl.weekId.isInQuery(
        //                     select(weeks)
        //                       ..where((tbl) =>
        //                           tbl.workoutPlanId.equals(workoutPlanId)),
        //                   )),
        //           )))
        //     .get();

        // for (final exercise in exercises) {
        //   await (delete(exerciseSets)
        //         ..where((tbl) => tbl.exerciseId.equals(exercise.id)))
        //       .go();
        // }

        // // Step 2: Delete exercises associated with the workout plan
        // await (delete(workoutPlanExercise)
        //       ..where((tbl) => tbl.dayId.isInQuery(
        //             select(days)
        //               ..where((tbl) => tbl.weekId.isInQuery(
        //                     select(weeks)
        //                       ..where((tbl) =>
        //                           tbl.workoutPlanId.equals(workoutPlanId)),
        //                   )),
        //           )))
        //     .go();

        // // Step 3: Delete days associated with the workout plan
        // await (delete(days)
        //       ..where((tbl) => tbl.weekId.isInQuery(
        //             select(weeks)
        //               ..where((tbl) => tbl.workoutPlanId.equals(workoutPlanId)),
        //           )))
        //     .go();

        // // Step 4: Delete weeks associated with the workout plan
        // await (delete(weeks)
        //       ..where((tbl) => tbl.workoutPlanId.equals(workoutPlanId)))
        //     .go();

        // // Step 5: Delete the workout plan itself
      });
    } catch (err) {
      print(err);
    }
  }

  //
  Future<int> assignWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    // Update client assigned workout plan name
    await (update(clients)
          ..where((tbl) => tbl.id.equals(workoutPlan.clientId!)))
        .write(
      ClientsCompanion(
        currentWorkoutPlanName: Value(
          workoutPlan.name,
        ),
      ),
    );
    // Insert the WorkoutPlan into the workoutPlans table
    final workoutPlanId = await into(workoutPlans).insert(
      WorkoutPlansCompanion(
        clientId: Value(workoutPlan.clientId),
        uid: Value(workoutPlan.uid),
        name: Value(workoutPlan.name),
        createdAt: Value(
          DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );

    // Insert Weeks for the WorkoutPlan
    for (final week in workoutPlan.weeks) {
      await into(weeks).insert(
        WeeksCompanion(
          clientId: Value(week.clientId),
          workoutPlanId: Value(workoutPlan.uid),
          weekNumber: Value(week.weekNumber),
          id: Value(week.id),
        ),
      );

      // Insert Days for each Week
      for (final day in week.days) {
        await into(days).insert(
          DaysCompanion(
            weekId: Value(week.id),
            dayNumber: Value(day.dayNumber),
            id: Value(day.id),
            clientId: Value(day.clientId),
          ),
        );

        // Insert Exercises for each Day
        for (final exercise in day.exercises) {
          final exerciseId = await into(workoutPlanExercise).insert(
            WorkoutPlanExerciseCompanion(
              clientId: Value(exercise.clientId),
              exerciseOrder: Value(day.exercises.indexOf(exercise) + 1),
              dayId: Value(day.id),
              code: Value(exercise.code!),
              id: Value(
                exercise.id!,
              ),
            ),
          );

          // Insert Sets for each Exercise
          for (final set in exercise.sets) {
            await into(exerciseSets).insert(
              ExerciseSetsCompanion(
                clientId: Value(set.clientId),
                exerciseId: Value(exercise.id!),
                targetReps: Value(set.targetReps),
                targetWeight: Value(set.targetWeight),
                targetDistance: Value(set.targetDistance),
                targetTime: Value(set.targetTime?.inSeconds),
                id: Value(set.id),
                setNumber: Value(
                  exercise.sets.indexOf(set) + 1,
                ),
              ),
            );
          }
        }
      }
    }

    return workoutPlanId;
  }

  //
  Future<int> updateExercise(ExerciseModel exerciseModel) async {
    final updatedExercise = WorkoutPlanExerciseCompanion(
      code: exerciseModel.code == null
          ? const Value.absent()
          : Value(exerciseModel.code!),
    );

    return (update(workoutPlanExercise)
          ..where(
            (exercise) => exercise.id.equals(
              exerciseModel.id ?? "",
            ),
          ))
        .write(updatedExercise);
  }

  //
  Future<int> updateSetUsingModel(SetModel setModel) async {
    // Build the companion only with non-null fields
    final updatedSet = ExerciseSetsCompanion(
      targetReps: setModel.targetReps == null
          ? const Value.absent()
          : Value(setModel.targetReps),
      targetWeight: setModel.targetWeight == null
          ? const Value.absent()
          : Value(setModel.targetWeight),
      targetDistance: setModel.targetDistance == null
          ? const Value.absent()
          : Value(setModel.targetDistance),
      targetTime: setModel.targetTime == null
          ? const Value.absent()
          : Value(setModel.targetTime?.inSeconds),
    );

    // Perform the update query, filtering by the set ID
    return (update(exerciseSets)
          ..where((set) => set.id.equals(setModel.id))) // Filter by ID
        .write(updatedSet);
  }

  Future<WorkoutPlanModel?> getWorkoutPlanForClient(String clientId) async {
    try {
      // Fetch all workout plans
      final workoutPlansList = await (select(workoutPlans)
            ..where((tbl) => tbl.clientId.equals(clientId)))
          .get();

      if (workoutPlansList.isNotEmpty) {
        // Use Future.wait to fetch all related data concurrently
        // return await Future.wait(workoutPlansObj.map((plan) async {
        // Fetch weeks for the workout plan efficiently
        final weeksObj = await (select(weeks)
              ..where(
                  (week) => week.workoutPlanId.equals(workoutPlansList[0].uid))
              ..orderBy([(week) => OrderingTerm(expression: week.weekNumber)]))
            .get();

        // Fetch all days for these weeks in a single query
        final daysObj = await (select(days)
              ..where((day) => day.weekId.isIn(weeksObj.map((week) => week.id)))
              ..orderBy([(day) => OrderingTerm(expression: day.dayNumber)]))
            .get();

        final exercisesWithBaseAndSets =
            await (select(workoutPlanExercise).join([
          innerJoin(
            baseExercise,
            baseExercise.code.equalsExp(workoutPlanExercise.code),
          ),
          leftOuterJoin(
            exerciseSets,
            exerciseSets.exerciseId.equalsExp(workoutPlanExercise.id),
          ),
          leftOuterJoin(
            workoutHistorySet,
            exerciseSets.exerciseId.equalsExp(workoutPlanExercise.id),
          ),
        ])
                  ..where(
                    workoutPlanExercise.dayId
                        .isIn(daysObj.map((day) => day.id)),
                  )
                  ..orderBy(
                    [
                      OrderingTerm(
                        expression: workoutPlanExercise.exerciseOrder,
                        mode: OrderingMode
                            .asc, // Ascending order (optional, default is ascending)
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
        for (final row in exercisesWithBaseAndSets) {
          final workoutExercise = row.readTable(workoutPlanExercise);
          final base = row.readTable(baseExercise);
          final exerciseSet = row.readTableOrNull(exerciseSets);

          if (!exerciseGroups.containsKey(workoutExercise.id)) {
            exerciseGroups[workoutExercise.id] = {
              'exercise': ExerciseModel(
                clientId: workoutExercise.clientId,
                dayId: workoutExercise.dayId,
                id: workoutExercise.id,
                code: base.code,
                name: base.name,
                category: base.category,
                muscleGroup: base.muscleGroup,
                exerciseOrder: workoutExercise.exerciseOrder,
                parameters: {
                  'weight': base.weight,
                  'reps': base.reps,
                  'duration': base.duration,
                },
                [],
              ),
              'sets': <SetModel>[],
            };
          }

          if (exerciseSet != null) {
            (exerciseGroups[workoutExercise.id]!['sets'] as List<SetModel>).add(
              SetModel.fromMap(exerciseSet.toJson()),
            );
          }
        }

        // Group exercises by dayId
        final exercisesGroupedByDay = <String, List<ExerciseModel>>{};
        for (final group in exerciseGroups.values) {
          final exercise = group['exercise'] as ExerciseModel;
          final sets = group['sets'] as List<SetModel>;
          final finalExercise = exercise.copyWith(sets: sets);
          exercisesGroupedByDay
              .putIfAbsent(exercise.dayId, () => [])
              .add(finalExercise);
        }

        // Map days to models, attaching exercises
        final dayModels = daysObj.map((day) {
          return DayModel(
            clientId: day.clientId,
            weekId: day.weekId,
            id: day.id,
            dayNumber: day.dayNumber,
            exercises: exercisesGroupedByDay[day.id] ?? [],
          );
        }).toList();

        // Map weeks to models, attaching days
        final weekModels = weeksObj.map((week) {
          return WeekModel(
            clientId: week.clientId,
            workoutPlanId: week.workoutPlanId,
            id: week.id,
            weekNumber: week.weekNumber,
            days: dayModels
                .where((day) => day.weekId == week.id)
                .toList(), // Filter days belonging to the week
          );
        }).toList();

        // Create and return the final workout plan model
        return WorkoutPlanModel(
          clientId: workoutPlansList[0].clientId,
          createdAt: workoutPlansList[0].createdAt,
          updatedAt: workoutPlansList[0].updatedAt,
          name: workoutPlansList[0].name,
          weeks: weekModels,
          uid: workoutPlansList[0].uid,
        );
      } else {
        return null;
      }
      // }).toList());
    } catch (e) {
      // Add proper error handling
      print('Error fetching workout plans: $e');
      rethrow;
    }
  }

  Future<List<WorkoutPlanModel>> getWorkoutPlans() async {
    try {
      // Fetch all workout plans
      final workoutPlansObj = await (select(workoutPlans)
            ..where((tbl) => tbl.clientId.isNull()))
          .get();

      // Use Future.wait to fetch all related data concurrently
      return await Future.wait(workoutPlansObj.map((plan) async {
        // Fetch weeks for the workout plan efficiently
        final weeksObj = await (select(weeks)
              ..where((week) => week.workoutPlanId.equals(plan.uid))
              ..orderBy([(week) => OrderingTerm(expression: week.weekNumber)]))
            .get();

        // Fetch all days for these weeks in a single query
        final daysObj = await (select(days)
              ..where((day) => day.weekId.isIn(weeksObj.map((week) => week.id)))
              ..orderBy([(day) => OrderingTerm(expression: day.dayNumber)]))
            .get();

        final exercisesWithBaseAndSets =
            await (select(workoutPlanExercise).join([
          innerJoin(
            baseExercise,
            baseExercise.code.equalsExp(workoutPlanExercise.code),
          ),
          leftOuterJoin(
            exerciseSets,
            exerciseSets.exerciseId.equalsExp(workoutPlanExercise.id),
          ),
        ])
                  ..where(
                    workoutPlanExercise.dayId
                        .isIn(daysObj.map((day) => day.id)),
                  )
                  ..orderBy(
                    [
                      OrderingTerm(
                        expression: workoutPlanExercise.exerciseOrder,
                        mode: OrderingMode
                            .asc, // Ascending order (optional, default is ascending)
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
        for (final row in exercisesWithBaseAndSets) {
          final workoutExercise = row.readTable(workoutPlanExercise);
          final base = row.readTable(baseExercise);
          final exerciseSet = row.readTableOrNull(exerciseSets);

          if (!exerciseGroups.containsKey(workoutExercise.id)) {
            exerciseGroups[workoutExercise.id] = {
              'exercise': ExerciseModel(
                dayId: workoutExercise.dayId,
                id: workoutExercise.id,
                code: base.code,
                name: base.name,
                category: base.category,
                muscleGroup: base.muscleGroup,
                exerciseOrder: workoutExercise.exerciseOrder,
                parameters: {
                  'weight': base.weight,
                  'reps': base.reps,
                  'duration': base.duration,
                },
                [],
              ),
              'sets': <SetModel>[],
            };
          }

          if (exerciseSet != null) {
            (exerciseGroups[workoutExercise.id]!['sets'] as List<SetModel>).add(
              SetModel.fromMap(exerciseSet.toJson()),
            );
          }
        }

        // Group exercises by dayId
        final exercisesGroupedByDay = <String, List<ExerciseModel>>{};
        for (final group in exerciseGroups.values) {
          final exercise = group['exercise'] as ExerciseModel;
          final sets = group['sets'] as List<SetModel>;
          final finalExercise = exercise.copyWith(sets: sets);
          exercisesGroupedByDay
              .putIfAbsent(exercise.dayId, () => [])
              .add(finalExercise);
        }

        // Map days to models, attaching exercises
        final dayModels = daysObj.map((day) {
          return DayModel(
            weekId: day.weekId,
            id: day.id,
            dayNumber: day.dayNumber,
            exercises: exercisesGroupedByDay[day.id] ?? [],
          );
        }).toList();

        // Map weeks to models, attaching days
        final weekModels = weeksObj.map((week) {
          return WeekModel(
            workoutPlanId: week.workoutPlanId,
            id: week.id,
            weekNumber: week.weekNumber,
            days: dayModels
                .where((day) => day.weekId == week.id)
                .toList(), // Filter days belonging to the week
          );
        }).toList();

        // Create and return the final workout plan model
        return WorkoutPlanModel(
          createdAt: plan.createdAt,
          updatedAt: plan.updatedAt,
          name: plan.name,
          weeks: weekModels,
          uid: plan.uid,
        );
      }).toList());
    } catch (e) {
      // Add proper error handling
      print('Error fetching workout plans: $e');
      rethrow;
    }
  }
}
