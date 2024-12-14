import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';

class BaseExercise extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  @override
  Set<Column> get primaryKey => {id}; // Primary key, auto-incremented
  TextColumn get clientId => text().nullable().references(Clients, #id)();
  TextColumn get code => text()(); // Exercise code
  TextColumn get category => text().nullable()(); // Category (e.g., equipment)
  TextColumn get muscleGroup =>
      text().withLength(min: 1, max: 100)(); // Muscle group
  TextColumn get name => text().withLength(min: 1, max: 255)(); // Exercise name
  // Additional Boolean fields
  BoolColumn get reps =>
      boolean().withDefault(Constant(false))(); // Defaults to true
  BoolColumn get duration =>
      boolean().withDefault(Constant(false))(); // Defaults to false
  BoolColumn get weight =>
      boolean().withDefault(Constant(false))(); // Defaults to true

  IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)(); // Creation timestamp
  IntColumn get updatedAt =>
      integer().nullable()(); // Nullable updated timestamp
}
