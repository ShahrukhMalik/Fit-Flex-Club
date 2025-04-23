import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.id,
    required super.members,
    required super.lastMessage,
    required super.lastSender,
    required super.lastTimestamp,
    required super.unreadCount,
  });

  ChatModel copyWith({
    String? id,
    List<Map<String, dynamic>>? members,
    String? lastMessage,
    String? lastSender,
    DateTime? lastTimestamp,
    Map<String, int>? unreadCount,
  }) {
    return ChatModel(
      id: id ?? this.id,
      members: members ?? List<Map<String, dynamic>>.from(this.members),
      lastMessage: lastMessage ?? this.lastMessage,
      lastSender: lastSender ?? this.lastSender,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      unreadCount: unreadCount ?? Map<String, int>.from(this.unreadCount),
    );
  }

  factory ChatModel.fromEntity(ChatEntity entity) {
    return ChatModel(
      id: entity.id,
      members: List<Map<String, dynamic>>.from(entity.members),
      lastMessage: entity.lastMessage,
      lastSender: entity.lastSender,
      lastTimestamp: entity.lastTimestamp,
      unreadCount: Map<String, int>.from(entity.unreadCount),
    );
  }

  factory ChatModel.fromMap(String id, Map<String, dynamic> data) {
    return ChatModel(
      id: id,
      members: List<Map<String, dynamic>>.from(data['members']),
      lastMessage: data['lastMessage'] ?? '',
      lastSender: data['lastSender'] ?? '',
      lastTimestamp: DateTime.fromMillisecondsSinceEpoch(data['lastTimestamp']),
      unreadCount: Map<String, int>.from(data['unreadCount'] ?? {}),
    );
  }
  factory ChatModel.fromLocal(Map<String, dynamic> data) {
    return ChatModel(
      id: data['id'],
      members: List<Map<String, dynamic>>.from(data['members']),
      lastMessage: data['lastMessage'] ?? '',
      lastSender: data['lastSender'] ?? '',
      lastTimestamp: DateTime.fromMillisecondsSinceEpoch(data['lastTimestamp']),
      unreadCount: Map<String, int>.from(data['unreadCount'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    // final unreadCount = {
    //   for (var member in members) member['userId']: 0,
    // };
    return {
      'members': members,
      'memberIds': members
          .map(
            (member) => member['userId'],
          )
          .toList(),
      'lastMessage': lastMessage,
      'lastSender': lastSender,
      'lastTimestamp': lastTimestamp.millisecondsSinceEpoch,
      'unreadCount': unreadCount
    };
  }
}
