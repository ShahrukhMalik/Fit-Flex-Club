import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/functions/is_data_stale.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/daos/workout_plan_dao.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:injectable/injectable.dart';

abstract class WorkoutPlanManagementLocaldatasource {
  ///
  Future<Either<bool, List<WorkoutPlanModel>>>? getWorkoutPlans();

  ///
  Future<void> insertWorkoutPlans(List<WorkoutPlanModel> workoutPlans);

  ///
  Future<void> insertWorkoutPlan(WorkoutPlanModel workoutPlan);

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
        Duration(days: 1).inSeconds,
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
  Future<void> insertWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    try {
      final result = await dao.insertWorkoutPlan(workoutPlan);
      return Future.value(null);
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
      final result = await dao.insertExerciseBps(exercises);
      return Future.value(null);
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }
}
