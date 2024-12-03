import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';

class ExerciseModel extends Exercise {
  const ExerciseModel(
    super.sets, {
    required super.code,
    required super.id,
    required super.name,
     super.category,
     super.muscleGroup,
     super.parameters,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> data) {
    return ExerciseModel(
      category: data['category'],
      muscleGroup: data['muscle_group'],
      parameters: data['parameters'],
      List.from(
        (data['sets'] as List).map(
          (e) => SetModel.fromMap(e),
        ),
      ),
      code: data['code'],
      name: data['name'],
      id: data['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'muscle_group': muscleGroup,
      'parameters': parameters,
      'code': code,
      'name': name,
      'id': id,
    };
  }
}
