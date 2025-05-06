import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/emoji_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/getemojis/getemojis_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReactionBar extends StatefulWidget {
  final Function(EmojiEntity emoji) onReact;
  final List<EmojiEntity> emojis;

  const ReactionBar({required this.onReact, super.key, required this.emojis});

  @override
  State<ReactionBar> createState() => _ReactionBarState();
}

class _ReactionBarState extends State<ReactionBar> {
  final ValueNotifier<List<EmojiEntity>> emojisNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        emojisNotifier.value = widget.emojis;
      },
    );
  }

  final List<String> emojiAssets = [
    'assets/emojis/like_emoji.png',
    'assets/emojis/celebrate_emoji.png',
    'assets/emojis/hand_heart_emoji.png',
    'assets/emojis/love_emoji.png',
    'assets/emojis/insightful_emoji.png',
    'assets/emojis/smile_emoji.png',
  ];

  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ValueListenableBuilder(
            valueListenable: emojisNotifier,
            builder: (context, emojis, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(emojis.length, (index) {
                  final emoji = emojis[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onReact(emoji);
                      context.pop();
                    },
                    // onPanUpdate: (details) {
                    //   setState(() {
                    //     hoveredIndex = index;
                    //   });
                    // },
                    // onPanEnd: (_) {
                    //   if (hoveredIndex != null) {
                    //     widget.onReact(emoji);
                    //   }
                    // },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        emoji.emojiUrl,
                        height: 40,
                      ),
                    ),
                  );
                }),
              );
            }),
      ),
    );
  }
}

class EmojiReactionBar extends StatefulWidget {
  final void Function(String emoji) onEmojiSelected;

  const EmojiReactionBar({required this.onEmojiSelected});

  @override
  State<EmojiReactionBar> createState() => _EmojiReactionBarState();
}

class _EmojiReactionBarState extends State<EmojiReactionBar> {
  final List<String> emojis = ['👍', '❤️', '😂', '😮', '😢', '😡'];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onPanUpdate: (details) {
          RenderBox box = context.findRenderObject() as RenderBox;
          final localPosition = box.globalToLocal(details.globalPosition);
          final itemWidth = box.size.width / emojis.length;
          final index = (localPosition.dx / itemWidth)
              .floor()
              .clamp(0, emojis.length - 1);
          setState(() {
            selectedIndex = index;
          });
        },
        onPanEnd: (_) {
          if (selectedIndex != null) {
            widget.onEmojiSelected(emojis[selectedIndex!]);
          }
          setState(() {
            selectedIndex = null;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(emojis.length, (index) {
              final isSelected = selectedIndex == index;
              return AnimatedScale(
                scale: isSelected ? 1.8 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    emojis[index],
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
