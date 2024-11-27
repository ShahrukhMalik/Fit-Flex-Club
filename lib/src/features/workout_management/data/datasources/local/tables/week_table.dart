import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';

class Weeks extends Table {
  IntColumn get id => integer().autoIncrement()(); // Auto-increment primary key
  TextColumn get workoutPlanUid =>
      text().references(WorkoutPlans, #uid)(); // Foreign key to WorkoutPlans
  IntColumn get weekNumber => integer()(); // Week number (e.g., 1, 2, 3, ...)
}