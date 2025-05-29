import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/chat_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user IsUserActive
abstract class WatchChatStreamUsecase extends ChatUsecase
    implements UseCase<Stream<List<ChatEntity>>, NoParams> {}

@Singleton(as: WatchChatStreamUsecase)
class WatchChatStreamUsecaseImpl extends WatchChatStreamUsecase {
  final ChatRepository chatRepository;

  WatchChatStreamUsecaseImpl({required this.chatRepository});

  @override
  Future<Either<Failures, Stream<List<ChatEntity>>>>? call(NoParams params) {
    return chatRepository.watchChats();
  }
}
