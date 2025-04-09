import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.notificationTitle,
    required super.notificationBody,
    required super.selectedClients,
  });

  Map<String, dynamic> toJson({required String trainerId}) {
    return {
      'trainer_id': trainerId,
      'notificationTitle': notificationTitle,
      'notificationBody': notificationBody,
      'selectedClients': selectedClients.map(
        (selectedClient) {
          return {
            'created_at': DateTime.now().millisecondsSinceEpoch,
            'fcmToken': selectedClient?.fcmToken,
            'remark': null,
            'notification_sent_at': null,
            'client_id': selectedClient?.id,
          };
        },
      ),
    };
  }

  @override
  String toString() {
    return 'NotificationModel(title: $notificationTitle, body: $notificationBody, selectedClients: $selectedClients)';
  }
}
