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
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/daos/sync_queue_dao.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/tables/sync_queue_table.dart';
import 'package:injectable/injectable.dart';

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
  Future<Either<Failures, ChatEntity>> getChat() {
    // TODO: implement getChat
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> sendMessage({
    required MessageEntity message,
    required ChatEntity chat,
  }) async {
    // TODO: implement sendMessage
    throw UnimplementedError();
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
    // TODO: implement watchMessagesByChatId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> updateMessageStatus({
    required MessageEntity message,
    required ChatEntity chat,
  }) async {
    // TODO: implement updateMessageStatus
    throw UnimplementedError();
  }
}

enum ChatEvents { startChat }
