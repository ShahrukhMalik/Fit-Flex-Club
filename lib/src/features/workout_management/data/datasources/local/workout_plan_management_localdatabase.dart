import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/functions/is_data_stale.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/daos/workout_plan_dao.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';

abstract class WorkoutPlanManagementLocaldatasource {
  ///
  Future<Either<bool, List<WorkoutPlanModel>>>? getWorkoutPlans();

  ///
  Future<void> insertWorkoutPlans(List<WorkoutPlanModel> workoutPlans);
  Future<void> insertWorkoutPlan(WorkoutPlanModel workoutPlan);
}

class WorkoutPlanManagementLocaldatabaseImpl
    extends WorkoutPlanManagementLocaldatasource {
  final WorkoutPlanDao dao;
  final AppDatabase database;

  WorkoutPlanManagementLocaldatabaseImpl({
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
}
