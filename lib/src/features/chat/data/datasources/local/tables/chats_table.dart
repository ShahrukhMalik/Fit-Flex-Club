import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/converters/converters.dart';

class Chats extends Table {
  TextColumn get id => text()(); // chatId: sorted combination of user IDs
  TextColumn get lastMessage => text().nullable()();
  TextColumn get lastSender => text()();
  DateTimeColumn get lastTimestamp => dateTime()();
  // List of 2 members (UIDs)
  TextColumn get members => text().map(const MemberListMapConverter())();
  // unreadCount as Map<String, int>
  TextColumn get unreadCount => text().map(const StringIntMapConverter())();
  @override
  Set<Column> get primaryKey => {id};
}
