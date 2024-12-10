import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';

class WorkoutPlans extends Table {
  TextColumn get uid => text()(); // Primary key
  TextColumn get name => text().withLength(min: 1, max: 255)(); // Plan name
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  IntColumn get updatedAt => integer().nullable()();
  TextColumn get clientId => text().nullable().references(Clients, #id)();
  @override
  Set<Column> get primaryKey => {uid};
}
