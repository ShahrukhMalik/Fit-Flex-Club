import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';

class WorkoutHistorySet extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  @override
  Set<Column> get primaryKey => {id}; // Auto-increment primary key
  TextColumn get clientId => text()();
  TextColumn get exerciseId =>
      text().references(WorkoutPlanExercise, #id)(); // Foreign key to Exercises
  IntColumn get actualReps => integer().nullable()();
  RealColumn get actualWeight => real().nullable()();
  RealColumn get actualDistance => real().nullable()();
  IntColumn get actualTime => integer().nullable()(); // Stored in seconds
  IntColumn get createdAt =>
      integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)();
  IntColumn get updatedAt => integer().nullable()();
}
