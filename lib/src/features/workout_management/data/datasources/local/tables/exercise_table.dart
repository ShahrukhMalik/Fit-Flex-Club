import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';

class WorkoutPlanExercise extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  TextColumn get clientId => text().nullable().references(Clients, #id)();
  @override
  Set<Column> get primaryKey => {id}; // Auto-increment primary key
  TextColumn get dayId =>
      text().references(Days, #id)(); // Foreign key to Days/ Exercise name
  TextColumn get code => text()(); // Exercise code
  IntColumn get exerciseOrder => integer()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)(); // Creation timestamp
  IntColumn get updatedAt =>
      integer().nullable()(); // Nullable updated timestamp
}
