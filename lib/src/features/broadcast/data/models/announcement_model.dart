import 'dart:typed_data';

import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_post_announcments_page.dart';

class AnnouncementModel extends Announcement {
  const AnnouncementModel({
    required super.id,
    super.trainerId,
    super.gymId,
    super.trainerName,
    super.gymName,
    super.content,
    super.mediaUrl,
    super.mediaBytes,
    required super.postType,
    required super.postedFor,
    required super.createdAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      postedFor:
          PostedFor.values.firstWhere((e) => e.name == json['postedFor']),
      gymName: json['gymName'],
      gymId: json['gymId'],
      id: json['id'],
      trainerId: json['trainerId'],
      trainerName: json['trainerName'],
      content: json['content'],
      mediaUrl: json['mediaUrl'],
      mediaBytes: json['mediaBytes'],
      postType: PostType.values.firstWhere((e) => e.name == json['postType']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  factory AnnouncementModel.fromEntity(Announcement entity) {
    return AnnouncementModel(
      postedFor: entity.postedFor,
      gymId: entity.gymId,
      id: entity.id,
      trainerId: entity.trainerId,
      trainerName: entity.trainerName,
      gymName: entity.gymName,
      content: entity.content,
      mediaUrl: entity.mediaUrl,
      mediaBytes: entity.mediaBytes,
      postType: entity.postType,
      createdAt: entity.createdAt,
    );
  }

  factory AnnouncementModel.fromFirestore(
    Map<String, dynamic> json,
    String docId,
  ) {
    return AnnouncementModel(
      postedFor:
          PostedFor.values.firstWhere((e) => e.name == json['postedFor']),
      gymName: json['gymName'],
      gymId: json['gymId'],
      id: docId,
      trainerId: json['trainerId'],
      trainerName: json['trainerName'],
      content: json['content'],
      mediaUrl: json['mediaUrl'],
      mediaBytes: json['mediaBytes'],
      postType: PostType.values.firstWhere((e) => e.name == json['postType']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson([String? mediaUrl]) {
    return {
      'id': id,
      'trainerId': trainerId,
      'gymId': gymId,
      'trainerName': trainerName,
      'gymName': gymName,
      'content': content,
      'mediaUrl': mediaUrl ?? this.mediaUrl,
      'postType': postType.name,
      'postedFor': postedFor.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory AnnouncementModel.fromDb(Map<String, dynamic> row) {
    return AnnouncementModel(
      postedFor: PostedFor.values.firstWhere((e) => e.name == row['postedFor']),
      gymName: row['gymName'],
      gymId: row['gymId'],
      id: row['id'],
      trainerId: row['trainerId'],
      trainerName: row['trainerName'],
      content: row['content'],
      mediaUrl: row['mediaUrl'],
      mediaBytes: row['mediaBytes'],
      postType: PostType.values.firstWhere((e) => e.name == row['postType']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['createdAt']),
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'trainerId': trainerId,
      'gymId': gymId,
      'trainerName': trainerName,
      'gymName': gymName,
      'content': content,
      'mediaUrl': mediaUrl,
      'mediaBytes': mediaBytes,
      'postType': postType.name,
      'postedFor': postedFor.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  AnnouncementModel copyWithModel({
    String? id,
    String? trainerId,
    String? gymId,
    String? trainerName,
    String? gymName,
    String? content,
    String? mediaUrl,
    PostType? postType,
    PostedFor? postedFor,
    DateTime? createdAt,
    Uint8List? mediaBytes,
  }) {
    return AnnouncementModel(
      postedFor: postedFor ?? this.postedFor,
      gymName: gymName ?? this.gymName,
      gymId: gymId ?? this.gymId,
      id: id ?? this.id,
      trainerId: trainerId ?? this.trainerId,
      trainerName: trainerName ?? this.trainerName,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      postType: postType ?? this.postType,
      createdAt: createdAt ?? this.createdAt,
      mediaBytes: mediaBytes ?? this.mediaBytes,
    );
  }
}
