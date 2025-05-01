import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/broadcast/data/datasources/local/tables/announcements_table.dart';

class Comments extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get announcementId => text().references(Announcements, #id)();
  TextColumn get userName => text()();
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
