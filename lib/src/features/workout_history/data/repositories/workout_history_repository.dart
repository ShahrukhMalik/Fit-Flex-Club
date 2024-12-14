import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/workout_history_local_data_source.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/remote/workout_history_remote_data_source.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_history/domain/repositories/workout_history_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] abstraction of WorkoutHistory repository
@Singleton(as: WorkoutHistoryRepository)
class WorkoutHistoryRepositoryImpl extends WorkoutHistoryRepository {
  final NetworkInfo networkInfo;
  final WorkoutHistoryRemoteDataSource remote;
  final WorkoutHistoryLocalDataSource local;

  WorkoutHistoryRepositoryImpl({
    required this.networkInfo,
    required this.local,
    required this.remote,
  });

  @override
  Future<Either<Failures, void>> logWorkoutProgress({
    required List<SetModel> sets,
    String? clientId,
    required String exerciseId,
    required String dayId,
    required String weekId,
    required String workoutPlanId,
  }) async {
    try {
      final isNetworkConnected = await networkInfo.isConnected;
      final cache = await local.insertWorkoutHistorySets(
        exerciseUid: exerciseId,
        setModel: sets,
        clientUid: clientId,
      );
      if (isNetworkConnected == null || !isNetworkConnected) {
        //TODO:OFFLINE SUPPORT
        return const Left(
          NetworkFailure(
            message: 'Offline Support is coming soon!',
          ),
        );
      } else {
        return Right(
          await remote.logWorkoutHistory(
            dayId: dayId,
            exerciseId: exerciseId,
            sets: sets,
            weekId: weekId,
            workoutPlanId: workoutPlanId,
            clientId: clientId,
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
  Future<Either<Failures, List<WorkoutHistoryModel>?>?> getWorkoutHistorySets(
      [String? clientUid, String? isTrainer]) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      final isNetworkConnected = await networkInfo.isConnected;
      final cache = await local.getWorkoutHistorySets(clientUid ?? clientId);

      return cache.fold(
        (l) async {
          if (isNetworkConnected == null || !isNetworkConnected) {
            return const Left(
              NetworkFailure(message: 'No internet Connection'),
            );
          } else {
            final workoutHistoryModels =
                await remote.getWorkoutHistorySets(clientUid ?? clientId);
            if (workoutHistoryModels != null &&
                workoutHistoryModels.isNotEmpty) {
              await local.insertWorkoutHistorySetFromRemote(
                historyList: workoutHistoryModels,
              );
            }
            return Right(
              workoutHistoryModels,
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
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }
}
