import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/chat_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user IsUserActive
abstract class StartChatUsecase extends ChatUsecase
    implements UseCase<void, Params> {}

class Params extends Equatable {
  final ChatEntity chat;

  const Params({
    required this.chat,
  });

  @override
  List<Object?> get props => [chat];
}

@Singleton(as: StartChatUsecase)
class StartChatUsecaseImpl extends StartChatUsecase {
  final ChatRepository chatRepository;

  StartChatUsecaseImpl({required this.chatRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return chatRepository.startChat(chat: params.chat);
  }
}
