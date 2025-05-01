import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';

class AnnouncementModel extends Announcement {
  const AnnouncementModel({
    required super.id,
    required super.trainerId,
    required super.trainerName,
    required super.content,
    super.mediaUrl,
    required super.postType,
    required super.createdAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'],
      trainerId: json['trainerId'],
      trainerName: json['trainerName'],
      content: json['content'],
      mediaUrl: json['mediaUrl'],
      postType: PostType.values.firstWhere((e) => e.name == json['postType']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  factory AnnouncementModel.fromEntity(Announcement entity) {
    return AnnouncementModel(
      id: entity.id,
      trainerId: entity.trainerId,
      trainerName: entity.trainerName,
      content: entity.content,
      mediaUrl: entity.mediaUrl,
      postType: entity.postType,
      createdAt: entity.createdAt,
    );
  }

  factory AnnouncementModel.fromFirestore(
    Map<String, dynamic> json,
    String docId,
  ) {
    return AnnouncementModel(
      id: docId,
      trainerId: json['trainerId'],
      trainerName: json['trainerName'],
      content: json['content'],
      mediaUrl: json['mediaUrl'],
      postType: PostType.values.firstWhere((e) => e.name == json['postType']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trainerId': trainerId,
      'trainerName': trainerName,
      'content': content,
      'mediaUrl': mediaUrl,
      'postType': postType.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory AnnouncementModel.fromDb(Map<String, dynamic> row) {
    return AnnouncementModel(
      id: row['id'] as String,
      trainerId: row['trainerId'] as String,
      trainerName: row['trainerName'] as String,
      content: row['content'] as String,
      mediaUrl: row['mediaUrl'] as String?,
      postType: PostType.values.firstWhere((e) => e.name == row['postType']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['createdAt']),
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'trainerId': trainerId,
      'trainerName': trainerName,
      'content': content,
      'mediaUrl': mediaUrl,
      'postType': postType.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  AnnouncementModel copyWith({
    String? id,
    String? trainerId,
    String? trainerName,
    String? content,
    String? mediaUrl,
    PostType? postType,
    DateTime? createdAt,
  }) {
    return AnnouncementModel(
      id: id ?? this.id,
      trainerId: trainerId ?? this.trainerId,
      trainerName: trainerName ?? this.trainerName,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      postType: postType ?? this.postType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
