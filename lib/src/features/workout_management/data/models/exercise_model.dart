import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  const ExerciseModel({
    required super.code,
    required super.equipment,
    required super.muscleGroup,
    required super.name,
    required super.parameters,
  });

  // Factory constructor to create an instance from Firestore data
  factory ExerciseModel.fromFirestore(Map<String, dynamic> data) {
    return ExerciseModel(
      code: data['code'] as int,
      equipment: data['equipment'] as String,
      muscleGroup: data['muscleGroup'] as String,
      name: data['name'] as String,
      parameters: Map<String, bool>.from(data['parameters'] as Map),
    );
  }

  // Method to convert an instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'code': code,
      'equipment': equipment,
      'muscleGroup': muscleGroup,
      'name': name,
      'parameters': parameters,
    };
  }
}
