// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/dao/chat_dao.dart';
import 'package:fit_flex_club/src/features/chat/data/models/chat_model.dart';
import 'package:injectable/injectable.dart';

abstract class ChatLocalDatasource {
  ///
  Future<void> startChat({required ChatModel chat});

  ///
  Future<void> insertChats({required List<ChatModel> chats});

  ///
  Future<Stream<List<ChatModel>>> getChatStream();
}

@Singleton(as: ChatLocalDatasource)
class ChatLocalDatasourceImpl extends ChatLocalDatasource {
  final ChatDao chatDao;
  ChatLocalDatasourceImpl({
    required this.chatDao,
  });
  @override
  Future<void> startChat({required ChatModel chat}) async {
    try {
      await chatDao.insertChat(
        ChatsCompanion(
          id: Value(chat.id),
          lastMessage: Value(chat.lastMessage),
          lastSender: Value(chat.lastSender),
          lastTimestamp: Value(chat.lastTimestamp.millisecondsSinceEpoch),
          members: Value(chat.members),
          unreadCount: Value(chat.unreadCount),
        ),
      );
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertChats({required List<ChatModel> chats}) async {
    try {
      await chatDao.batchInsertChats(chats
          .map(
            (chat) => ChatsCompanion(
              id: Value(chat.id),
              lastMessage: Value(chat.lastMessage),
              lastSender: Value(chat.lastSender),
              lastTimestamp: Value(chat.lastTimestamp.millisecondsSinceEpoch),
              members: Value(chat.members),
              unreadCount: Value(chat.unreadCount),
            ),
          )
          .toList());
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<Stream<List<ChatModel>>> getChatStream() async {
    try {
      final chatStream = chatDao.watchAllChats();

      final transformedStream = chatStream.map(
        (chatList) =>
            chatList.map((chat) => ChatModel.fromLocal(chat.toJson())).toList(),
      );

      return transformedStream;
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }
}
