import 'package:drift/drift.dart';

class Announcements extends Table {
  TextColumn get id => text()();
  TextColumn get trainerId => text()();
  TextColumn get trainerName => text()();
  TextColumn get content => text()();
  TextColumn get mediaUrl => text().nullable()();
  TextColumn get postType => text()(); // Drift supports enum mapping
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
