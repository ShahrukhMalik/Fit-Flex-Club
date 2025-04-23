import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/chat_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateMessageUsecase extends ChatUsecase
    implements UseCase<void, Params> {}

class Params extends Equatable {
  final MessageEntity message;
  final ChatEntity chat;

  const Params({
    required this.chat,
    required this.message,
  });

  @override
  List<Object?> get props => [chat, message];
}

@Singleton(as: UpdateMessageUsecase)
class UpdateMessageUsecaseImpl extends UpdateMessageUsecase {
  final ChatRepository chatRepository;
  UpdateMessageUsecaseImpl({required this.chatRepository});
  @override
  Future<Either<Failures, void>>? call(Params params) {
    return chatRepository.updateMessageStatus(
      chat: params.chat,
      message: params.message,
    );
  }
}
