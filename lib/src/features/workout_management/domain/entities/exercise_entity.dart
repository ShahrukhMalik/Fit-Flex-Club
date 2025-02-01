import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';

class Exercise extends ExerciseEntity {
  final List<SetModel> sets;

  const Exercise(
    this.sets, {
    super.id,
    super.exerciseOrder,
    required super.code,
    super.instructions,
    super.secondaryMuscles,
    super.targetMuscle,
    super.category,
    super.muscleGroup,
    required super.name,
    required super.parameters,
  });

  @override
  List<Object?> get props => [
        name,
        muscleGroup,
        sets,
        parameters,
        code,
        category,
        id,
      ];
}
