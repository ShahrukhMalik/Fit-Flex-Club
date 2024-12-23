import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/day_entity.dart';

class DayModel extends Day {
  final String? clientId;
  const DayModel({
    required super.dayNumber,
    required super.exercises,
    required super.id,
    required super.weekId,
    this.clientId,
  });

  factory DayModel.fromMap(Map<String, dynamic> map,
      [bool isFromModel = false]) {
    return DayModel(
      dayNumber: map['dayNumber'] as int,
      id: map['id'] as String,
      weekId: map['weekId'] as String,
      clientId: map['clientId'] as String?,
      exercises: isFromModel
          ? map['exercises']
          : (map['exercises'])
              .map((exerciseMap) => ExerciseModel.fromMap(exerciseMap))
              .cast<ExerciseModel>()
              .toList(),
    );
  }

  factory DayModel.forEachElement(
    int dayNumber,
    String id,
    String weekId,
    String? clientId,
    List<ExerciseModel> exercises,
  ) {
    return DayModel(
      clientId: clientId,
      weekId: weekId,
      id: id,
      dayNumber: dayNumber,
      exercises: exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayNumber': dayNumber,
      'id': id,
      'weekId': weekId,
      'clientId': clientId,
      'exercises': exercises
          .map(
            (exercise) => exercise.toMap(),
          )
          .toList()
    };
  }

  DayModel copyWith({
    int? dayNumber,
    String? id,
    String? weekId,
    String? clientId,
    List<ExerciseModel>? exercises,
  }) {
    return DayModel(
      dayNumber: dayNumber ?? this.dayNumber,
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      weekId: weekId ?? this.weekId,
      exercises: exercises ?? this.exercises,
    );
  }
}
