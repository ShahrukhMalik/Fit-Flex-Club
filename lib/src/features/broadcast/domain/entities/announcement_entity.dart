import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_post_announcments_page.dart';

enum PostType { text, image, video }

class Announcement extends Equatable {
  final String id;
  final String? trainerId;
  final String? gymId;
  final String? gymName;
  final String? trainerName;
  final PostedFor postedFor;
  final String? content;
  final String? mediaUrl;
  final Uint8List? mediaBytes;
  final PostType postType;
  final DateTime createdAt;

  const Announcement({
    required this.id,
    this.trainerName,
    this.gymName,
    this.trainerId,
    this.gymId,
    this.content,
    this.mediaUrl,
    this.mediaBytes,
    required this.postType,
    required this.postedFor,
    required this.createdAt,
  });

  Announcement copyWith({
    String? id,
    String? trainerId,
    String? gymId,
    String? gymName,
    String? trainerName,
    PostedFor? postedFor,
    String? content,
    String? mediaUrl,
    Uint8List? mediaBytes,
    PostType? postType,
    DateTime? createdAt,
  }) {
    return Announcement(
      id: id ?? this.id,
      trainerId: trainerId ?? this.trainerId,
      gymId: gymId ?? this.gymId,
      gymName: gymName ?? this.gymName,
      trainerName: trainerName ?? this.trainerName,
      postedFor: postedFor ?? this.postedFor,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaBytes: mediaBytes ?? this.mediaBytes,
      postType: postType ?? this.postType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        trainerId,
        gymId,
        content,
        mediaUrl,
        mediaBytes,
        postType,
        createdAt,
        trainerName,
        postedFor,
        postType
      ];
}
