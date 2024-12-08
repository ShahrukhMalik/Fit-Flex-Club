import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';
import 'package:uuid_v4/uuid_v4.dart';

class ExerciseModel extends Exercise {
  final String dayId;
  const ExerciseModel(
    super.sets, {
    required super.code,
    required super.id,
    super.exerciseOrder,
    required super.name,
    super.category,
    required this.dayId,
    super.muscleGroup,
    super.parameters,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> data) {
    return ExerciseModel(
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
      'sets': sets.map((e) => e.toMap()).toList(),
    };
  }

  ExerciseModel copyWith({
    List<SetModel>? sets,
    String? code,
    String? id,
    String? dayId,
    String? name,
    String? category,
    String? muscleGroup,
    dynamic parameters,
  }) {
    return ExerciseModel(
      dayId: dayId ?? this.dayId, // Keep the same dayId as before.
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
  /// The newly added set is placed at the top of the list.
  /// Always appends a new empty `SetModel` at the end.
  // ExerciseModel addSet(SetModel newSet) {
  //   final oldList = sets;
  //   final existingSet = sets.where((set) => set.id == newSet.id).toList()[0];
  //   final updatedSet = existingSet.copyWith(
  //     targetReps: newSet.targetReps,
  //     targetWeight: newSet.targetWeight,
  //   );
  //   oldList.removeWhere(
  //     (element) {
  //       return element.id == newSet.id;
  //     },
  //   );

  //   oldList.addAll(
  //     [
  //       ...oldList,
  //       updatedSet,
  //       SetModel(
  //         id: UUIDv4().toString(),
  //       ),
  //     ],
  //   );
  //   print(oldList);

  //   return copyWith(sets: oldList);
  // }

  /// Deletes a set from the list based on `id`.
  ExerciseModel deleteSet(String setId) {
    final updatedSets = sets.where((set) => set.id != setId).toList();
    return copyWith(sets: updatedSets);
  }
}
