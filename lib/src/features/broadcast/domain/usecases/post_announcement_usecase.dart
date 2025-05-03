import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/broadcast_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class PostAnnouncementUsecase extends BroadcastUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final Announcement announcement;
  const Params({required this.announcement});
  @override
  List<Object?> get props => [
        announcement,
      ];
}

@Singleton(as: PostAnnouncementUsecase)
class PostAnnouncementUsecaseImpl extends PostAnnouncementUsecase {
  final BroadcastRepository broadcastRepository;
  PostAnnouncementUsecaseImpl({required this.broadcastRepository});
  @override
  Future<Either<Failures, void>>? call(Params params) {
    return broadcastRepository.createAnnouncement(
      params.announcement,
    );
  }
}