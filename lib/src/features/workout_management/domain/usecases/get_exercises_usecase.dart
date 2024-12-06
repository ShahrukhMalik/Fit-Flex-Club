import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/workout_plan_management_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user IsUserActive
abstract class GetExercisesUsecase extends WorkoutPlanManagementUsecase
    implements UseCase<List<ExerciseEntity>?, NoParams> {}

@Singleton(as: GetExercisesUsecase)
class GetExercisesUsecaseImpl extends GetExercisesUsecase {
  final WorkoutManagementRepository workoutManagementRepository;

  GetExercisesUsecaseImpl({required this.workoutManagementRepository});

  @override
  Future<Either<Failures, List<ExerciseEntity>?>?>? call(NoParams params) {
    return workoutManagementRepository.getExercises();
  }
}
