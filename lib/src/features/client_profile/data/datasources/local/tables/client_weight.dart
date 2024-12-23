import 'package:drift/drift.dart';

class ClientWeight extends Table {
  // Unique identifier for the client (can be nullable if optional)
  TextColumn get clientId => text().nullable()();

  // Timestamp for the recorded weight
  IntColumn get timeStamp => integer()();

  // Weight in kilograms
  RealColumn get weightInKg => real()();

  // Weight in pounds
  RealColumn get weightInLb => real()();

  IntColumn get createdAt =>
      integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)();
  IntColumn get updatedAt =>
      integer().nullable()(); // Default value for updatedAt
  // Primary key for uniqueness (clientId + timeStamp combination)
  @override
  Set<Column> get primaryKey => {clientId, timeStamp};
}
