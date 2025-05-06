import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/emoji_entity.dart';

class EmojiModel extends EmojiEntity {
  const EmojiModel({
    required super.emojiId,
    required super.emojiTitle,
    required super.emojiUrl,
  });

  factory EmojiModel.fromJson(Map<String, dynamic> json) {
    return EmojiModel(
      emojiId: json['emojiId'],
      emojiTitle: json['emojiTitle'],
      emojiUrl: json['emojiUrl'],
    );
  }

  /// 👇 Used when retrieving data from Firestore
  factory EmojiModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return EmojiModel(
      emojiId: data['emojiId'] ?? doc.id, // fallback to doc.id if missing
      emojiTitle: data['emojiTitle'] ?? '',
      emojiUrl: data['emojiUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emojiId': emojiId,
      'emojiTitle': emojiTitle,
      'emojiUrl': emojiUrl,
    };
  }

  EmojiEntity toEntity() => this;
}
