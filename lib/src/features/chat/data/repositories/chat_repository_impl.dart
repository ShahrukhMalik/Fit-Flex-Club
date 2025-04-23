// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/local/chat_local_datasource.dart';
import 'package:fit_flex_club/src/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:fit_flex_club/src/features/chat/data/models/chat_model.dart';
import 'package:fit_flex_club/src/features/chat/data/models/message_model.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/daos/sync_queue_dao.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/tables/sync_queue_table.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid_v4/uuid_v4.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final NetworkInfo networkInfo;
  final ChatLocalDatasource localDb;
  final ChatRemoteDatasource remoteDb;
  final SyncQueueDao syncQueue;

  ChatRepositoryImpl({
    required this.networkInfo,
    required this.localDb,
    required this.remoteDb,
    required this.syncQueue,
  });
  @override
  Future<Either<Failures, Stream<ChatEntity?>>> getChat() async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(
          ServerFailure(
            code: '07',
            message: 'Auth ID not found',
          ),
        );
      }

      final chatStream = await localDb.getChat(userId: authId);

      if (isConnected) {
        final remoteChatStream = await remoteDb.getChat();
        // if (remoteChat != null) {
        await for (final chat in remoteChatStream) {
          if (chat != null) {
            await localDb.startChat(chat: chat);
          }
        }
        // }
      }

      return Right(
        chatStream.map(
          (chat) {
            if (chat == null) return null;
            return ChatEntity(
              id: chat.id,
              members: chat.members,
              lastMessage: chat.lastMessage,
              lastSender: chat.lastSender,
              lastTimestamp: chat.lastTimestamp,
              unreadCount: chat.unreadCount,
            );
          },
        ),
      );
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> sendMessage({
    required MessageEntity message,
    required ChatEntity chat,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(ServerFailure(code: '07', message: 'Auth ID not found'));
      }

      final messageId = 'message_${chat.id}_${UUIDv4().toString()}';
      final retrievedChat = await localDb.getChatById(chatId: chat.id);
      final messageModel = MessageModel(
        id: messageId,
        chatId: chat.id,
        senderId: authId,
        messageText: message.messageText,
        timestamp: DateTime.now(),
        type: message.type,
        sentTo: List<String>.from(chat.members
            .map(
              (member) => member['userId'],
            )
            .where(
              (element) => element != authId,
            )
            .toList()),
        deliveredTo: [],
        readBy: [],
      );
      await localDb.startMessage(
        message: messageModel,
      );
      final updatedUnreadCount =
          Map<String, int>.from(retrievedChat.unreadCount);

      updatedUnreadCount.updateAll((key, value) {
        return key == authId ? value : value + 1;
      });

      final updatedChat = ChatModel(
        id: chat.id,
        members: chat.members,
        lastMessage: message.messageText,
        lastSender: authId,
        lastTimestamp: DateTime.now(),
        unreadCount: updatedUnreadCount,
      );
      if (isConnected) {
        return Right(
          await remoteDb.sendMessage(
            message: messageModel,
            chat: updatedChat,
          ),
        );
      } else {
        return Right(
          await syncQueue.logSyncAction(
            ChatEvents.startMessage.name,
            "Messages",
            {
              'chat': updatedChat.toMap(),
              'message': messageModel.toMap(),
            },
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> startChat({
    required ChatEntity chat,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(ServerFailure(code: '07', message: 'Auth ID not found'));
      }
      final chatModel = ChatModel(
        id: 'chat_${[
          authId,
          ...chat.members.map(
            (e) => e['userId'],
          )
        ].join('_')}',
        members: chat.members,
        lastMessage: "No messages yet",
        lastSender: authId,
        lastTimestamp: DateTime.now(),
        unreadCount: [
          authId,
          ...chat.members.map((e) => e['userId']),
        ].fold<Map<String, int>>(
          {},
          (acc, id) {
            acc[id] = 0;
            return acc;
          },
        ),
      );
      await localDb.startChat(
        chat: chatModel,
      );
      if (isConnected) {
        return Right(await remoteDb.startChat(chat: chatModel));
      } else {
        return Right(
          await syncQueue.logSyncAction(
            ChatEvents.startChat.name,
            "Chats",
            chatModel.toMap(),
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, Stream<List<ChatEntity>>>> watchChats() async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final localChatStream = await localDb.getChatStream();

      if (isConnected) {
        final remoteChatStream = await remoteDb.watchChats();

        // Listen without awaiting the full stream
        remoteChatStream.listen(
          (remoteChats) async {
            await localDb.insertChats(chats: remoteChats); // ✅ update local
          },
          onError: (e) {
            // optional: handle remote stream errors
          },
          cancelOnError: false, // keep syncing even after recoverable errors
        );
      }

      // ✅ Always return the local stream
      return Right(localChatStream);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, Stream<List<MessageEntity>>>> watchMessagesByChatId({
    required String chatId,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final localMessagesByChatIdStream =
          await localDb.getMessagesByChatStream(chatId);

      if (isConnected) {
        final remoteMessagesByChatIdStream =
            await remoteDb.watchMessagesByChatId(chatId: chatId);

        // Listen without awaiting the full stream
        remoteMessagesByChatIdStream.listen(
          (remoteMessages) async {
            await localDb.insertMessages(
                messages: remoteMessages); // ✅ update local
          },
          onError: (e) {
            // optional: handle remote stream errors
          },
          cancelOnError: false, // keep syncing even after recoverable errors
        );
      }

      // ✅ Always return the local stream
      return Right(localMessagesByChatIdStream);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> updateMessageStatus({
    required List<MessageEntity> unReadMessages,
    required ChatEntity chat,
  }) async {
    try {
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(ServerFailure(code: '07', message: 'Auth ID not found'));
      }
      final isConnected = await networkInfo.isConnected ?? false;
      final updatedMessageModel = unReadMessages
          .map(
            (message) => MessageModel.fromEntity(message).copyWith(
              readBy: [
                authId,
                ...message.readBy,
              ],
            ),
          )
          .toList();

      final retrievedChat = await localDb.getChatById(chatId: chat.id);
      final updatedChat = retrievedChat.copyWith(
        unreadCount: Map.fromEntries(
          chat.unreadCount.entries.map(
            (obj) {
              if (obj.key == authId) {
                return MapEntry(obj.key, 0);
              } else {
                return MapEntry(obj.key, obj.value);
              }
            },
          ),
        ),
      );

      // await localDb.updateMessageStatus(
      //   unReadMessages: updatedMessageModel,
      //   chat: updatedChat,
      // );
      if (isConnected) {
        return Right(
          await remoteDb.updateMessageStatus(
            unReadMessages: updatedMessageModel,
            chat: updatedChat,
          ),
        );
      } else {
        return Right(
          await syncQueue.logSyncAction(
            ChatEvents.updateMessage.name,
            "Update Message Status",
            {
              'unreadMessages': updatedMessageModel
                  .map(
                    (e) => e.toMap(),
                  )
                  .toList(),
              'chat': updatedChat.toMap()
            },
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<ChatEntity>>> getAllChats() async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final remoteChats = await remoteDb.getAllChats();
      await localDb.insertChats(chats: remoteChats);
      if (isConnected) {
        return Right(remoteChats);
      } else {
        throw ServerException(
          errorMessage: "No Internet Connection",
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }
}

enum ChatEvents { startChat, startMessage, updateMessage }
