import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';

class WorkoutPlanExercise extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  @override
  Set<Column> get primaryKey => {id}; // Auto-increment primary key
  TextColumn get dayId =>
      text().references(Days, #id)(); // Foreign key to Days/ Exercise name
  TextColumn get code => text()(); // Exercise code
  IntColumn get exerciseOrder => integer()();
  IntColumn get createdAt => integer().withDefault(
      Constant(DateTime.now().millisecondsSinceEpoch))(); // Creation timestamp
  IntColumn get updatedAt =>
      integer().nullable()(); // Nullable updated timestamp
}
