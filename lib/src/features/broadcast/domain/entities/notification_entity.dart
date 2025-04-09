import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';

class NotificationEntity extends Equatable {
  final String notificationTitle;
  final String notificationBody;
  final List<ClientEntity?> selectedClients;

  const NotificationEntity({
    required this.notificationTitle,
    required this.notificationBody,
    required this.selectedClients,
  });

  @override
  List<Object?> get props => [
        notificationTitle,
        notificationBody,
        selectedClients,
      ];
}
