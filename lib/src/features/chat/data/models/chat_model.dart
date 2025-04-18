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

  factory ChatModel.fromMap(String id, Map<String, dynamic> data) {
    return ChatModel(
      id: id,
      members: List<Map<String, dynamic>>.from(data['members']),
      lastMessage: data['lastMessage'] ?? '',
      lastSender: data['lastSender'] ?? '',
      lastTimestamp: (data['lastTimestamp'] as Timestamp).toDate(),
      unreadCount: Map<String, int>.from(data['unreadCount'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'members': members,
      'memberIds': members
          .map(
            (member) => member['userId'],
          )
          .toList(),
      'lastMessage': lastMessage,
      'lastSender': lastSender,
      'lastTimestamp': lastTimestamp,
      'unreadCount': unreadCount,
    };
  }
}
