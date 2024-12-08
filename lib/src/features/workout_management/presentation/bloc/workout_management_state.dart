part of 'workout_management_bloc.dart';

abstract class WorkoutManagementState extends Equatable {
  const WorkoutManagementState();

  @override
  List<Object> get props => [];
}

class WorkoutManagementInitial extends WorkoutManagementState {}

class WorkoutManagementLoading extends WorkoutManagementState {}

class GetWorkoutPlansComplete extends WorkoutManagementState {
  final List<WorkoutPlanModel> workoutPlans;

  const GetWorkoutPlansComplete({required this.workoutPlans});
  @override
  List<Object> get props => [workoutPlans];
}

class GetExercisesComplete extends WorkoutManagementState {
  final List<ExerciseEntity> exercises;

  const GetExercisesComplete({required this.exercises});
}

class CreateWorkoutComplete extends WorkoutManagementState {}
class UpdateWorkoutComplete extends WorkoutManagementState {}

class WorkoutManagementError extends WorkoutManagementState {
  final Failures failures;

  const WorkoutManagementError({required this.failures});
}
