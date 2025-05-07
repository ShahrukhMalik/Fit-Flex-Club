import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/broadcast_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class WatchReactionsByAnnouncementIdUsecase extends BroadcastUsecase
    implements UseCase<List<Reaction>, Params> {}

class Params extends Equatable {
  final String announcementId;
  const Params({required this.announcementId});
  @override
  List<Object?> get props => [announcementId];
}

@Singleton(as: WatchReactionsByAnnouncementIdUsecase)
class WatchReactionsByAnnouncementIdUsecaseImpl
    extends WatchReactionsByAnnouncementIdUsecase {
  final BroadcastRepository broadcastRepository;
  WatchReactionsByAnnouncementIdUsecaseImpl(
      {required this.broadcastRepository});
  @override
  Future<Either<Failures, List<Reaction>>> call(Params params) {
    return broadcastRepository.watchReactionsByAnnouncementId(
      params.announcementId,
    );
  }
}
