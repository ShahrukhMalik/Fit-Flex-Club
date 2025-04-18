import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
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
    // TODO: implement startChat
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, Stream<List<ChatEntity>>>> watchChats() async {
    // TODO: implement watchChats
    throw UnimplementedError();
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
