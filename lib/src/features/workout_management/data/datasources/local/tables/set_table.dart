import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';

class ExerciseSets extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  @override
  Set<Column> get primaryKey => {id}; // Auto-increment primary key
  TextColumn get exerciseId =>
      text().references(WorkoutPlanExercise, #id)(); // Foreign key to Exercises
  TextColumn get clientId => text().nullable().references(Clients, #id)();
  IntColumn get targetReps => integer().nullable()();
  RealColumn get targetWeight => real().nullable()();
  RealColumn get targetDistance => real().nullable()();
  IntColumn get targetTime => integer().nullable()(); // Stored in seconds
  IntColumn get createdAt =>
      integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)();
  IntColumn get updatedAt =>
      integer().nullable()(); // Nullable updated timestamp
  IntColumn get setNumber => integer()();
}
