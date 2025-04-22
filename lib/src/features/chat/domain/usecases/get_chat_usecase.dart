import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/chat_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class GetChatUsecase extends ChatUsecase
    implements UseCase<Stream<ChatEntity?>, NoParams> {}

@Singleton(as: GetChatUsecase)
class GetChatUsecaseImpl extends GetChatUsecase {
  final ChatRepository chatRepository;

  GetChatUsecaseImpl({required this.chatRepository});

  @override
  Future<Either<Failures, Stream<ChatEntity?>>> call(NoParams params) {
    return chatRepository.getChat();
  }
}
