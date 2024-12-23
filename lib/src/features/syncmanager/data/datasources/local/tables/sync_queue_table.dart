import 'package:drift/drift.dart';

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operation => text()(); // e.g., 'INSERT', 'UPDATE', 'DELETE'
  TextColumn get data => text()(); // JSON-encoded data for the operation
  TextColumn get table => text()(); // The table affected by the operation
  IntColumn get timestamp => integer()(); // Time of the operation in milliseconds
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
}
