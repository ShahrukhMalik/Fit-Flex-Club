import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';

part 'workout_plan_dao.g.dart';

@DriftAccessor(tables: [WorkoutPlans, Weeks, Days, Exercises, ExerciseSets])
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
              name: Value(exercise.name!),
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
                actualReps: Value(set.actualReps),
                actualWeight: Value(set.actualWeight),
                actualDistance: Value(set.actualDistance),
                actualTime: Value(set.actualTime?.inSeconds),
              ),
            );
          }
        }
      }
    }

    return workoutPlanId;
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
      actualReps: setModel.actualReps == null
          ? const Value.absent()
          : Value(setModel.actualReps),
      actualWeight: setModel.actualWeight == null
          ? const Value.absent()
          : Value(setModel.actualWeight),
      actualDistance: setModel.actualDistance == null
          ? const Value.absent()
          : Value(
              setModel.actualDistance,
            ),
      actualTime: setModel.actualTime == null
          ? const Value.absent()
          : Value(
              setModel.actualTime?.inSeconds,
            ),
    );

    // Perform the update query, filtering by the set ID
    return (update(exerciseSets)
          ..where((set) => set.id.equals(setModel.id))) // Filter by ID
        .write(updatedSet);
  }

  // Method to fetch hierarchical WorkoutPlans
  Future<List<WorkoutPlanModel>> getWorkoutPlans() async {
    // Get all workout plans
    final workoutPlansObj = await select(workoutPlans).get();

    // Map each WorkoutPlan to include its related hierarchy
    return Future.wait(workoutPlansObj.map((plan) async {
      // Fetch weeks for the workout plan
      final weeksObj = await (select(weeks)
            ..where((week) => week.workoutPlanUid.equals(plan.uid)))
          .get();

      // Map weeks to their days
      final weekModels = await Future.wait(weeksObj.map((week) async {
        final daysObj = await (select(days)
              ..where((day) => day.weekUid.equals(week.id)))
            .get();

        // Map days to their exercises
        final dayModels = await Future.wait(daysObj.map((day) async {
          final exercisesObj = await (select(exercises)
                ..where((exercise) => exercise.dayUid.equals(day.id)))
              .get();

          // Map exercises to their sets
          final exerciseModels =
              await Future.wait(exercisesObj.map((exercise) async {
            final setsObj = await (select(exerciseSets)
                  ..where((set) => set.exerciseUid.equals(exercise.id)))
                .get();

            return ExerciseModel(
              id: exercise.id,
              setsObj
                  .map((set) => SetModel.fromMap(set.toColumns(false)))
                  .toList(),
              code: exercise.code,
              name: exercise.name,
            );
          }).toList());

          return DayModel(
            id: day.id,
            dayNumber: day.dayNumber,
            exercises: exerciseModels,
          );
        }).toList());

        return WeekModel(
          id: week.id,
          weekNumber: week.weekNumber,
          days: dayModels,
        );
      }).toList());

      return WorkoutPlanModel(
        name: plan.name,
        weeks: weekModels,
        uid: plan.uid,
      );
    }).toList());
  }
}
