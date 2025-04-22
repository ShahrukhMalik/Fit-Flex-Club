import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.chatId,
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
      chatId: data['chatId'],
      id: id,
      senderId: data['senderId'] as String,
      messageText: data['messageText'] as String? ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
      type: data['type'] as String? ?? 'text',
      sentTo: List<String>.from((data['sentTo'] as List?)?.map(
            (e) => e['userId'],
          ) ??
          []),
      deliveredTo: List<String>.from((data['deliveredTo'] as List?)?.map(
            (e) => e['userId'],
          ) ??
          []),
      readBy: List<String>.from((data['readBy'] as List?)?.map(
            (e) => e['userId'],
          ) ??
          []),
    );
  }
  factory MessageModel.fromLocal(Map<String, dynamic> data) {
    return MessageModel(
      chatId: data['chatId'],
      id: data['id'],
      senderId: data['senderId'] as String,
      messageText: data['messageText'] as String? ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
      type: data['type'] as String? ?? 'text',
      sentTo: data['sentTo'],
      deliveredTo: data['deliveredTo'],
      readBy: data['readBy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'messageText': messageText,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type,
      'sentTo': sentTo.map(
        (e) =>
            {'userId': e, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      ),
      'deliveredTo': deliveredTo.map(
        (e) =>
            {'userId': e, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      ),
      'readBy': readBy.map(
        (e) =>
            {'userId': e, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      ),
    };
  }

  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? messageText,
    DateTime? timestamp,
    String? type,
    List<String>? sentTo,
    List<String>? deliveredTo,
    List<String>? readBy,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      messageText: messageText ?? this.messageText,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      sentTo: sentTo ?? this.sentTo,
      deliveredTo: deliveredTo ?? this.deliveredTo,
      readBy: readBy ?? this.readBy,
    );
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      chatId: entity.chatId,
      senderId: entity.senderId,
      messageText: entity.messageText,
      timestamp: entity.timestamp,
      type: entity.type,
      sentTo: List<String>.from(entity.sentTo),
      deliveredTo: List<String>.from(entity.deliveredTo),
      readBy: List<String>.from(entity.readBy),
    );
  }
}
