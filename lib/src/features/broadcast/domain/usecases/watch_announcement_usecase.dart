import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/broadcast_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class WatchAnnouncementUsecase extends BroadcastUsecase
    implements UseCase<Stream<List<Announcement>>, NoParams> {}

@Singleton(as: WatchAnnouncementUsecase)
class WatchAnnouncementUsecaseImpl extends WatchAnnouncementUsecase {
  final BroadcastRepository broadcastRepository;
  WatchAnnouncementUsecaseImpl({required this.broadcastRepository});
  @override
  Future<Either<Failures, Stream<List<Announcement>>>> call(NoParams params) {
    return broadcastRepository.watchAnnouncements();
  }
}
