import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/workout_plan_management_localdatabase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/remote/workout_plan_management_remotedatasource.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';

class WorkoutManagementRepositoryImpl extends WorkoutManagementRepository {
  final NetworkInfo networkInfo;
  final WorkoutPlanManagementLocaldatabaseImpl local;
  final WorkoutPlanManagementRemotedatasourceImpl remote;

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
    }
  }

  @override
  Future<Either<Failures, void>>? createWorkoutPlan(
    List<WorkoutPlanModel> workoutPlans,
  ) {
    // TODO: implement createWorkoutPlan
    throw UnimplementedError();
  }
}
