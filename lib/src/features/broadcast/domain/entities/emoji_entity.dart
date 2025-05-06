import 'package:equatable/equatable.dart';

class EmojiEntity extends Equatable {
  final String emojiId;
  final String emojiTitle;
  final String emojiUrl;

  const EmojiEntity({
    required this.emojiId,
    required this.emojiTitle,
    required this.emojiUrl,
  });

  @override
  List<Object?> get props => [
        emojiId,
        emojiTitle,
        emojiUrl,
      ];
}
