import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';

class WorkoutHistorySet extends Table {
  IntColumn get id => integer().autoIncrement()(); // Auto-increment primary key
  TextColumn get clientUid => text()();
  IntColumn get exerciseUid =>
      integer().references(Exercises, #id)(); // Foreign key to Exercises
  IntColumn get actualReps => integer().nullable()();
  RealColumn get actualWeight => real().nullable()();
  RealColumn get actualDistance => real().nullable()();
  IntColumn get actualTime => integer().nullable()(); // Stored in seconds
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  IntColumn get updatedAt => integer()();
}
