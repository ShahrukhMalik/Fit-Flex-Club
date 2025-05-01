import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.userId,
    required super.announcementId,
    required super.content,
    required super.timestamp,
    required super.userName,
  });

  factory CommentModel.fromEntity(Comment entity) {
    return CommentModel(
      id: entity.id,
      userId: entity.userId,
      announcementId: entity.announcementId,
      content: entity.content,
      timestamp: entity.timestamp,
      userName: entity.userName,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      userId: json['userId'],
      announcementId: json['announcementId'],
      content: json['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      userName: json['userName'],
    );
  }

  factory CommentModel.fromFirestore(
    Map<String, dynamic> json,
    String docId,
  ) {
    return CommentModel(
      id: docId,
      userId: json['userId'],
      announcementId: json['announcementId'],
      content: json['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      userName: json['userName'],
    );
  }

  factory CommentModel.fromDb(Map<String, dynamic> row) {
    return CommentModel(
      id: row['id'] as String,
      userId: row['userId'] as String,
      announcementId: row['announcementId'] as String,
      content: row['content'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(row['timestamp']),
      userName: row['userName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'announcementId': announcementId,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'userName': userName,
    };
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'userId': userId,
      'announcementId': announcementId,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'userName': userName,
    };
  }

  CommentModel copyWith({
    String? id,
    String? userId,
    String? announcementId,
    String? content,
    DateTime? timestamp,
    String? userName,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      announcementId: announcementId ?? this.announcementId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      userName: userName ?? this.userName,
    );
  }
}
