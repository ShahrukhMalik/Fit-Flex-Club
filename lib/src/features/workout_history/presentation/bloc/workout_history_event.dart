part of 'workout_history_bloc.dart';

abstract class WorkoutHistoryEvent extends Equatable {
  const WorkoutHistoryEvent();
}

class LogWorkoutHistoryEvent extends WorkoutHistoryEvent {
  final String? clientId;
  final List<SetModel> sets;
  final String exerciseId;
  final String dayId;
  final String weekId;
  final String workoutPlanId;

  const LogWorkoutHistoryEvent({
     this.clientId,
    required this.sets,
    required this.exerciseId,
    required this.dayId,
    required this.weekId,
    required this.workoutPlanId,
  });

  @override
  List<Object?> get props => [];
}
