import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/chat_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class WatchMessagesByChatIdUsecase extends ChatUsecase
    implements UseCase<Stream<List<MessageEntity>>, Params> {}

class Params extends Equatable {
  final String chatId;

  const Params({
    required this.chatId,
  });

  @override
  List<Object?> get props => [chatId];
}

@Singleton(as: WatchMessagesByChatIdUsecase)
class WatchMessagesByChatIdUsecaseImpl extends WatchMessagesByChatIdUsecase {
  final ChatRepository chatRepository;

  WatchMessagesByChatIdUsecaseImpl({required this.chatRepository});

  @override
  Future<Either<Failures, Stream<List<MessageEntity>>>>? call(Params params) {
    return chatRepository.watchMessagesByChatId(chatId: params.chatId);
  }
}
