import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_bp_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
part 'workout_plan_dao.g.dart';

@DriftAccessor(
    tables: [WorkoutPlans, Weeks, Days, Exercises, ExerciseSets, ExerciseBp])
class WorkoutPlanDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutPlanDaoMixin {
  WorkoutPlanDao(super.db);

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
          workoutPlanUid: Value(workoutPlan.uid),
          weekNumber: Value(week.weekNumber),
        ),
      );

      // Insert Days for each Week
      for (final day in week.days) {
        await into(days).insert(
          DaysCompanion(
            weekUid: Value(week.id),
            dayNumber: Value(day.dayNumber),
          ),
        );

        // Insert Exercises for each Day
        for (final exercise in day.exercises) {
          final exerciseId = await into(exercises).insert(
            ExercisesCompanion(
              dayUid: Value(day.id),
              code: Value(exercise.code!),
            ),
          );

          // Insert Sets for each Exercise
          for (final set in exercise.sets) {
            await into(exerciseSets).insert(
              ExerciseSetsCompanion(
                exerciseUid: Value(exerciseId),
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
    final updatedExercise = ExercisesCompanion(
      code: exerciseModel.code == null
          ? const Value.absent()
          : Value(exerciseModel.code!),
    );

    return (update(exercises)
          ..where(
            (exercise) => exercise.id.equals(
              exerciseModel.id,
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
              ..where((week) => week.workoutPlanUid.equals(plan.uid)))
            .get();

        // Fetch all days for these weeks in a single query
        final daysObj = await (select(days)
              ..where(
                  (day) => day.weekUid.isIn(weeksObj.map((week) => week.id))))
            .get();

        // Fetch all exercises and sets for these days in a single join query
        final exercisesWithSets = await (select(exercises).join([
          leftOuterJoin(
            exerciseSets,
            exerciseSets.exerciseUid.equalsExp(exercises.id),
          ),
        ])
              ..where(exercises.dayUid.isIn(daysObj.map((day) => day.id))))
            .get();

        // Group exercises and sets more efficiently
        final exerciseGroups = <int, Map<String, dynamic>>{};
        for (final row in exercisesWithSets) {
          final exercise = row.readTable(exercises);
          final exerciseSet = row.readTableOrNull(exerciseSets);

          if (!exerciseGroups.containsKey(exercise.id)) {
            exerciseGroups[exercise.id] = {
              'exercise': exercise,
              'sets': <SetModel>[],
            };
          }

          if (exerciseSet != null) {
            (exerciseGroups[exercise.id]!['sets'] as List<SetModel>).add(
              SetModel.fromMap(exerciseSet.toColumns(false)),
            );
          }
        }

        // Transform data into models
        final exerciseModels = exerciseGroups.values.map((group) {
          final exercise = group['exercise'];
          return ExerciseModel(
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
            id: day.id,
            dayNumber: day.dayNumber,
            exercises: exerciseModels,
          );
        }).toList();

        // Group days into weeks
        final weekModels = weeksObj.map((week) {
          return WeekModel(
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
