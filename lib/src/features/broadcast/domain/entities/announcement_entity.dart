import 'package:equatable/equatable.dart';


enum PostType { text, image, video }

class Announcement extends Equatable {
  final String id;
  final String trainerId;
  final String trainerName;
  final String content;
  final String? mediaUrl;
  final PostType postType;
  final DateTime createdAt;


  const Announcement( {
    required this.id,
    required this.trainerName,
    required this.trainerId,
    required this.content,
    this.mediaUrl,
    required this.postType,
    required this.createdAt,
  });


  @override
  List<Object?> get props => [
        id,
        trainerId,
        content,
        mediaUrl,
        postType,
        createdAt,
        trainerName
      ];
}
