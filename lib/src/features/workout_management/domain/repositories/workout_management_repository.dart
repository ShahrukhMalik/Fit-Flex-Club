import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';

///[Marker Interface] abstraction of WorkoutManagement repository
abstract class WorkoutManagementRepository {
  ///
  Future<Either<Failures, List<WorkoutPlanModel>?>?>? getWorkoutPlans();

  ///
  Future<Either<Failures, WorkoutPlanModel?>?>? getWorkoutPlanForClient(
    String clientId,
  );

  ///
  Future<Either<Failures, List<ExerciseEntity>?>?>? getExercises();

  ///
  Future<Either<Failures, void>>? createWorkoutPlan(
    WorkoutPlanModel workoutPlan,
  );

  ///
  Future<Either<Failures, void>>? assignWorkoutPlan(
    WorkoutPlanModel workoutPlan,
  );

  ///
  Future<Either<Failures, void>>? deleteWorkoutPlan(
    WorkoutPlanModel workoutPlan,
  );

  ///
  Future<Either<Failures, void>>? deleteAssignedWorkoutPlan(
    WorkoutPlanModel workoutPlan,
  );

  ///
  Future<Either<Failures, void>>? updateWorkoutPlan(
    WorkoutPlanModel workoutPlan,
  );

  ///
  Future<Either<Failures, void>>? updateAssignedWorkoutPlan(
    WorkoutPlanModel workoutPlan,
  );
}
