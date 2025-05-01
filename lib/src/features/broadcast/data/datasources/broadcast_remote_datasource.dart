// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/announcement_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/comment_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/notification_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/reaction_model.dart';

import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/announcement_entity.dart';

abstract class BroadcastRemoteDatasource {
  ///
  Future<void> sendNotification(
    NotificationEntity notification,
  );

  ///
  Future<void> createAnnouncement(
    AnnouncementModel announcement,
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
      String announcementId);

  ///
  Future<Stream<List<ReactionModel>>> watchReactionsByAnnouncementId(
      String announcementId);
}

@Singleton(as: BroadcastRemoteDatasource)
class BroadcastRemoteDatasourceImpl extends BroadcastRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore remoteDb;
  BroadcastRemoteDatasourceImpl({
    required this.auth,
    required this.remoteDb,
  });
  @override
  Future<void> sendNotification(NotificationEntity notification) async {
    try {
      print(
          "Request reached remote db: ${DateTime.now().millisecondsSinceEpoch}");
      final CollectionReference ref = remoteDb.collection('Notifications');
      final authId = auth.currentUser?.uid;

      if (authId == null) {
        throw ServerException(errorMessage: "No Auth ID found");
      }
      await ref.add(
        NotificationModel(
          notificationTitle: notification.notificationTitle,
          notificationBody: notification.notificationBody,
          selectedClients: notification.selectedClients,
        ).toJson(
          trainerId: authId,
        ),
      );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> addComment({
    required String announcementId,
    required CommentModel comment,
  }) async {
    try {
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');
      await announcementsRef.doc(announcementId).collection('comments').add(
            comment.toJson(),
          );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> addReaction({
    required String announcementId,
    required ReactionModel reaction,
  }) async {
    try {
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');
      await announcementsRef.doc(announcementId).collection('reactions').add(
            reaction.toJson(),
          );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> createAnnouncement(AnnouncementModel announcement) async {
    try {
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');
      await announcementsRef.add(
        announcement.toJson(),
      );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> deleteAnnouncement({required String announcementId}) async {
    try {
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');
      await announcementsRef.doc(announcementId).delete();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> editAnnouncement(AnnouncementModel announcement) async {
    try {
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');
      await announcementsRef.doc(announcement.id).update(
            announcement.toJson(),
          );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> updateComment({
    required String announcementId,
    required CommentModel comment,
  }) async {
    try {
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');
      await announcementsRef
          .doc(announcementId)
          .collection('comments')
          .doc(
            comment.id,
          )
          .update(comment.toJson());
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> updateReaction({
    required String announcementId,
    required ReactionModel reaction,
  }) async {
    try {
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');
      await announcementsRef
          .doc(announcementId)
          .collection('reactions')
          .doc(
            reaction.id,
          )
          .update(reaction.toJson());
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<Stream<List<AnnouncementModel>>> watchAnnouncements() async {
    try {
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');
      final authId = auth.currentUser?.uid;

      if (authId == null) {
        throw ServerException(errorMessage: "No Auth ID found");
      }

      return announcementsRef
          .where('trainerId', isEqualTo: authId)
          .snapshots()
          .map(
        (snapshot) {
          final docs = snapshot.docs;

          return docs
              .map(
                (doc) => AnnouncementModel.fromFirestore(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList();
        },
      );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<Stream<List<CommentModel>>> watchCommentsByAnnouncementId(
    String announcementId,
  ) async {
    try {
      final CollectionReference commentsRef = remoteDb
          .collection('announcements')
          .doc(announcementId)
          .collection('comments');

      return commentsRef.snapshots().map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              final data = doc.data() as Map<String, dynamic>;
              return CommentModel.fromFirestore(data, doc.id);
            },
          ).toList();
        },
      );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<Stream<List<ReactionModel>>> watchReactionsByAnnouncementId(
      String announcementId) async {
    try {
      final CollectionReference commentsRef = remoteDb
          .collection('announcements')
          .doc(announcementId)
          .collection('reactions');

      return commentsRef.snapshots().map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ReactionModel.fromFirestore(data, doc.id);
            },
          ).toList();
        },
      );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
