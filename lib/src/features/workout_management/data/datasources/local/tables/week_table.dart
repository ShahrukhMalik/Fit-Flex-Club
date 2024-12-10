import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';

class Weeks extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  @override
  Set<Column> get primaryKey => {id}; // Auto-increment primary key
  TextColumn get workoutPlanId =>
      text().references(WorkoutPlans, #uid)(); // Foreign key to WorkoutPlans
  TextColumn get clientId => text().nullable().references(Clients, #id)();
  IntColumn get weekNumber => integer()(); // Week number (e.g., 1, 2, 3, ...)
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  IntColumn get updatedAt =>
      integer().nullable()(); // Nullable updated timestamp
}
