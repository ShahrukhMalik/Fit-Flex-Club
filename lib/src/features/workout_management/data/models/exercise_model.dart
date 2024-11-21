import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';

class ExerciseModel extends Exercise {
  const ExerciseModel(
    super.sets, {
    required super.code,
    required super.name,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> data) {
    return ExerciseModel(
      List.from(
        (data['sets'] as List).map(
          (e) => SetModel.fromMap(e),
        ),
      ),
      code: data['code'],
      name: data['name'],
    );
  }
}
