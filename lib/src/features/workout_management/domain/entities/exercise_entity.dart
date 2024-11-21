import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/set_entity.dart';

class Exercise extends ExerciseEntity {
  final List<SetModel> sets;
  const Exercise(
    this.sets, {
    required super.code,
    super.equipment,
    super.muscleGroup,
    required super.name,
    super.parameters,
  });

  @override
  List<Object?> get props => [
        name,
        muscleGroup,
        sets,
        parameters,
        code,
        equipment,
      ];
}
