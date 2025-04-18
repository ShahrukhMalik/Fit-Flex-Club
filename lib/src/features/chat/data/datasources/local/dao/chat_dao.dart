// chat_dao.dart
import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/tables/chats_table.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/tables/messages_table.dart';
part 'chat_dao.g.dart';

@DriftAccessor(tables: [Chats, Messages])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  // 👉 Insert a single chat
  Future<void> insertChat(ChatsCompanion chat) async {
    await into(chats).insert(chat, mode: InsertMode.insertOrIgnore);
  }

  // 👉 Insert a message
  Future<void> insertMessage(MessagesCompanion message) async {
    await into(messages).insert(message);
  }

  // 👉 Batch insert chats and their messages
  Future<void> batchInsertChatsWithMessages(
    List<ChatsCompanion> chatsList,
    List<MessagesCompanion> messagesList,
  ) async {
    await batch((batch) {
      batch.insertAll(
        chats,
        chatsList,
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        messages,
        messagesList,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  // 👉 Get all chats
  Future<List<Chat>> getAllChats() {
    return select(chats).get();
  }

  // 👉 Watch all chats
  Stream<List<Chat>> watchAllChats() {
    return select(chats).watch();
  }

  // 👉 Get messages for a chat
  Future<List<Message>> getMessagesByChatId(String chatId) {
    return (select(messages)..where((m) => m.chatId.equals(chatId))).get();
  }

  // 👉 Stream chat messages for live updates
  Stream<List<Message>> watchMessagesByChatId(String chatId) {
    return (select(messages)..where((m) => m.chatId.equals(chatId))).watch();
  }

  // 👉 Delete a chat (automatically deletes messages if cascade is set)
  Future<void> deleteChat(String chatId) async {
    await (delete(chats)..where((c) => c.id.equals(chatId))).go();
  }
}
