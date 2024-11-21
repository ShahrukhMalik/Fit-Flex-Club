import 'package:fit_flex_club/src/features/workout_history/domain/entities/workout_history_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryModel extends WorkoutHistoryEntity {
  const WorkoutHistoryModel({
    required super.workoutLogDate,
    required super.exerciseModels,
  });

  factory WorkoutHistoryModel.forEachElement(
    DateTime workoutLogDate,
    List<ExerciseModel> exerciseModels,
  ) {
    return WorkoutHistoryModel(
      workoutLogDate: workoutLogDate,
      exerciseModels: exerciseModels,
    );
  }

  Map<String, List<Map<String, dynamic>>> toMap() {
    return {
      DateFormat('yyyy-MM-dd').format(workoutLogDate): exerciseModels
          .map(
            (e) => {
              if (e.sets.isNotEmpty)
                'sets': e.sets.map(
                  (e) => e.toMap(),
                ),
              if (e.code != null) 'code': e.code,
              if (e.name != null) 'name': e.name,
              if (e.muscleGroup != null) 'muscleGroup': e.muscleGroup,
              if (e.parameters != null) 'parameters': e.parameters,
              if (e.equipment != null) 'weight': e.equipment,
            },
          )
          .toList(),
    };
  }
}
