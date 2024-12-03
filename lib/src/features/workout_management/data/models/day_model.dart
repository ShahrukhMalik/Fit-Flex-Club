import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/day_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';

class DayModel extends Day {
  const DayModel({
    required super.dayNumber,
    required super.exercises,
    required super.id,
  });

  factory DayModel.forEachElement(
    int dayNumber,
    int id,
    List<ExerciseModel> exercises,
  ) {
    return DayModel(
      id: id,
      dayNumber: dayNumber,
      exercises: exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayNumber': dayNumber,
      'id': id,
    };
  }
}
