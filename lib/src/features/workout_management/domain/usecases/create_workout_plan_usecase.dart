import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/workout_plan_management_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user IsUserActive
abstract class CreateWorkoutPlanUsecase extends WorkoutPlanManagementUsecase
    implements UseCase<void, Params> {}

class Params extends Equatable {
  final WorkoutPlanModel workoutPlan;

  const Params({
    required this.workoutPlan,
  });

  @override
  List<Object?> get props => [workoutPlan];
}

@Singleton(as: CreateWorkoutPlanUsecase)
class CreateWorkoutPlanUsecaseImpl extends CreateWorkoutPlanUsecase {
  final WorkoutManagementRepository workoutManagementRepository;

  CreateWorkoutPlanUsecaseImpl({required this.workoutManagementRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return workoutManagementRepository.createWorkoutPlan(params.workoutPlan);
  }
}
