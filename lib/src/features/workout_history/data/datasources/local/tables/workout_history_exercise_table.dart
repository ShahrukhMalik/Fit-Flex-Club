import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';

class WorkoutHistoryExercise extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  TextColumn get clientId => text().nullable().references(Clients, #id)();
  @override
  Set<Column> get primaryKey => {id}; // Auto-increment primary key
  TextColumn get code => text()(); // Exercise code
  IntColumn get exerciseOrder => integer()();
  BoolColumn get reps =>
      boolean().withDefault(Constant(false))(); // Defaults to true
  BoolColumn get duration =>
      boolean().withDefault(Constant(false))(); // Defaults to false
  BoolColumn get weight =>
      boolean().withDefault(Constant(false))(); // Defaults to true
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  TextColumn get category => text().nullable()(); // Category (e.g., equipment)
  TextColumn get muscleGroup =>
      text().withLength(min: 1, max: 100)(); // Muscle group
  TextColumn get name => text().withLength(min: 1, max: 255)(); //
  TextColumn get gifUrl => text().nullable().withLength(min: 1, max: 100)(); // GIF
  IntColumn get createdAt => integer().clientDefault(
      () => DateTime.now().millisecondsSinceEpoch)(); // Creation timestamp
  IntColumn get updatedAt =>
      integer().nullable()(); // Nullable updated timestamp
}
