import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.messageText,
    required super.timestamp,
    required super.type,
    required super.sentTo,
    required super.deliveredTo,
    required super.readBy,
  });

  factory MessageModel.fromMap(String id, Map<String, dynamic> data) {
    return MessageModel(
      id: id,
      senderId: data['senderId'] as String,
      messageText: data['messageText'] as String? ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
      type: data['type'] as String? ?? 'text',
      sentTo: List<String>.from(data['sentTo'] ?? []),
      deliveredTo: List<String>.from(data['deliveredTo'] ?? []),
      readBy: List<String>.from(data['readBy'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': messageText,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type,
      'sentTo': sentTo,
      'deliveredTo': deliveredTo,
      'readBy': readBy,
    };
  }
}
