import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/week_entity.dart';

class WeekModel extends Week {
  final String? clientId;
  const WeekModel({
    required super.weekNumber,
    required super.days,
    required super.id,
    required super.workoutPlanId,
    this.clientId,
  });

  factory WeekModel.fromMap(Map<String, dynamic> map,
      [bool isFromModel = false]) {
    return WeekModel(
      weekNumber: map['weekNumber'] as int,
      id: map['id'] as String,
      clientId: map['clientId'] as String?,
      workoutPlanId: map['workoutPlanId'] as String,
      days: isFromModel
          ? map['days']
          : (map['days'])
              .map((dayMap) => DayModel.fromMap(dayMap, isFromModel))
               .cast<DayModel>()
              .toList(),
    );
  }
  factory WeekModel.forEachElement(
    int weekNumber,
    String id,
    String workoutPlanId,
    String? clientId,
    List<DayModel> days,
  ) {
    return WeekModel(
      id: id,
      workoutPlanId: workoutPlanId,
      weekNumber: weekNumber,
      days: days,
      clientId: clientId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weekNumber': weekNumber,
      'id': id,
      'clientId': clientId,
      'workoutPlanId': workoutPlanId,
      'days': days
          .map(
            (e) => e.toMap(),
          )
          .toList()
    };
  }

  WeekModel copyWith({
    int? weekNumber,
    String? id,
    String? clientId,
    String? workoutPlanId,
    List<DayModel>? days,
  }) {
    return WeekModel(
      weekNumber: weekNumber ?? this.weekNumber,
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      workoutPlanId: workoutPlanId ?? this.workoutPlanId,
      days: days ?? this.days,
    );
  }
}
