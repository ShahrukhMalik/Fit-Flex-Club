import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/week_entity.dart';

class WeekModel extends Week {
  const WeekModel({
    required super.weekNumber,
    required super.days,
    required super.id,
  });

  factory WeekModel.forEachElement(
    int weekNumber,
    String id,
    List<DayModel> days,
  ) {
    return WeekModel(
      id: id,
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
}
