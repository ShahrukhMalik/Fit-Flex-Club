import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/converters/converters.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/tables/chats_table.dart';

class Messages extends Table {
  TextColumn get id => text()(); // Firestore doc ID or UUID
  TextColumn get senderId => text()();
  TextColumn get messageText => text().nullable()();
  TextColumn get mediaUrl => text().nullable()();
  BlobColumn get mediaBytes => blob().nullable()();
  TextColumn get type =>
      text().withDefault(const Constant('text'))(); // text, image etc.
  DateTimeColumn get timestamp => dateTime()();
  // These three are List<String>
  TextColumn get sentTo => text().map(const StringListConverter())();
  TextColumn get deliveredTo => text().map(const StringListConverter())();
  TextColumn get readBy => text().map(const StringListConverter())();

  TextColumn get chatId => text().nullable().references(Chats, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
