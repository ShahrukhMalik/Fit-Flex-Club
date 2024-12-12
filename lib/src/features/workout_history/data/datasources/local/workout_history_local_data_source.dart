import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/functions/is_data_stale.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/daos/workout_history_dao.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/tables/workout_history_set_table.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:injectable/injectable.dart';

abstract class WorkoutHistoryLocalDataSource {
  ///
  Future<void> insertWorkoutHistorySets({
    required List<SetModel> setModel,
    String? clientUid,
    required String exerciseUid,
  });

  ///
  Future<Either<bool, List<WorkoutHistoryModel>>> getWorkoutHistorySets(
    String? clientUid,
    String isTrainer,
  );
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
    required List<SetModel> setModel,
    String? clientUid,
    required String exerciseUid,
  }) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      return Future(
        () async => await dao.insertWorkoutHistorySets(
          clientUid: clientUid ?? clientId!,
          exerciseUid: exerciseUid,
          setModel: setModel,
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
    String? clientUid,
    String isTrainer,
  ) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      final workoutHistorySets =
          await dao.getWorkoutHistoryModels(clientUid ?? clientId!);

      if (workoutHistorySets.isNotEmpty) {
        if (isDataStale(
          Duration(seconds: 1).inSeconds,
          workoutHistorySets.first.workoutLogDate.millisecondsSinceEpoch,
          workoutHistorySets.first.workoutLogDate.millisecondsSinceEpoch,
        )) {
          await database.deleteWorkoutPlans();
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
}
