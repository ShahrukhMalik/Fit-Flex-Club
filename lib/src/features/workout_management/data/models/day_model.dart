import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/day_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';

class DayModel extends Day {
  const DayModel({
    required super.dayNumber,
    required super.exercises,
  });

  factory DayModel.forEachElement(
    int dayNumber,
    List<ExerciseModel> exercises,
  ) {
    return DayModel(
      dayNumber: dayNumber,
      exercises: exercises,
    );
  }

  Map<int, List<ExerciseModel>> toMap() {
    return {dayNumber: exercises};
  }
}
