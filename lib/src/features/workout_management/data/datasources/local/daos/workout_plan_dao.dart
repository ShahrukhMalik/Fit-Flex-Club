import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
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
  BaseExercise
])
@singleton
class WorkoutPlanDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutPlanDaoMixin {
  WorkoutPlanDao(super.attachedDatabase);
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
        cardioExercises: Value(workoutPlan.cardioExercises),
        muscleBuildingExercises: Value(workoutPlan.muscleBuildingExercises),
        totalExercises: Value(workoutPlan.totalExercises),
      ),
    );

    // Insert Weeks for the WorkoutPlan
    for (final week in workoutPlan.weeks) {
      await into(weeks).insert(
        WeeksCompanion(
          workoutPlanId: Value(workoutPlan.uid),
          weekNumber: Value(week.weekNumber),
        ),
      );

      // Insert Days for each Week
      for (final day in week.days) {
        await into(days).insert(
          DaysCompanion(
            weekId: Value(week.id),
            dayNumber: Value(day.dayNumber),
          ),
        );

        // Insert Exercises for each Day
        for (final exercise in day.exercises) {
          final exerciseId = await into(workoutPlanExercise).insert(
            WorkoutPlanExerciseCompanion(
              dayId: Value(day.id),
              code: Value(exercise.code!),
            ),
          );

          // Insert Sets for each Exercise
          for (final set in exercise.sets) {
            await into(exerciseSets).insert(
              ExerciseSetsCompanion(
                exerciseId: Value(exercise.id ?? ""),
                targetReps: Value(set.targetReps),
                targetWeight: Value(set.targetWeight),
                targetDistance: Value(set.targetDistance),
                targetTime: Value(set.targetTime?.inSeconds),
              ),
            );
          }
        }
      }
    }

    return workoutPlanId;
  }

  //
  Future<int> updateWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    final updatedWorkoutPlan = WorkoutPlansCompanion(
      name: Value(workoutPlan.name),
    );

    return (update(workoutPlans)
          ..where((plan) => plan.uid.equals(workoutPlan.uid)))
        .write(updatedWorkoutPlan);
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

  Future<List<WorkoutPlanModel>> getWorkoutPlans() async {
    try {
      // Fetch all workout plans
      final workoutPlansObj = await select(workoutPlans).get();

      // Use Future.wait to fetch all related data concurrently
      return await Future.wait(workoutPlansObj.map((plan) async {
        // Fetch weeks for the workout plan efficiently
        final weeksObj = await (select(weeks)
              ..where((week) => week.workoutPlanId.equals(plan.uid)))
            .get();

        // Fetch all days for these weeks in a single query
        final daysObj = await (select(days)
              ..where(
                  (day) => day.weekId.isIn(weeksObj.map((week) => week.id))))
            .get();

        // Fetch all exercises and sets for these days in a single join query
        final exercisesWithSets = await (select(workoutPlanExercise).join([
          leftOuterJoin(
            exerciseSets,
            exerciseSets.exerciseId.equalsExp(workoutPlanExercise.id),
          ),
        ])
              ..where(workoutPlanExercise.dayId
                  .isIn(daysObj.map((day) => day.id))))
            .get();

        // Group exercises and sets more efficiently
        final exerciseGroups = <String, Map<String, dynamic>>{};
        for (final row in exercisesWithSets) {
          final exercise = row.readTable(workoutPlanExercise);
          final exerciseSet = row.readTableOrNull(exerciseSets);

          if (!exerciseGroups.containsKey(exercise.id)) {
            exerciseGroups[exercise.id] = {
              'exercise': exercise,
              'sets': <SetModel>[],
            };
          }

          if (exerciseSet != null) {
            (exerciseGroups[exercise.id]!['sets'] as List<SetModel>).add(
              SetModel.fromMap(exerciseSet.toJson()),
            );
          }
        }

        // Transform data into models
        final exerciseModels = exerciseGroups.values.map((group) {
          final exercise = group['exercise'];
          return ExerciseModel(
            dayId: exercise.dayId,
            id: exercise.id,
            code: exercise.code,
            name: exercise.name,
            category: exercise.category,
            muscleGroup: exercise.muscleGroup,
            parameters: exercise.parameters,
            group['sets'],
          );
        }).toList();

        // Group exercises into days
        final dayModels = daysObj.map((day) {
          return DayModel(
            weekId: day.weekId,
            id: day.id,
            dayNumber: day.dayNumber,
            exercises: exerciseModels,
          );
        }).toList();

        // Group days into weeks
        final weekModels = weeksObj.map((week) {
          return WeekModel(
            workoutPlanId: week.workoutPlanId,
            id: week.id,
            weekNumber: week.weekNumber,
            days: dayModels,
          );
        }).toList();

        // Create final workout plan model
        return WorkoutPlanModel(
          cardioExercises: plan.cardioExercises,
          muscleBuildingExercises: plan.muscleBuildingExercises,
          totalExercises: plan.totalExercises,
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
