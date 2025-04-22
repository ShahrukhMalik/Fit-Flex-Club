import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  ///
  Future<Either<Failures, Stream<List<ChatEntity>>>> watchChats();

  ///
  Future<Either<Failures, Stream<ChatEntity?>>> getChat();

  ///
  Future<Either<Failures, Stream<List<MessageEntity>>>> watchMessagesByChatId({
    required String chatId,
  });

  ///
  Future<Either<Failures, void>> startChat({required ChatEntity chat});

  ///
  Future<Either<Failures, void>> sendMessage({
    required MessageEntity message,
    required ChatEntity chat,
  });

  ///
  Future<Either<Failures, void>> updateMessageStatus({
    required MessageEntity message,
    required ChatEntity chat,
  });
}
