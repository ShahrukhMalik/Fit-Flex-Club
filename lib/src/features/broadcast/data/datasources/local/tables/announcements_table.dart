import 'package:drift/drift.dart';

class Announcements extends Table {
  TextColumn get id => text()();
  TextColumn get trainerId => text().nullable()();
  TextColumn get gymId => text().nullable()();
  TextColumn get trainerName => text().nullable()();
  TextColumn get postedFor => text()();
  TextColumn get gymName => text().nullable()();
  TextColumn get content => text().nullable()();
  TextColumn get mediaUrl => text().nullable()();
  BlobColumn get mediaBytes => blob().nullable()();
  TextColumn get postType => text()(); // Drift supports enum mapping
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
