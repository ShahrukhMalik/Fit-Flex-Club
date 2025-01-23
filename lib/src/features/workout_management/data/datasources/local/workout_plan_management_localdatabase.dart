import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/functions/is_data_stale.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/daos/workout_plan_dao.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class WorkoutPlanManagementLocaldatasource {
  ///
  Future<Either<bool, List<WorkoutPlanModel>>>? getWorkoutPlans();

  ///
  Future<Either<bool, WorkoutPlanModel?>>? getWorkoutPlanForClient(
      String clientId);

  ///
  Future<void> insertWorkoutPlans(List<WorkoutPlanModel> workoutPlans);

  ///
  Future<int> insertWorkoutPlan(WorkoutPlanModel workoutPlan);

  ///
  Future<int> assignWorkoutPlan(WorkoutPlanModel workoutPlan);

  ///
  Future<void> updateWorkoutPlan(WorkoutPlanModel workoutPlan);

  ///
  Future<void> deleteWorkoutPlan(WorkoutPlanModel workoutPlan);

  ///
  Future<void> deleteAssignedWorkoutPlan(WorkoutPlanModel workoutPlan);

  ///
  Future<Either<bool, List<ExerciseBpModel>?>?> getExercises();

  ///
  Future<void> insertExercises(List<ExerciseBpModel> exercises);
}

@Singleton(as: WorkoutPlanManagementLocaldatasource)
class WorkoutPlanManagementLocaldatasourceImpl
    extends WorkoutPlanManagementLocaldatasource {
  final WorkoutPlanDao dao;
  final AppDatabase database;

  WorkoutPlanManagementLocaldatasourceImpl({
    required this.dao,
    required this.database,
  });
  @override
  Future<Either<bool, List<WorkoutPlanModel>>>? getWorkoutPlans() async {
    try {
      final workoutPlans = await dao.getWorkoutPlans();
      if (workoutPlans.isEmpty) {
        return Left(false);
      }
      if (isDataStale(
        Duration(seconds: 1).inSeconds,
        workoutPlans.first.createdAt!,
        workoutPlans.first.updatedAt,
      )) {
        await database.deleteWorkoutPlans();
        return Left(true);
      }
      return Right(workoutPlans);
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertWorkoutPlans(workoutPlans) async {
    try {
      final result = await dao.insertWorkoutPlans(workoutPlans);
      return Future.value(null);
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<int> insertWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    try {
      final result = await dao.insertWorkoutPlan(workoutPlan);
      // ignore: void_checks
      return Future.value(result);
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<Either<bool, List<ExerciseBpModel>?>?> getExercises() async {
    try {
      final exercises = await dao.getAllExercises();
      if (exercises.isEmpty) {
        return Left(false);
      }
      if (isDataStale(
        Duration(days: 1).inSeconds,
        exercises.first.createdAt,
        exercises.first.updatedAt,
      )) {
        await database.deleteExercises();
        return Left(true);
      }
      return Right(
        exercises
            .map((e) => ExerciseBpModel(
              gifUrl: e.gifUrl,
                  code: e.code,
                  category: e.category,
                  muscleGroup: e.muscleGroup,
                  name: e.name,
                  parameters: {
                    'reps': e.reps,
                    'weight': e.weight,
                    'duration': e.duration,
                  },
                  id: e.id,
                ))
            .toList(),
      );
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertExercises(List<ExerciseBpModel> exercises) async {
    try {
      return Future(() async => await dao.insertExerciseBps(exercises));
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> updateWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    try {
      return Future(() async => await dao.updateWorkoutPlan(workoutPlan));
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<int> assignWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    try {
      return Future(() async => await dao.assignWorkoutPlan(workoutPlan));
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<Either<bool, WorkoutPlanModel?>>? getWorkoutPlanForClient(
    String clientId,
  ) async {
    try {
      final input = await dao.getWorkoutPlanForClient(clientId);
      if (input == null) return Left(false);
      final workoutPlanModel = await compute(processWorkoutPlanModel, input);
      if (isDataStale(
        Duration(days: 1).inSeconds,
        workoutPlanModel.createdAt!,
        workoutPlanModel.updatedAt,
      )) {
        await database.deleteWorkoutPlans();
        return Left(true);
      }
      return Right(workoutPlanModel);
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> deleteAssignedWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    try {
      return Future(() async => await dao.deleteWorkoutPlan(workoutPlan));
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> deleteWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    try {
      return Future(() async => await dao.deleteWorkoutPlan(workoutPlan));
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }
}

// Function to process workout plan in a separate isolate
WorkoutPlanModel processWorkoutPlanModel(String encodedInput) {
  // if (encodedInput != null) {
  final input = json.decode(encodedInput);
  final exercisesWithBaseAndSets = input['exercisesWithBaseAndSets'];
  final daysObj = input['daysObj'];
  final weeksObj = input['weeksObj'];
  final workoutPlan = input['workoutPlan'] as Map<String, dynamic>;

  // Group exercises and sets by exercise ID
  final exerciseGroups = <String, Map<String, dynamic>>{};
  for (final row in exercisesWithBaseAndSets) {
    final workoutExercise = row['workoutExercise'] as Map<String, dynamic>;
    final base = row['base'] as Map<String, dynamic>;
    final exerciseSet = row['exerciseSet'] as Map<String, dynamic>?;

    if (!exerciseGroups.containsKey(workoutExercise['id'])) {
      exerciseGroups[workoutExercise['id']] = {
        'exercise': ExerciseModel(
          gifUrl: workoutExercise['gifUrl'],
          completed: workoutExercise['completed'],
          clientId: workoutExercise['clientId'],
          dayId: workoutExercise['dayId'],
          id: workoutExercise['id'],
          code: base['code'],
          name: base['name'],
          category: base['category'],
          muscleGroup: base['muscleGroup'],
          exerciseOrder: workoutExercise['exerciseOrder'],
          parameters: {
            'weight': base['weight'],
            'reps': base['reps'],
            'duration': base['duration'],
          },
          [],
        ),
        'sets': <SetModel>[],
      };
    }

    if (exerciseSet != null) {
      (exerciseGroups[workoutExercise['id']]!['sets'] as List<SetModel>).add(
        SetModel.fromMap(exerciseSet),
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
      clientId: day['clientId'],
      weekId: day['weekId'],
      id: day['id'],
      dayNumber: day['dayNumber'],
      exercises: exercisesGroupedByDay[day['id']] ?? [],
    );
  }).toList();

  // Map weeks to models, attaching days
  final weekModels = weeksObj
      .map((week) {
        return WeekModel(
          clientId: week['clientId'],
          workoutPlanId: week['workoutPlanId'],
          id: week['id'],
          weekNumber: week['weekNumber'],
          days: dayModels
              .where((day) => day.weekId == week['id'])
              .cast<DayModel>()
              .toList(),
        );
      })
      .cast<WeekModel>()
      .toList();

  // Create and return the final workout plan model
  return WorkoutPlanModel(
    clientId: workoutPlan['clientId'],
    createdAt: workoutPlan['createdAt'],
    updatedAt: workoutPlan['updatedAt'],
    name: workoutPlan['name'],
    weeks: weekModels,
    uid: workoutPlan['uid'],
  );
  // } else {
  //   return null;
  // }
}
