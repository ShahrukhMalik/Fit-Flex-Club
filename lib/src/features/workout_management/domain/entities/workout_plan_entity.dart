import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';

class WorkoutPlan extends Equatable {
  final String name;
  final String uid;
  final List<WeekModel> weeks;

  const WorkoutPlan({
    required this.name,
    required this.weeks,
    required this.uid,
  });

  @override
  List<Object?> get props => [name, weeks];
}




