part of 'workout_management_bloc.dart';

abstract class WorkoutManagementState extends Equatable {
  const WorkoutManagementState();  

  @override
  List<Object> get props => [];
}
class WorkoutManagementInitial extends WorkoutManagementState {}
