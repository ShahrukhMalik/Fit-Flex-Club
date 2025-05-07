import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/broadcast_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class WatchCommentsByAnnouncementIdUsecase extends BroadcastUsecase
    implements UseCase<Stream<List<Comment>>, Params> {}

class Params extends Equatable {
  final String announcementId;
  const Params({required this.announcementId});
  @override
  List<Object?> get props => [announcementId];
}

@Singleton(as: WatchCommentsByAnnouncementIdUsecase)
class WatchCommentsByAnnouncementIdUsecaseImpl
    extends WatchCommentsByAnnouncementIdUsecase {
  final BroadcastRepository broadcastRepository;
  WatchCommentsByAnnouncementIdUsecaseImpl({required this.broadcastRepository});
  @override
  Future<Either<Failures, Stream<List<Comment>>>> call(Params params) {
    return broadcastRepository.watchCommentsByAnnouncementId(
      params.announcementId,
    );
  }
}
