import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/day_entity.dart';

class Week extends Equatable {
  final int weekNumber;
  final List<DayModel> days;
  final String id;
  final String workoutPlanId;

  const Week({
    required this.weekNumber,
    required this.days,
    required this.id,
    required this.workoutPlanId,
  });

  @override
  List<Object?> get props => [weekNumber, days, id, workoutPlanId];
}
