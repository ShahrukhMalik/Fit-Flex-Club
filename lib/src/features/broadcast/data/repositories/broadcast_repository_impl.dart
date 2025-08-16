// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid_v4/uuid_v4.dart';

import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/core/util/sharedpref/shared_prefs_util.dart';
import 'package:fit_flex_club/src/features/broadcast/data/datasources/broadcast_remote_datasource.dart';
import 'package:fit_flex_club/src/features/broadcast/data/datasources/local/broadcast_local_datasource.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/announcement_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/comment_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/reaction_model.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/emoji_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_post_announcments_page.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/daos/sync_queue_dao.dart';

enum AnnouncementsEvents {
  createEvent,
  editEvent,
  deleteEvent,
  addComment,
  editComment,
  addReaction,
  editReaction
}

@Singleton(as: BroadcastRepository)
class BroadcastRepositoryImpl extends BroadcastRepository {
  final NetworkInfo networkInfo;
  final BroadcastRemoteDatasource broadcastRemoteDatasource;
  final BroadcastLocalDatasource broadcastLocalDatasource;
  final SyncQueueDao syncQueue;
  final SharedPrefsUtil prefs;
  BroadcastRepositoryImpl({
    required this.networkInfo,
    required this.broadcastRemoteDatasource,
    required this.broadcastLocalDatasource,
    required this.syncQueue,
    required this.prefs,
  });
  @override
  Future<Either<Failures, void>> sendNotification(
    NotificationEntity notification,
  ) async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected ?? false) {
      try {
        return Right(
          await broadcastRemoteDatasource.sendNotification(notification),
        );
      } on ServerException catch (error) {
        return Left(
          ServerFailure(
            message: error.errorMessage,
            code: error.errorCode,
          ),
        );
      }
    } else {
      return const Left(
        NetworkFailure(
          message: 'No Internet Connection',
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> addComment({
    required String announcementId,
    required Comment comment,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(
          ServerFailure(
            code: '07',
            message: 'Auth ID not found',
          ),
        );
      }

      final model = CommentModel.fromEntity(
        comment,
      ).copyWith(
        id: UUIDv4().toString(),
        userId: authId,
        userName: prefs.getUserName(),
      );

      await broadcastLocalDatasource.addComment(
        announcementId: announcementId,
        comment: model,
      );

      if (isConnected) {
        await broadcastRemoteDatasource.addComment(
          announcementId: announcementId,
          comment: model,
        );
        return Right(null);
      } else {
        return Right(
          await syncQueue.logSyncAction(
            AnnouncementsEvents.addComment.name,
            "Add Comment",
            CommentModel.fromEntity(comment).toJson(),
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> createAnnouncement(
    Announcement announcement,
  ) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(
          ServerFailure(
            code: '07',
            message: 'Auth ID not found',
          ),
        );
      }

      final gymId = getIt<SharedPrefsUtil>().getGymId();

      final announcementId =
          'announcement_${gymId ?? authId}_${UUIDv4().toString()}';
      final model = AnnouncementModel.fromEntity(announcement).copyWithModel(
          id: announcementId,
          gymId: announcement.postedFor == PostedFor.Gym ? gymId : null,
          trainerId:
              announcement.postedFor == PostedFor.Trainer ? authId : null,
          trainerName: prefs.getUserName(),
          gymName: prefs.getGymName());

      await broadcastLocalDatasource.createAnnouncement(
        model,
      );

      if (isConnected) {
        await broadcastRemoteDatasource.createAnnouncement(
          model,
        );
        return Right(null);
      } else {
        return Right(
          await syncQueue.logSyncAction(
            AnnouncementsEvents.createEvent.name,
            "Create Announcement",
            model.toJson(),
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, Stream<List<Announcement>>>>
      watchAnnouncements() async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;

      if (isConnected) {
        final remoteAnnouncementStream =
            await broadcastRemoteDatasource.watchAnnouncements();

        // Listen without awaiting the full stream
        remoteAnnouncementStream.listen(
          (remoteAnnouncements) async {
            await broadcastLocalDatasource
                .insertAnnouncements(remoteAnnouncements); // ✅ update local
          },
          onError: (e) {
            // optional: handle remote stream errors
          },
          cancelOnError: false, // keep syncing even after recoverable errors
        );
      }
      return Right(broadcastLocalDatasource.watchAnnouncements());
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> addReaction({
    required String announcementId,
    required Reaction reaction,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(
          ServerFailure(
            code: '07',
            message: 'Auth ID not found',
          ),
        );
      }

      final model = ReactionModel.fromEntity(
        reaction,
      ).copyWith(
        id: authId,
        userId: authId,
        userName: prefs.getUserName(),
      );

      await broadcastLocalDatasource.addReaction(
        announcementId: announcementId,
        reaction: model,
      );

      if (isConnected) {
        await broadcastRemoteDatasource.addReaction(
          announcementId: announcementId,
          reaction: model,
        );
        return Right(null);
      } else {
        return Right(
          await syncQueue.logSyncAction(
            AnnouncementsEvents.addReaction.name,
            "Add Reaction",
            model.toJson(),
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> updateComment({
    required String announcementId,
    required Comment comment,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(
          ServerFailure(
            code: '07',
            message: 'Auth ID not found',
          ),
        );
      }

      await broadcastLocalDatasource.updateComment(
        announcementId: announcementId,
        comment: CommentModel.fromEntity(
          comment,
        ),
      );

      if (isConnected) {
        await broadcastRemoteDatasource.updateComment(
          announcementId: announcementId,
          comment: CommentModel.fromEntity(
            comment,
          ),
        );
        return Right(null);
      } else {
        return Right(
          await syncQueue.logSyncAction(
            AnnouncementsEvents.editComment.name,
            "Edit Comment",
            CommentModel.fromEntity(comment).toJson(),
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> updateReaction({
    required String announcementId,
    required Reaction reaction,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(
          ServerFailure(
            code: '07',
            message: 'Auth ID not found',
          ),
        );
      }

      final model = ReactionModel.fromEntity(
        reaction,
      );

      await broadcastLocalDatasource.updateReaction(
        announcementId: announcementId,
        reaction: model,
      );

      if (isConnected) {
        await broadcastRemoteDatasource.updateReaction(
          announcementId: announcementId,
          reaction: model,
        );
        return Right(null);
      } else {
        return Right(
          await syncQueue.logSyncAction(
            AnnouncementsEvents.editReaction.name,
            "Edit Reaction",
            model.toJson(),
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> deleteAnnouncement({
    required String announcementId,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(
          ServerFailure(
            code: '07',
            message: 'Auth ID not found',
          ),
        );
      }

      await broadcastLocalDatasource.deleteAnnouncement(
        announcementId: announcementId,
      );

      if (isConnected) {
        await broadcastRemoteDatasource.deleteAnnouncement(
            announcementId: announcementId);
        return Right(null);
      } else {
        return Right(
          await syncQueue.logSyncAction(
            AnnouncementsEvents.deleteEvent.name,
            "Delete Announcement",
            {'announcementId': announcementId},
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>> editAnnouncement(
    Announcement announcement,
  ) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final authId = getIt<FirebaseAuth>().currentUser?.uid;
      if (authId == null) {
        return Left(
          ServerFailure(
            code: '07',
            message: 'Auth ID not found',
          ),
        );
      }

      final model = AnnouncementModel.fromEntity(announcement);

      await broadcastLocalDatasource.editAnnouncement(
        model,
      );

      if (isConnected) {
        await broadcastRemoteDatasource.editAnnouncement(
          model,
        );
        return Right(null);
      } else {
        return Right(
          await syncQueue.logSyncAction(
            AnnouncementsEvents.createEvent.name,
            "Edit Announcement",
            model.toJson(),
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, Stream<List<Comment>>>> watchCommentsByAnnouncementId(
    String announcementId,
  ) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final localCommentsStream = await broadcastLocalDatasource
          .watchCommentsByAnnouncementId(announcementId);
      if (isConnected) {
        final remoteCommentsStream = await broadcastRemoteDatasource
            .watchCommentsByAnnouncementId(announcementId);
        // await broadcastLocalDatasource.insertComments(remoteComments);
        // return Right(remoteComments);

        remoteCommentsStream.listen(
          (remoteComments) async {
            await broadcastLocalDatasource
                .insertComments(remoteComments); // ✅ update local
          },
          onError: (e) {
            // optional: handle remote stream errors
          },
          cancelOnError: false, // keep syncing even after recoverable errors
        );
      }
      return Right(localCommentsStream);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<Reaction>>> watchReactionsByAnnouncementId(
    String announcementId,
  ) async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      final localReactionsStream = await broadcastLocalDatasource
          .watchReactionsByAnnouncementId(announcementId);
      if (isConnected) {
        final remoteReactionsStream = await broadcastRemoteDatasource
            .watchReactionsByAnnouncementId(announcementId);
        await broadcastLocalDatasource.insertReactions(remoteReactionsStream);
        return Right(remoteReactionsStream);
        // Listen without awaiting the full stream
        // remoteReactionsStream.listen(
        //   (remoteReactions) async {
        //     await broadcastLocalDatasource
        //         .insertReactions(remoteReactions); // ✅ update local
        //   },
        //   onError: (e) {
        //     // optional: handle remote stream errors
        //   },
        //   cancelOnError: false, // keep syncing even after recoverable errors
        // );
      }
      return Right(localReactionsStream);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<EmojiEntity>>> getEmojis() async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      if (isConnected) {
        return Right(await broadcastRemoteDatasource.getEmojis());
      } else {
        return Left(
          ServerFailure(
            message: "Internet is not available",
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }
}
