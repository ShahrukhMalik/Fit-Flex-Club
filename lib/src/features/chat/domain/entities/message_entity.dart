import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String senderId;
  final String messageText;
  final DateTime timestamp;
  final String type;
  final List<String> sentTo;
  final List<String> deliveredTo;
  final List<String> readBy;

  const MessageEntity({
    required this.id,
    required this.senderId,
    required this.messageText,
    required this.timestamp,
    required this.type,
    required this.sentTo,
    required this.deliveredTo,
    required this.readBy,
  });

  bool isSentBy(String currentUserId) => senderId == currentUserId;

  bool isDeliveredToAll() => sentTo.every((id) => deliveredTo.contains(id));
  bool isReadByAll() => sentTo.every((id) => readBy.contains(id));

  @override
  List<Object?> get props => [
        id,
        senderId,
        messageText,
        timestamp,
        type,
        sentTo,
        deliveredTo,
        readBy,
      ];
}
