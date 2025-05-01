import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String userId;
    final String announcementId;
  final String userName;
  final String content;
  final DateTime timestamp;

  const Comment({
    required this.id,
    required this.userId,
    required this.announcementId,
    required this.content,
    required this.timestamp,
    required this.userName,
  });

  @override
  List<Object> get props => [id, userId, content, timestamp, userName, announcementId];
}
