import 'package:fit_flex_club/src/features/workout_management/domain/entities/workout_plan_entity.dart';

class WorkoutPlanModel extends WorkoutPlan {
  const WorkoutPlanModel({
    required super.name,
    required super.weeks,
    required super.uid,
  });

  factory WorkoutPlanModel.fromMap(Map<String, dynamic> data) {
    return WorkoutPlanModel(
      name: data['name'],
      weeks: data['weeks'],
      uid: data['uid'],
    );
  }
}
