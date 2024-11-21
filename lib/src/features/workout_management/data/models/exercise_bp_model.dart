import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';

class ExerciseBpModel extends ExerciseEntity {
  const ExerciseBpModel({
    required super.code,
    required super.equipment,
    required super.muscleGroup,
    required super.name,
    required super.parameters,
  });

  // Factory constructor to create an instance from Firestore data
  factory ExerciseBpModel.fromFirestore(Map<String, dynamic> data) {
    return ExerciseBpModel(
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
