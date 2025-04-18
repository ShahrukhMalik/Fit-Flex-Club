import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final List<Map<String, dynamic>> members;
  final String lastMessage;
  final String lastSender;
  final DateTime lastTimestamp;
  final Map<String, int> unreadCount;

  const ChatEntity({
    required this.id,
    required this.members,
    required this.lastMessage,
    required this.lastSender,
    required this.lastTimestamp,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [
        id,
        members,
        lastMessage,
        lastSender,
        lastTimestamp,
        unreadCount,
      ];

}
