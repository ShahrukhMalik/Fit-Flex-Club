import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';
import 'package:uuid_v4/uuid_v4.dart';

class ExerciseModel extends Exercise {
  final String? clientId;
  final String dayId;
  const ExerciseModel(
    super.sets, {
    required super.code,
    required super.id,
    super.exerciseOrder,
    required super.name,
    super.category,
    required this.dayId,
    this.clientId,
    super.muscleGroup,
    super.parameters,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> data) {
    return ExerciseModel(
      clientId: data['clientId'],
      dayId: data['dayId'],
      List.from(
        (data['sets'] as List).map(
          (e) => SetModel.fromMap(e),
        ),
      ),
      code: data['code'],
      name: data['name'],
      id: data['id'],
      category: data['category'],
      muscleGroup: data['muscle_group'],
      parameters: data['parameters'],
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
      'clientId': clientId,
      'exerciseOrder': exerciseOrder,
      'dayId': dayId,
      'sets': sets.map((e) => e.toMap()).toList(),
    };
  }

  ExerciseModel copyWith({
    List<SetModel>? sets,
    String? code,
    String? id,
    String? dayId,
    String? clientId,
    String? name,
    String? category,
    String? muscleGroup,
    dynamic parameters,
  }) {
    return ExerciseModel(
      dayId: dayId ?? this.dayId, // Keep the same dayId as before.
      clientId: clientId ?? this.clientId, // Keep the same dayId as before.
      sets ?? this.sets,
      code: code ?? this.code,
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      parameters: parameters ?? this.parameters,
    );
  }

  ExerciseModel deleteSet(String setId) {
    final updatedSets = sets.where((set) => set.id != setId).toList();
    return copyWith(sets: updatedSets);
  }
}
