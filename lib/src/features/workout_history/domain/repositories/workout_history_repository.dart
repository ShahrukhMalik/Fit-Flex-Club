import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';

///[Marker Interface] abstraction of WorkoutHistory repository
abstract class WorkoutHistoryRepository {
  ///
  Future<Either<Failures, void>> logWorkoutProgress({
    required List<SetModel> sets,
    String? clientId,
    required String exerciseId,

  });

  ///
  Future<Either<Failures, List<WorkoutHistoryModel>?>?> getWorkoutHistorySets([
    String? clientUid,
    String isTrainer,
  ]);
}
