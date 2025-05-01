import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';

abstract class BroadcastRepository {
  ///
  Future<Either<Failures, void>> sendNotification(
    NotificationEntity notification,
  );

  ///
  Future<Either<Failures, void>> createAnnouncement(
    Announcement announcement,
  );

  ///
  Future<Either<Failures, void>> deleteAnnouncement({
    required String announcementId,
  });

  ///
  Future<Either<Failures, void>> editAnnouncement(
    Announcement announcement,
  );

  ///
  Future<Either<Failures, Stream<List<Announcement>>>> watchAnnouncements();

  ///
  Future<Either<Failures, Stream<List<Comment>>>> watchCommentsByAnnouncementId(
      String announcementId);

  ///
  Future<Either<Failures, Stream<List<Reaction>>>>
      watchReactionsByAnnouncementId(String announcementId);

  ///
  Future<Either<Failures, void>> addComment({
    required String announcementId,
    required Comment comment,
  });

  ///
  Future<Either<Failures, void>> updateComment({
    required String announcementId,
    required Comment comment,
  });

  ///
  Future<Either<Failures, void>> addReaction({
    required String announcementId,
    required Reaction reaction,
  });

  ///
  Future<Either<Failures, void>> updateReaction({
    required String announcementId,
    required Reaction reaction,
  });
}
