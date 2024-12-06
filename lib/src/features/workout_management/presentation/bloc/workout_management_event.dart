part of 'workout_management_bloc.dart';

abstract class WorkoutManagementEvent extends Equatable {
  const WorkoutManagementEvent();

  @override
  List<Object> get props => [];
}

class GetExercisesEvent extends WorkoutManagementEvent {}
