// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/notification_model.dart';

import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:injectable/injectable.dart';

abstract class BroadcastRemoteDatasource {
  ///
  Future<void> sendNotification(
    NotificationEntity notification,
  );
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
}
