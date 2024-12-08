import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/workout_plan_management_localdatabase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/remote/workout_plan_management_remotedatasource.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: WorkoutManagementRepository)
class WorkoutManagementRepositoryImpl extends WorkoutManagementRepository {
  final NetworkInfo networkInfo;
  final WorkoutPlanManagementLocaldatasource local;
  final WorkoutPlanManagementRemotedatasource remote;

  WorkoutManagementRepositoryImpl({
    required this.networkInfo,
    required this.local,
    required this.remote,
  });
  @override
  Future<Either<Failures, List<WorkoutPlanModel>?>?>? getWorkoutPlans() async {
    final isNetworkConnected = await networkInfo.isConnected;

    try {
      final cache = await local.getWorkoutPlans();

      return cache?.fold(
        (l) async {
          if (isNetworkConnected == null || !isNetworkConnected) {
            return const Left(
              NetworkFailure(message: 'No internet Connection'),
            );
          } else {
            final remoteWorkoutPlans = await remote.getWorkoutPlans();
            if (remoteWorkoutPlans != null && remoteWorkoutPlans.isNotEmpty) {
              await local.insertWorkoutPlans(remoteWorkoutPlans);
            }
            return Right(
              remoteWorkoutPlans,
            );
          }
        },
        (r) {
          return Right(r);
        },
      );
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(message: error.errorMessage, code: error.errorCode),
      );
    }
  }

  @override
  Future<Either<Failures, void>>? createWorkoutPlan(
    WorkoutPlanModel workoutPlan,
  ) async {
    try {
      final isNetworkConnected = await networkInfo.isConnected;
      final cache = await local.insertWorkoutPlan(workoutPlan);
      if (isNetworkConnected == null || !isNetworkConnected) {
        //TODO:OFFLINE SUPPORT
        return const Left(
          NetworkFailure(
            message: 'Offline Support is not there!',
          ),
        );
      } else {
        return Right(
          await remote.createWorkoutPlan(
            workoutPlan,
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<ExerciseBpModel>?>?>? getExercises() async {
    final isNetworkConnected = await networkInfo.isConnected;

    try {
      final cache = await local.getExercises();

      return cache?.fold(
        (l) async {
          if (isNetworkConnected == null || !isNetworkConnected) {
            return const Left(
              NetworkFailure(message: 'No internet Connection'),
            );
          } else {
            final remoteExercises = await remote.getExercises();
            if (remoteExercises != null && remoteExercises.isNotEmpty) {
              await local.insertExercises(remoteExercises);
            }
            return Right(
              remoteExercises,
            );
          }
        },
        (r) {
          return Right(r);
        },
      );
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(message: error.errorMessage, code: error.errorCode),
      );
    }
  }
  
  @override
  Future<Either<Failures, void>>? updateWorkoutPlan(WorkoutPlanModel workoutPlan) async{
  try {
      final isNetworkConnected = await networkInfo.isConnected;
      final cache = await local.updateWorkoutPlan(workoutPlan);
      if (isNetworkConnected == null || !isNetworkConnected) {
        //TODO:OFFLINE SUPPORT
        return const Left(
          NetworkFailure(
            message: 'Offline Support is not there!',
          ),
        );
      } else {
        return Right(
          await remote.updateWorkoutPlan(
            workoutPlan,
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }
}
