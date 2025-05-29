import 'dart:typed_data';

import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.chatId,
    required super.senderId,
    required super.messageText,
    super.mediaBytes,
    super.mediaUrl,
    required super.timestamp,
    required super.type,
    required super.sentTo,
    required super.deliveredTo,
    required super.readBy,
  });

  factory MessageModel.fromMap(String id, Map<String, dynamic> data) {
    return MessageModel(
      mediaBytes: data['mediaBytes'],
      mediaUrl: data['mediaUrl'],
      chatId: data['chatId'],
      id: id,
      senderId: data['senderId'] as String,
      messageText: data['messageText'] as String? ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
      // type: data['type'] as String? ?? 'text',
      type: MessageType.values.firstWhere((e) => e.name == data['type']),
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
      mediaBytes: data['mediaBytes'],
      mediaUrl: data['mediaUrl'],
      chatId: data['chatId'],
      id: data['id'],
      senderId: data['senderId'] as String,
      messageText: data['messageText'] as String? ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
      type: MessageType.values.firstWhere((e) => e.name == data['type']),
      sentTo: data['sentTo'],
      deliveredTo: data['deliveredTo'],
      readBy: data['readBy'],
    );
  }

  Map<String, dynamic> toMap([bool toLocalDb = false]) {
    return {
      'mediaUrl': mediaUrl,
      'chatId': chatId,
      if (toLocalDb) 'mediaBytes': mediaBytes,
      'senderId': senderId,
      'messageText': messageText,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.name,
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
    MessageType? type,
    Uint8List? mediaBytes,
    String? mediaUrl,
    List<String>? sentTo,
    List<String>? deliveredTo,
    List<String>? readBy,
  }) {
    return MessageModel(
      mediaBytes: mediaBytes ?? this.mediaBytes,
      mediaUrl: mediaUrl ?? this.mediaUrl,
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
      mediaBytes: entity.mediaBytes,
      mediaUrl: entity.mediaUrl,
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
