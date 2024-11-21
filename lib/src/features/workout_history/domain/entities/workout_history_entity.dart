import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';

class WorkoutHistoryEntity extends Equatable {
  final DateTime workoutLogDate;
  final List<ExerciseModel> exerciseModels;

  const WorkoutHistoryEntity({
    required this.workoutLogDate,
    required this.exerciseModels,
  });
  @override
  List<Object?> get props => [workoutLogDate, exerciseModels];
}
