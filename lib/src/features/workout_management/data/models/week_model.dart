import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/week_entity.dart';

import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/week_entity.dart';

class WeekModel extends Week {
  const WeekModel({
    required super.weekNumber,
    required super.days,
    required super.id,
    required super.workoutPlanId,
  });

  factory WeekModel.forEachElement(
    int weekNumber,
    String id,
    String workoutPlanId,
    List<DayModel> days,
  ) {
    return WeekModel(
      id: id,
      workoutPlanId: workoutPlanId,
      weekNumber: weekNumber,
      days: days,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weekNumber': weekNumber,
      'id': id,
    };
  }

  WeekModel copyWith({
    int? weekNumber,
    String? id,
    String? workoutPlanId,
    List<DayModel>? days,
  }) {
    return WeekModel(
      weekNumber: weekNumber ?? this.weekNumber,
      id: id ?? this.id,
      workoutPlanId: workoutPlanId ?? this.workoutPlanId,
      days: days ?? this.days,
    );
  }
}
