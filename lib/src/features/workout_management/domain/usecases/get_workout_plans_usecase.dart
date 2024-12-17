import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/workout_plan_management_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user IsUserActive
abstract class GetWorkoutPlansUsecase extends WorkoutPlanManagementUsecase
    implements UseCase<List<WorkoutPlanModel>?, NoParams> {}

@Singleton(as: GetWorkoutPlansUsecase)
class GetWorkoutPlansUsecaseImpl extends GetWorkoutPlansUsecase {
  final WorkoutManagementRepository workoutManagementRepository;

  GetWorkoutPlansUsecaseImpl({required this.workoutManagementRepository});

  @override
  Future<Either<Failures, List<WorkoutPlanModel>?>?>? call(NoParams params) {
    return workoutManagementRepository.getWorkoutPlans();
  }
}
