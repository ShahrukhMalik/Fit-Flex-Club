import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/emoji_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/broadcast_usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';

abstract class GetEmojisUsecase extends BroadcastUsecase
    implements UseCase<List<EmojiEntity>, NoParams> {}

@Singleton(as: GetEmojisUsecase)
class GetEmojisUsecaseImpl extends GetEmojisUsecase {
  final BroadcastRepository broadcastRepository;
  GetEmojisUsecaseImpl({required this.broadcastRepository});
  @override
  Future<Either<Failures, List<EmojiEntity>>> call(NoParams params) {
    return broadcastRepository.getEmojis();
  }
}
