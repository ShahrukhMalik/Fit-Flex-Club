import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
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
abstract class GetWorkoutHistoryUsecase extends WorkoutPlanManagementUsecase
    implements UseCase<List<WorkoutHistoryModel?>?, Params> {}

class Params extends Equatable {
  final String? cliendId;

  const Params({required this.cliendId});
  @override
  // TODO: implement props
  List<Object?> get props => [cliendId];
}

@Singleton(as: GetWorkoutHistoryUsecase)
class GetWorkoutHistoryUsecaseImpl extends GetWorkoutHistoryUsecase {
  final WorkoutHistoryRepository workoutHistoryRepository;

  GetWorkoutHistoryUsecaseImpl({
    required this.workoutHistoryRepository,
  });

  @override
  Future<Either<Failures, List<WorkoutHistoryModel?>?>?> call(Params params) {
    return workoutHistoryRepository.getWorkoutHistorySets(params.cliendId!);
  }
}
