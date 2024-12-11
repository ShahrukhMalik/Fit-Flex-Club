part of 'workout_management_bloc.dart';

abstract class WorkoutManagementState extends Equatable {
  const WorkoutManagementState();

  @override
  List<Object?> get props => [];
}

class WorkoutManagementInitial extends WorkoutManagementState {}

class WorkoutManagementLoading extends WorkoutManagementState {}

class GetExercisesLoading extends WorkoutManagementState {}

class DeleteWorkoutLoading extends WorkoutManagementState {}

class GetWorkoutPlansLoading extends WorkoutManagementState {}

class CreateWorkoutLoading extends WorkoutManagementState {}

class UpdateWorkoutLoading extends WorkoutManagementState {}

class AssigneWorkoutPlanLoading extends WorkoutManagementState {}

class GetWorkoutPlansForClientLoading extends WorkoutManagementState {}

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

class UpdateAssignedWorkoutComplete extends WorkoutManagementState {}

class AssignWorkoutComplete extends WorkoutManagementState {}

class DeleteWorkoutComplete extends WorkoutManagementState {}

class GetWorkoutPlansForClientComplete extends WorkoutManagementState {
  final WorkoutPlanModel? workoutPlan;

  const GetWorkoutPlansForClientComplete({required this.workoutPlan});
  @override
  List<Object?> get props => [workoutPlan];
}

class WorkoutManagementError extends WorkoutManagementState {
  final Failures failures;

  const WorkoutManagementError({required this.failures});
}
