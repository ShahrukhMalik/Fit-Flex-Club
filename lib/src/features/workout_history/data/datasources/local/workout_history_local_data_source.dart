import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/functions/is_data_stale.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/daos/workout_history_dao.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:injectable/injectable.dart';

abstract class WorkoutHistoryLocalDataSource {
  ///
  Future<void> insertWorkoutHistorySets({
    required ExerciseModel exerciseModel,
  });

  ///
  Future<void> insertWorkoutHistorySetFromRemote({
    required List<WorkoutHistoryModel> historyList,
  });

  ///
  Future<Either<bool, List<WorkoutHistoryModel>>> getWorkoutHistorySets(
    String? clientUid, [
    String? isTrainer,
  ]);
}

@Singleton(as: WorkoutHistoryLocalDataSource)
class WorkoutHistoryLocalDataSourceImpl
    implements WorkoutHistoryLocalDataSource {
  final WorkoutHistoryDao dao;
  final AppDatabase database;

  WorkoutHistoryLocalDataSourceImpl({
    required this.dao,
    required this.database,
  });
  @override
  Future<void> insertWorkoutHistorySets({
    required ExerciseModel exerciseModel,
  }) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      return Future(
        () async => await dao.insertWorkoutHistorySets(
          exerciseModel: exerciseModel,
        ),
      );
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<Either<bool, List<WorkoutHistoryModel>>> getWorkoutHistorySets(
    String? clientUid, [
    String? isTrainer,
  ]) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      final workoutHistorySets =
          await dao.getWorkoutHistoryModels(clientUid ?? clientId!);

      if (workoutHistorySets.isNotEmpty) {
        if (isDataStale(
          Duration(minutes: 5).inSeconds,
          workoutHistorySets.first.exerciseModels.first.sets.first.createdAt!,
          workoutHistorySets.first.exerciseModels.first.updatedAt,
        )) {
          await database.deleteWorkoutHistorySets();
          return Left(true);
        }
        return Right(workoutHistorySets);
      } else {
        return Left(false);
      }
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertWorkoutHistorySetFromRemote(
      {required List<WorkoutHistoryModel> historyList}) async {
    try {
      return Future(
        () async => await dao.insertWorkoutHistorySetFromRemote(
          historyList: historyList,
        ),
      );
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }
}
