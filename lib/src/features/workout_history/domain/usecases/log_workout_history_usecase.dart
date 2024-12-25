import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_history/domain/repositories/workout_history_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/workout_plan_management_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user IsUserActive
abstract class LogWorkoutHistoryUsecase extends WorkoutPlanManagementUsecase
    implements UseCase<void, Params> {}

class Params extends Equatable {
  final ExerciseModel exerciseModel;

  const Params(
    this.exerciseModel,
  );

  @override
  List<Object?> get props => [exerciseModel];
}

@Singleton(as: LogWorkoutHistoryUsecase)
class LogWorkoutHistoryUsecaseImpl extends LogWorkoutHistoryUsecase {
  final WorkoutHistoryRepository workoutHistoryRepository;

  LogWorkoutHistoryUsecaseImpl({
    required this.workoutHistoryRepository,
  });

  @override
  Future<Either<Failures, void>?>? call(Params params) {
    return workoutHistoryRepository.logWorkoutProgress(
      exerciseModel: params.exerciseModel
    );
  }
}
