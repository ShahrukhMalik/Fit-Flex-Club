part of 'workout_history_bloc.dart';

abstract class WorkoutHistoryState extends Equatable {
  const WorkoutHistoryState();  

  @override
  List<Object> get props => [];
}
class WorkoutHistoryInitial extends WorkoutHistoryState {}
