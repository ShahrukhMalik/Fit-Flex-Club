import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/broadcast/data/datasources/local/daos/broadcast_dao.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/announcement_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/comment_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/reaction_model.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:injectable/injectable.dart';

abstract class BroadcastLocalDatasource {
  ///
  Future<void> sendNotification(
    NotificationEntity notification,
  );

  ///
  Future<void> createAnnouncement(
    AnnouncementModel announcement,
  );

  ///
  Future<void> insertAnnouncements(
    List<AnnouncementModel> announcements,
  );

  ///
  Future<void> insertComments(
    List<CommentModel> comments,
  );

  ///
  Future<void> insertReactions(
    List<ReactionModel> reactions,
  );

  ///
  Future<void> deleteAnnouncement({
    required String announcementId,
  });

  ///
  Future<void> editAnnouncement(
    AnnouncementModel announcement,
  );

  ///
  Future<Stream<List<AnnouncementModel>>> watchAnnouncements();

  ///
  Future<void> addComment({
    required String announcementId,
    required CommentModel comment,
  });

  ///
  Future<void> updateComment({
    required String announcementId,
    required CommentModel comment,
  });

  ///
  Future<void> addReaction({
    required String announcementId,
    required ReactionModel reaction,
  });

  ///
  Future<void> updateReaction({
    required String announcementId,
    required ReactionModel reaction,
  });

  ///
  Future<Stream<List<CommentModel>>> watchCommentsByAnnouncementId(
    String announcementId,
  );

  ///
  Future<List<ReactionModel>> watchReactionsByAnnouncementId(
    String announcementId,
  );
}

@Singleton(as: BroadcastLocalDatasource)
class BroadcastLocalDatasourceImpl extends BroadcastLocalDatasource {
  final BroadcastDao broadcastDao;

  BroadcastLocalDatasourceImpl(this.broadcastDao);
  @override
  Future<void> addComment({
    required String announcementId,
    required CommentModel comment,
  }) async {
    try {
      await broadcastDao.addComment(Comment.fromJson(comment.toDb()));
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> addReaction({
    required String announcementId,
    required ReactionModel reaction,
  }) async {
    try {
      await broadcastDao.addReaction(Reaction.fromJson(reaction.toDb()));
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> createAnnouncement(AnnouncementModel announcement) async {
    try {
      await broadcastDao
          .createAnnouncement(Announcement.fromJson(announcement.toDb()));
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> deleteAnnouncement({required String announcementId}) async {
    try {
      await broadcastDao.deleteAnnouncement(announcementId);
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> editAnnouncement(AnnouncementModel announcement) async {
    try {
      await broadcastDao
          .editAnnouncement(Announcement.fromJson(announcement.toDb()));
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> sendNotification(NotificationEntity notification) async {
    try {
      // TODO: implement editAnnouncement
      throw UnimplementedError();
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> updateComment({
    required String announcementId,
    required CommentModel comment,
  }) async {
    try {
      await broadcastDao.updateComment(Comment.fromJson(comment.toDb()));
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> updateReaction({
    required String announcementId,
    required ReactionModel reaction,
  }) async {
    try {
      await broadcastDao.updateReaction(Reaction.fromJson(reaction.toDb()));
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<Stream<List<AnnouncementModel>>> watchAnnouncements() async {
    try {
      final announcementsStream = broadcastDao.watchAnnouncements();

      final transformedStream = announcementsStream.map(
        (chatList) => chatList
            .map((chat) => AnnouncementModel.fromDb(chat.toJson()))
            .toList(),
      );
      return transformedStream;
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<Stream<List<CommentModel>>> watchCommentsByAnnouncementId(
      String announcementId) async {
    try {
      final commentsStream =  broadcastDao.watchCommentsForAnnouncement(
        announcementId,
      );
      final transformedStream = commentsStream.map(
        (chatList) => chatList
            .map((chat) => CommentModel.fromDb(chat.toJson()))
            .toList(),
      );
      return transformedStream;
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<List<ReactionModel>> watchReactionsByAnnouncementId(
      String announcementId) async {
    try {
      final reactions = await broadcastDao.watchReactionsForAnnouncement(
        announcementId,
      );
      print('LB $announcementId');
      print(reactions.length);
      return reactions
          .map((chat) => ReactionModel.fromJson(chat.toJson()))
          .toList();
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> insertAnnouncements(
      List<AnnouncementModel> announcements) async {
    try {
      await broadcastDao.batchInsertAnnouncements(announcements
          .map(
            (model) => Announcement.fromJson(model.toDb()),
          )
          .toList());
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> insertComments(List<CommentModel> comments) async {
    try {
      await broadcastDao.batchInsertComments(comments
          .map(
            (model) => Comment.fromJson(model.toDb()),
          )
          .toList());
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> insertReactions(List<ReactionModel> reactions) async {
    try {
      await broadcastDao.batchInsertReactions(reactions
          .map(
            (model) => Reaction.fromJson(model.toDb()),
          )
          .toList());
    } catch (err) {
      throw CacheException(errorMessage: err.toString());
    }
  }
}
