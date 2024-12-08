import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  final String? id;
  final int? exerciseOrder;
  final String? code;
  final String? category;
  final String? muscleGroup;
  final String? name;
  final Map<String, dynamic>? parameters;

  const ExerciseEntity({
    required this.code,
    required this.category,
    required this.muscleGroup,
    required this.name,
    required this.parameters,
    this.id,
    this.exerciseOrder,
  });

  @override
  List<Object?> get props =>
      [code, category, muscleGroup, name, parameters, id, exerciseOrder];
}
