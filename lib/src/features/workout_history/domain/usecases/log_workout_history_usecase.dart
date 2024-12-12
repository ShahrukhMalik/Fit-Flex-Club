import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_history/data/repositories/workout_history_repository.dart';
import 'package:fit_flex_club/src/features/workout_history/domain/repositories/workout_history_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/workout_plan_management_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user IsUserActive
abstract class LogWorkoutHistoryUsecase extends WorkoutPlanManagementUsecase
    implements UseCase<void, Params> {}

class Params extends Equatable {
  final String? clientId;
  final List<SetModel> sets;
  final String exerciseId;
  final String dayId;
  final String weekId;
  final String workoutPlanId;

  const Params({
    required this.sets,
    this.clientId,
    required this.exerciseId,
    required this.dayId,
    required this.weekId,
    required this.workoutPlanId,
  });

  @override
  List<Object?> get props => [clientId];
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
      clientId: params.clientId,
      dayId: params.dayId,
      exerciseId: params.exerciseId,
      sets: params.sets,
      weekId: params.weekId,
      workoutPlanId: params.workoutPlanId,
    );
  }
}
