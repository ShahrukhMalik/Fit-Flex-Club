// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/dao/chat_dao.dart';
import 'package:fit_flex_club/src/features/chat/data/models/chat_model.dart';
import 'package:fit_flex_club/src/features/chat/data/models/message_model.dart';
import 'package:injectable/injectable.dart';

abstract class ChatLocalDatasource {
  ///
  Future<void> startChat({required ChatModel chat});

  ///
  Future<ChatModel> getChatById({required String chatId});

  ///
  Future<Stream<ChatModel?>> getChat({required String userId});

  ///
  Future<void> startMessage({required MessageModel message});

  ///
  Future<void> insertChats({required List<ChatModel> chats});

  ///
  Future<void> insertMessages({required List<MessageModel> messages});

  ///
  Future<void> updateMessageStatus(
      {required MessageModel message, required ChatModel chat});

  ///
  Future<Stream<List<ChatModel>>> getChatStream();

  ///
  Future<Stream<List<MessageModel>>> getMessagesByChatStream(String chatId);
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
      await chatDao.batchInsertChats(
        chats
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
            .toList(),
      );
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

  @override
  Future<Stream<List<MessageModel>>> getMessagesByChatStream(
      String chatId) async {
    try {
      final messagesByChatIdStream = chatDao.watchMessagesByChatId(chatId);

      final transformedStream = messagesByChatIdStream.map(
        (messagesList) => messagesList
            .map((message) => MessageModel.fromLocal(message.toJson()))
            .toList(),
      );

      return transformedStream;
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertMessages({required List<MessageModel> messages}) async {
    try {
      await chatDao.batchInsertMessages(
        messages
            .map(
              (message) => MessagesCompanion(
                  id: Value(message.id),
                  chatId: Value(message.chatId),
                  deliveredTo: Value(message.deliveredTo),
                  messageText: Value(message.messageText),
                  readBy: Value(message.readBy),
                  senderId: Value(message.senderId),
                  sentTo: Value(message.sentTo),
                  timestamp: Value(message.timestamp),
                  type: Value(message.type)),
            )
            .toList(),
      );
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> startMessage({required MessageModel message}) async {
    try {
      await chatDao.insertMessage(
        MessagesCompanion(
          id: Value(message.id),
          chatId: Value(message.chatId),
          deliveredTo: Value(message.deliveredTo),
          messageText: Value(message.messageText),
          type: Value(message.type),
          timestamp: Value(message.timestamp),
          sentTo: Value(message.sentTo),
          readBy: Value(message.readBy),
          senderId: Value(
            message.senderId,
          ),
        ),
      );
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<Stream<ChatModel?>> getChat({required String userId}) async {
    try {
      final chat =
          await chatDao.watchLatestChatByMemberId(userId).map((chatList) {
        // Find the first chat where userId is a member
        return chatList.firstWhere(
          (chat) =>
              chat != null &&
              chat.members.any((member) => member['userId'] == userId),
          orElse: () => null,
        );
      }).firstWhere((chat) => chat != null); // Wait until a valid one appears

      // Return a single-value stream with the mapped model
      return Stream.value(ChatModel(
        id: chat!.id,
        members: chat.members,
        lastMessage: chat.lastMessage ?? 'No messages yet...',
        lastSender: chat.lastSender,
        lastTimestamp: DateTime.fromMillisecondsSinceEpoch(chat.lastTimestamp),
        unreadCount: chat.unreadCount,
      ));
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> updateMessageStatus({
    required MessageModel message,
    required ChatModel chat,
  }) async {
    try {
      await chatDao.updateMessageStatus(message: message, chat: chat);
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<ChatModel> getChatById({required String chatId}) async {
    try {
      final chat = await chatDao.getChat(chatId);
      if (chat == null) throw CacheException(errorMessage: "Chat Not Found");
      return ChatModel.fromLocal(chat.toJson());
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }
}
