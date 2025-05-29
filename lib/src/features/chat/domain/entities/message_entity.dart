// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

enum MessageType { text, image, audio }

class MessageEntity extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String messageText;
  final Uint8List? mediaBytes;
  final String? mediaUrl;
  final DateTime timestamp;
  final MessageType type;
  final List<String> sentTo;
  final List<String> deliveredTo;
  final List<String> readBy;

  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.messageText,
    this.mediaBytes,
    this.mediaUrl,
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
        chatId,
        senderId,
        messageText,
        timestamp,
        type,
        sentTo,
        deliveredTo,
        readBy,
        mediaBytes,
        mediaUrl
      ];
}
