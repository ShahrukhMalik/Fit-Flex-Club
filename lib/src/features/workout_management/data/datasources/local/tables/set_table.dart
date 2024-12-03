import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';

class ExerciseSets extends Table {
  IntColumn get id => integer().autoIncrement()(); // Auto-increment primary key
  IntColumn get exerciseUid =>
      integer().references(Exercises, #id)(); // Foreign key to Exercises
  IntColumn get targetReps => integer().nullable()();
  RealColumn get targetWeight => real().nullable()();
  RealColumn get targetDistance => real().nullable()();
  IntColumn get targetTime => integer().nullable()(); // Stored in seconds
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  IntColumn get updatedAt => integer()();
}
