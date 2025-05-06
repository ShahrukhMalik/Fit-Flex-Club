// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/sharedpref/shared_prefs_util.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/emoji_model.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/emoji_entity.dart';
import 'package:mime/mime.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/announcement_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/comment_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/notification_model.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/reaction_model.dart';

import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/announcement_entity.dart';

abstract class BroadcastRemoteDatasource {
  ///
  Future<List<EmojiEntity>> getEmojis();

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
      await announcementsRef
          .doc(announcementId)
          .collection('reactions')
          .doc(reaction.id)
          .set(
            reaction.toJson(),
            SetOptions(
              merge: true
            )
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
      final authId = auth.currentUser?.uid;

      if (authId == null) {
        throw ServerException(errorMessage: "No Auth ID found");
      }
      final CollectionReference announcementsRef =
          remoteDb.collection('announcements');

      String? mediaUrl;

      if (announcement.mediaBytes != null) {
        // Determine owner ID (gym or trainer)
        final ownerId = announcement.gymId ?? authId;

        // Determine file extension (e.g. jpg, mp4)
        // final mimeType = lookupMimeType(
        //   '',
        //   headerBytes: announcement.mediaBytes,
        // );
        final fileExtension =
            announcement.postType == PostType.image ? 'jpg' : 'mp4';

        // Construct path in Firebase Storage
        final filePath =
            'announcements/$ownerId/${announcement.id}_$ownerId.$fileExtension';

        // Upload to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child(filePath);
        final uploadTask = await storageRef.putData(announcement.mediaBytes!);
        mediaUrl = await uploadTask.ref.getDownloadURL();

        // // Attach generated fields to announcement model
        // announcement = announcement.copyWithModel(
        //   mediaUrl: mediaUrl,
        // );
      }

      // Save to Firestore
      await announcementsRef
          .doc(announcement.id)
          .set(announcement.toJson(mediaUrl));
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
      final gymId = getIt<SharedPrefsUtil>().getGymId();

      if (authId == null) {
        throw ServerException(errorMessage: "No Auth ID found");
      }

      final trainerQuery =
          announcementsRef.where('trainerId', isEqualTo: authId).snapshots();

      final gymQuery =
          announcementsRef.where('gymId', isEqualTo: gymId).snapshots();

      final combinedStream = Rx.combineLatest2<QuerySnapshot, QuerySnapshot,
          List<DocumentReference>>(
        trainerQuery,
        gymQuery,
        (trainerSnap, gymSnap) {
          final trainerRefs = trainerSnap.docs.map((doc) => doc.reference);
          final gymRefs = gymSnap.docs.map((doc) => doc.reference);

          final allRefs = [...trainerRefs, ...gymRefs];

          final uniqueRefs = {
            for (var ref in allRefs) ref.id: ref,
          }.values.toList();

          return uniqueRefs;
        },
      );

      return combinedStream.asyncMap((docRefs) async {
        final enrichedList = await Future.wait(docRefs.map(
          (docRef) async {
            final docSnap = await docRef.get();
            final data = docSnap.data() as Map<String, dynamic>;

            final announcement = AnnouncementModel.fromFirestore(
              json: data,
              docId: docRef.id,
            );

            // // Fetch comment count
            // final commentSnap = await docRef.collection('comments').get();
            // final commentCount = commentSnap.size;

            // // Fetch reaction count
            // final reactionSnap = await docRef.collection('reactions').get();
            // final reactionCount = reactionSnap.size;

            // Fetch my comment
            final myCommentSnap = await docRef
                .collection('comments')
                .where('userId', isEqualTo: authId)
                .limit(1)
                .get();

            final myComment = myCommentSnap.docs.isNotEmpty
                ? CommentModel.fromFirestore(
                    myCommentSnap.docs.first.data(),
                    myCommentSnap.docs.first.id,
                  )
                : null;

            // Fetch my reaction
            final myReactionSnap =
                await docRef.collection('reactions').doc(authId).get();

            final myReaction = myReactionSnap.exists
                ? ReactionModel.fromFirestore(
                    myReactionSnap.data()!,
                    myReactionSnap.id,
                  )
                : null;

            return announcement.copyWithModel(
              myComment: myComment,
              myReaction: myReaction,
            );
          },
        ));

        return enrichedList;
      });
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

  @override
  Future<List<EmojiEntity>> getEmojis() async {
    try {
      final emojiDoc = await remoteDb
          .collection('emojis')
          .orderBy('emojiSeq', descending: false)
          .get();
      return emojiDoc.docs
          .map(
            (obj) => EmojiModel.fromFirestore(obj),
          )
          .toList();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}

/// Utility function to extract extension from MIME type
String? extensionFromMime(String? mimeType) {
  if (mimeType == null) return null;
  final typeMap = {
    'image/jpeg': 'jpg',
    'image/png': 'png',
    'video/mp4': 'mp4',
    'image/gif': 'gif',
  };
  return typeMap[mimeType];
}
