import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';

class Days extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  @override
  Set<Column> get primaryKey => {id};
  TextColumn get weekUid =>
      text().references(Weeks, #id)(); // Foreign key to Weeks
  IntColumn get dayNumber => integer()(); // Day number within the week
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  IntColumn get updatedAt => integer()();
}
