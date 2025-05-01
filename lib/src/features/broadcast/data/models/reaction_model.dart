import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';

class ReactionModel extends Reaction {
  const ReactionModel({
    required super.id,
    required super.userId,
    required super.announcementId,
    required super.userName,
    required super.emoji,
    required super.timestamp,
  });

  factory ReactionModel.fromEntity(Reaction entity) {
    return ReactionModel(
      id: entity.id,
      userId: entity.userId,
      announcementId: entity.announcementId,
      userName: entity.userName,
      emoji: entity.emoji,
      timestamp: entity.timestamp,
    );
  }

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      id: json['id'],
      userId: json['userId'],
      announcementId: json['announcementId'],
      userName: json['userName'],
      emoji: json['emoji'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
    );
  }

  factory ReactionModel.fromFirestore(
    Map<String, dynamic> json,
    String docId,
  ) {
    return ReactionModel(
      id: docId,
      userId: json['userId'],
      announcementId: json['announcementId'],
      userName: json['userName'],
      emoji: json['emoji'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
    );
  }

  factory ReactionModel.fromDb(Map<String, dynamic> row) {
    return ReactionModel(
      id: row['id'] as String,
      userId: row['userId'] as String,
      announcementId: row['announcementId'] as String,
      userName: row['userName'] as String,
      emoji: row['emoji'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(row['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'announcementId': announcementId,
      'userName': userName,
      'emoji': emoji,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'userId': userId,
      'announcementId': announcementId,
      'userName': userName,
      'emoji': emoji,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  ReactionModel copyWith({
    String? id,
    String? userId,
    String? announcementId,
    String? userName,
    String? emoji,
    DateTime? timestamp,
  }) {
    return ReactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      announcementId: announcementId ?? this.announcementId,
      userName: userName ?? this.userName,
      emoji: emoji ?? this.emoji,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
