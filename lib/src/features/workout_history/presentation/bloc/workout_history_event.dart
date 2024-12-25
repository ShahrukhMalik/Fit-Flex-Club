part of 'workout_history_bloc.dart';

abstract class WorkoutHistoryEvent extends Equatable {
  const WorkoutHistoryEvent();
}

class GetWorkoutHistoryEvent extends WorkoutHistoryEvent {
  final String? cliendId;

  const GetWorkoutHistoryEvent({this.cliendId});
  @override
  List<Object?> get props => [cliendId];
}

class LogWorkoutHistoryEvent extends WorkoutHistoryEvent {
  final ExerciseModel exerciseModel;

  const LogWorkoutHistoryEvent(
    this.exerciseModel,
  );

  @override
  List<Object?> get props => [exerciseModel];
}
