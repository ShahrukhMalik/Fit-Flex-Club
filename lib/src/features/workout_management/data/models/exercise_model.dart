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
      'sets': sets.map((e) => e.toMap()).toList(),
    };
  }

  ExerciseModel copyWith({
    List<SetModel>? sets,
    String? code,
    String? id,
    String? name,
    String? category,
    String? muscleGroup,
    dynamic parameters,
  }) {
    return ExerciseModel(
      sets ?? this.sets,
      code: code ?? this.code,
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      parameters: parameters ?? this.parameters,
    );
  }

  /// Adds a new set to the list if it doesn't exist (based on `id`).
  ExerciseModel addSet(SetModel newSet) {
    final updatedSets = [
      if (!sets.any((set) => set.id == newSet.id)) newSet,
      ...sets,
    ];
    return copyWith(sets: updatedSets);
  }

  /// Deletes a set from the list based on `id`.
  ExerciseModel deleteSet(String setId) {
    final updatedSets = sets.where((set) => set.id != setId).toList();
    return copyWith(sets: updatedSets);
  }
}
