import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';

class ExerciseBpModel extends ExerciseEntity {
  final String? clientId;
  const ExerciseBpModel({
    required super.code,
    required super.category,
    required super.muscleGroup,
    required super.name,
    required super.parameters,
    required super.id,
    required super.gifUrl,
    super.instructions,
    super.secondaryMuscles,
    super.targetMuscle,
    this.clientId,
  });

  // Factory constructor to create an instance from Firestore data
  factory ExerciseBpModel.fromFirestore(
    Map<String, dynamic> data,
    String id,
  ) {
    return ExerciseBpModel(
      gifUrl: data['gifUrl'],
      instructions: (data['instructions'] as List)
          .map(
            (e) => e.toString(),
          )
          .toList(),
      secondaryMuscles: (data['secondaryMuscles'] as List)
          .map(
            (e) => e.toString(),
          )
          .toList(),
      targetMuscle: data['targetMuscle'],
      id: id,
      code: data['code'],
      category: data['category'],
      muscleGroup: data['muscleGroup'],
      name: data['name'],
      parameters: data['parameters'],
    );
  }

  // Method to convert an instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'gifUrl': gifUrl,
      'instructions': instructions,
      'secondaryMuscles': secondaryMuscles,
      'targetMuscle': targetMuscle,
      'code': code,
      'category': category,
      'muscleGroup': muscleGroup,
      'name': name,
      'parameters': parameters,
      'id': id,
      'clientId': clientId,
    };
  }
}
