// entities/reaction.dart
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/emoji_entity.dart';

class Reaction extends Equatable {
  final String id;
  final String userId;
  final String announcementId;
  final String userName;
  final EmojiEntity emoji; // e.g., '🔥', '❤️', '💪'
  final DateTime timestamp;

  const Reaction({
    required this.userId,
    required this.id,
    required this.announcementId,
    required this.userName,
    required this.emoji,
    required this.timestamp,
  });

  @override
  List<Object> get props => [
        userId,
        emoji,
        timestamp,
        id,
        announcementId,
        userName,
      ];
}
