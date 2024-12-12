part of 'workout_history_bloc.dart';

abstract class WorkoutHistoryState extends Equatable {
  const WorkoutHistoryState();

  @override
  List<Object> get props => [];
}

class WorkoutHistoryInitial extends WorkoutHistoryState {}

class WorkoutHistoryError extends WorkoutHistoryState {
  final Failures failures;
  const WorkoutHistoryError({required this.failures});
}

class LogWorkoutHistoryLoading extends WorkoutHistoryState {}

class LogWorkoutHistoryComplete extends WorkoutHistoryState {}
