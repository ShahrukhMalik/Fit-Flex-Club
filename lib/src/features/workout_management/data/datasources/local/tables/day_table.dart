import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';

class Days extends Table {
  TextColumn get id => text()(); // Auto-increment primary key
  @override
  Set<Column> get primaryKey => {id};
  TextColumn get weekId =>
      text().references(Weeks, #id)(); // Foreign key to Weeks
  TextColumn get clientId =>
      text().nullable().references(Clients, #id)(); // Foreign key to Weeks
  IntColumn get dayNumber => integer()(); // Day number within the week
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  IntColumn get updatedAt => integer().nullable()();
}
