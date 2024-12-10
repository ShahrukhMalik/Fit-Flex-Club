part of 'workout_management_bloc.dart';

abstract class WorkoutManagementEvent extends Equatable {
  const WorkoutManagementEvent();
}

class GetExercisesEvent extends WorkoutManagementEvent {
  @override
  List<Object?> get props => [];
}

class GetWorkoutPlansEvent extends WorkoutManagementEvent {
  @override
  List<Object?> get props => [];
}

class GetWorkoutPlansForClientEvent extends WorkoutManagementEvent {
  final String clientId;

  const GetWorkoutPlansForClientEvent({required this.clientId});
  @override
  List<Object?> get props => [clientId];
}

class UpdateWorkoutPlanEvent extends WorkoutManagementEvent {
  final WorkoutPlanModel workoutPlan;

  const UpdateWorkoutPlanEvent({required this.workoutPlan});

  @override
  List<Object?> get props => [workoutPlan];
}

class AssignWorkoutPlanEvent extends WorkoutManagementEvent {
  final WorkoutPlanModel workoutPlan;

  const AssignWorkoutPlanEvent({required this.workoutPlan});

  @override
  List<Object?> get props => [workoutPlan];
}

class CreateWorkoutPlanEvent extends WorkoutManagementEvent {
  final WorkoutPlanModel workoutPlan;

  const CreateWorkoutPlanEvent({required this.workoutPlan});

  @override
  List<Object?> get props => [workoutPlan];
}
