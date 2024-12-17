import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';

class ExerciseModel extends Exercise {
  final String? clientId;
  final String dayId;
  final bool? completed;
  final int? createdAt;
  final int? updatedAt;
  const ExerciseModel(
    super.sets, {
    required super.code,
    required super.id,
    super.exerciseOrder,
    required super.name,
    super.category,
    required this.dayId,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    super.muscleGroup,
    super.parameters,
    this.completed,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> data) {
    print(data['completed']);
    return ExerciseModel(
      completed: data['completed'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      exerciseOrder: data['exerciseOrder'],
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
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'updatedAt': updatedAt,
      'completed': completed,
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
    bool? completed,
    dynamic parameters,
    int? createdAt,
    int? updatedAt,
  }) {
    return ExerciseModel(
      createdAt: createdAt ??
          this.createdAt, // Keep the same createdAt timestamp as before.
      updatedAt: updatedAt ?? this.updatedAt,
      completed: completed ??
          this.completed, // Keep the same completed status as before.
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
