// chat_dao.dart
import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/tables/chats_table.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/tables/messages_table.dart';
import 'package:fit_flex_club/src/features/chat/data/models/chat_model.dart';
import 'package:fit_flex_club/src/features/chat/data/models/message_model.dart';
import 'package:injectable/injectable.dart';
part 'chat_dao.g.dart';

@DriftAccessor(tables: [Chats, Messages])
@injectable
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  Future<void> updateMessageStatus({
    required List<MessageModel> unReadMessages,
    required ChatModel chat,
  }) async {
    for (final message in unReadMessages) {
      await (update(messages)..where((tbl) => tbl.id.equals(message.id))).write(
        MessagesCompanion(
          deliveredTo: Value(
            message.deliveredTo,
          ),
          readBy: Value(
            message.readBy,
          ),
        ),
      );
    }
    await (update(chats)..where((tbl) => tbl.id.equals(chat.id))).write(
      ChatsCompanion(
        unreadCount: Value(
          chat.unreadCount,
        ),
      ),
    );
  }

  // 👉 Insert a single chat
  Future<void> insertChat(ChatsCompanion chat) async {
    await into(chats).insert(chat, mode: InsertMode.insertOrIgnore);
  }

  // 👉 Insert a message
  Future<void> insertMessage(MessagesCompanion message) async {
    await into(messages).insertOnConflictUpdate(message);
    await (update(chats)..where((tbl) => tbl.id.equals(message.chatId.value!)))
        .write(
      ChatsCompanion(
        lastMessage: Value(message.messageText.value),
        lastSender: Value(message.senderId.value),
      ),
    );
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

  // 👉 Batch insert chats and their messages
  Future<void> batchInsertChats(
    List<ChatsCompanion> chatsList,
  ) async {
    await batch((batch) {
      batch.insertAll(
        chats,
        chatsList,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  // 👉 Batch insert chats and their messages
  Future<void> batchInsertMessages(
    List<MessagesCompanion> messagesList,
  ) async {
    await batch((batch) {
      batch.replaceAll(
        messages,
        messagesList,
      );
    });
  }

  // 👉 Get all chats
  Future<List<Chat>> getAllChats() {
    return select(chats).get();
  }

  Future<Chat?> getChat(String chatId) {
    return (select(chats)..where((tbl) => tbl.id.equals(chatId)))
        .getSingleOrNull();
  }

  // Future<Chat?> getLatestChatByMemberId(String userId) async {
  //   final allChats = await (select(chats)
  //         ..orderBy([
  //           (tbl) => OrderingTerm(
  //               expression: tbl.lastTimestamp, mode: OrderingMode.desc)
  //         ])
  //         ..limit(1))
  //       .get();

  //   for (final chat in allChats) {
  //     if (chat.members.any((member) => member['userId'] == userId)) {
  //       return chat;
  //     }
  //   }
  //   return null;
  // }

  Stream<List<Chat?>> watchLatestChatByMemberId(String userId) {
    return (select(chats)
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.lastTimestamp, mode: OrderingMode.desc)
          ]))
        .watch(); // Only emit if chat is not null
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
    print("🔍 Listening to messages for chatId: $chatId");
    return (select(messages)
          ..where((m) => m.chatId.equals(chatId))
          ..orderBy([
            (m) =>
                OrderingTerm(expression: m.timestamp, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  // 👉 Delete a chat (automatically deletes messages if cascade is set)
  Future<void> deleteChat(String chatId) async {
    await (delete(chats)..where((c) => c.id.equals(chatId))).go();
  }
}
