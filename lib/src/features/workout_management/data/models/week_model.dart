import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/week_entity.dart';

class WeekModel extends Week {
  const WeekModel({
    required super.weekNumber,
    required super.days,
  });

  factory WeekModel.forEachElement(
    int weekNumber,
    List<DayModel> days,
  ) {
    return WeekModel(
      weekNumber: weekNumber,
      days: days,
    );
  }

  Map<int, List<DayModel>> toMap() {
    return {
      weekNumber: days,
    };
  }
}
