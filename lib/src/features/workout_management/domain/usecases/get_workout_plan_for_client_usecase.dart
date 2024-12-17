import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/workout_plan_management_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user IsUserActive
abstract class GetWorkoutPlansForClientUsecase
    extends WorkoutPlanManagementUsecase
    implements UseCase<WorkoutPlanModel?, Params> {}

class Params extends Equatable {
  final String clientId;

  const Params({
    required this.clientId,
  });

  @override
  List<Object?> get props => [clientId];
}

@Singleton(as: GetWorkoutPlansForClientUsecase)
class GetWorkoutPlansForClientUsecaseImpl
    extends GetWorkoutPlansForClientUsecase {
  final WorkoutManagementRepository workoutManagementRepository;

  GetWorkoutPlansForClientUsecaseImpl(
      {required this.workoutManagementRepository});

  @override
  Future<Either<Failures, WorkoutPlanModel?>?>? call(Params params) {
    return workoutManagementRepository.getWorkoutPlanForClient(params.clientId);
  }
}
