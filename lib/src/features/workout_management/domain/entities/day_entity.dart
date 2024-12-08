import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';

class Day extends Equatable {
  final int dayNumber;
  final String id;
  final String weekId;
  final List<ExerciseModel> exercises;

  const Day({
    required this.dayNumber,
    required this.exercises,
    required this.id,
    required this.weekId,
  });

  @override
  List<Object?> get props => [dayNumber, exercises, id, weekId];
}
