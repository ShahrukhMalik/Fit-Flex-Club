import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  final int? code;
  final String? equipment;
  final String? muscleGroup;
  final String? name;
  final Map<String, bool>? parameters;

  const ExerciseEntity({
    required this.code,
    required this.equipment,
    required this.muscleGroup,
    required this.name,
    required this.parameters,
  });

  @override
  List<Object?> get props => [
        code,
        equipment,
        muscleGroup,
        name,
        parameters,
      ];
}
