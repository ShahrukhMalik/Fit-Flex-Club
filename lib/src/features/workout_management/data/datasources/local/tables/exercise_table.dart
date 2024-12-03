import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()(); // Auto-increment primary key
  IntColumn get dayUid => integer().references(Days, #id)(); // Foreign key to Days/ Exercise name
  IntColumn get code => integer()(); // Exercise code
  IntColumn get createdAt => integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))(); // Creation timestamp
  IntColumn get updatedAt => integer().nullable()(); // Nullable updated timestamp
}
