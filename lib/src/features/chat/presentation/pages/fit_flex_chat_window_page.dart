// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';

class FitFlexChatWindowPage extends StatelessWidget {
  static const route = 'chat_window';
  final ChatEntity chat;
  const FitFlexChatWindowPage({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
