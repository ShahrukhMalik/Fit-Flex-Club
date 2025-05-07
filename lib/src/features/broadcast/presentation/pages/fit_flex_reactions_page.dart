import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/features/broadcast/data/models/emoji_model.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/watchreactionsbyannouncmentid/watchreactionsbyannouncmentid_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class FitFlexReactionsPage extends StatefulWidget {
//   final String announcementId;
//   const FitFlexReactionsPage({
//     super.key,
//     required this.announcementId,
//   });
//   static const route = 'reactions_page';

//   @override
//   State<FitFlexReactionsPage> createState() => _FitFlexReactionsPageState();
// }

// class _FitFlexReactionsPageState extends State<FitFlexReactionsPage> {
//   final ValueNotifier<List<Reaction>> originalReactionsNotifier =
//       ValueNotifier([]);

//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<WatchReactionsbyAnnouncmentIdCubit>()
//         .getReactionsByAnnouncementId(widget.announcementId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PlatformAppbar.basicAppBar(
//         title: "Announcements",
//         foregroundColor: globalColorScheme.primary,
//         context: context,
//         backgroundColor: globalColorScheme.onPrimaryContainer,
//       ),
//       body: BlocListener<WatchReactionsbyAnnouncmentIdCubit,
//           WatchReactionsbyAnnouncmentIdState>(
//         listener: (context, state) {
//           if (state is WatchReactionsbyAnnouncmentIdComplete) {
//             originalReactionsNotifier.value = state.reactions;
//           }
//         },
//         child: Column(),
//       ),
//     );
//   }
// }

// class FitFlexReactionsPage extends StatefulWidget {
//   final String announcementId;
//   const FitFlexReactionsPage({
//     super.key,
//     required this.announcementId,
//   });
//   static const route = 'reactions_page';

//   @override
//   State<FitFlexReactionsPage> createState() => _FitFlexReactionsPageState();
// }

// class _FitFlexReactionsPageState extends State<FitFlexReactionsPage>
//     with TickerProviderStateMixin {
//   final ValueNotifier<List<Reaction>> originalReactionsNotifier =
//       ValueNotifier([]);
//   final ValueNotifier<List<String>> emojiTabs = ValueNotifier([]);
//   TabController? _tabController;

//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<WatchReactionsbyAnnouncmentIdCubit>()
//         .getReactionsByAnnouncementId(widget.announcementId);
//   }

//   void _updateEmojiTabs(List<Reaction> reactions) {
//     final uniqueEmojis = reactions.map((r) => r.emoji.emojiUrl).toSet().toList()
//       ..sort();

//     // Update emoji tab values
//     emojiTabs.value = uniqueEmojis;

//     // Dispose previous controller safely
//     _tabController?.dispose();

//     if (uniqueEmojis.isNotEmpty) {
//       _tabController = TabController(length: uniqueEmojis.length, vsync: this);
//     }
//   }

//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PlatformAppbar.basicAppBar(
//         title: "Reactions",
//         foregroundColor: globalColorScheme.primary,
//         context: context,
//         backgroundColor: globalColorScheme.onPrimaryContainer,
//       ),
//       body: BlocListener<WatchReactionsbyAnnouncmentIdCubit,
//           WatchReactionsbyAnnouncmentIdState>(
//         listener: (context, state) {
//           if (state is WatchReactionsbyAnnouncmentIdComplete) {
//             originalReactionsNotifier.value = state.reactions;
//             _updateEmojiTabs(state.reactions);
//           }
//         },
//         child: ValueListenableBuilder(
//           valueListenable: emojiTabs,
//           builder: (context, emojis, _) {
//             if (emojis.isEmpty || _tabController == null) {
//               return const Center(child: Text("No reactions found"));
//             }
//             return Column(
//               children: [
//                 TabBar(
//                   controller: _tabController!,
//                   isScrollable: true,
//                   tabs: emojis
//                       .map((emoji) => Image.network(emoji)
//                           //  Tab(text: emoji)
//                           )
//                       .toList(),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController!,
//                     children: emojis.map((emoji) {
//                       return ValueListenableBuilder(
//                         valueListenable: originalReactionsNotifier,
//                         builder: (context, reactions, _) {
//                           final filtered = reactions
//                               .where((r) => r.emoji.emojiUrl == emoji)
//                               .toList();
//                           return ListView.builder(
//                             itemCount: filtered.length,
//                             itemBuilder: (_, i) => ListTile(
//                               title: Text(filtered[i].userName),
//                               // subtitle: Text(filtered[i].emoji.e),
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class FitFlexReactionsPage extends StatefulWidget {
//   final String announcementId;
//   const FitFlexReactionsPage({
//     super.key,
//     required this.announcementId,
//   });
//   static const route = 'reactions_page';

//   @override
//   State<FitFlexReactionsPage> createState() => _FitFlexReactionsPageState();
// }

// class _FitFlexReactionsPageState extends State<FitFlexReactionsPage>
//     with TickerProviderStateMixin {
//   final ValueNotifier<List<Reaction>> originalReactionsNotifier =
//       ValueNotifier([]);
//   final ValueNotifier<List<Reaction>> emojiTabs = ValueNotifier([]);
//   TabController? _tabController;

//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<WatchReactionsbyAnnouncmentIdCubit>()
//         .getReactionsByAnnouncementId(widget.announcementId);
//   }

//   void _updateEmojiTabs(List<Reaction> reactions) {
//     final uniqueEmojiReactions = <String, Reaction>{};

//     for (var reaction in reactions) {
//       uniqueEmojiReactions.putIfAbsent(
//           reaction.emoji.emojiTitle, () => reaction);
//     }

//     final uniqueReactions = uniqueEmojiReactions.values.toList()
//       ..sort(
//         (a, b) => a.emoji.emojiTitle.compareTo(b.emoji.emojiTitle),
//       );

//     _tabController?.dispose();
//     _tabController = TabController(length: uniqueReactions.length, vsync: this);

//     emojiTabs.value = uniqueReactions;
//   }

//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PlatformAppbar.basicAppBar(
//         title: "Reactions",
//         foregroundColor: globalColorScheme.primary,
//         context: context,
//         backgroundColor: globalColorScheme.onPrimaryContainer,
//       ),
//       body: BlocBuilder<WatchReactionsbyAnnouncmentIdCubit,
//           WatchReactionsbyAnnouncmentIdState>(
//         builder: (context, state) {
//           if (state is WatchReactionsbyAnnouncmentIdComplete) {
//             originalReactionsNotifier.value = state.reactions;
//             _updateEmojiTabs(state.reactions);
//           }

//           return ValueListenableBuilder(
//             valueListenable: emojiTabs,
//             builder: (context, emojis, _) {
//               if (emojis.isEmpty || _tabController == null) {
//                 return const Center(child: Text("No reactions found"));
//               }

//               return Column(
//                 children: [
//                   TabBar(
//                     controller: _tabController!,
//                     isScrollable: true,
//                     tabs: emojis
//                         .map(
//                           (emoji) => Tab(
//                             child: Image.network(
//                               emoji.emoji.emojiUrl,
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       controller: _tabController!,
//                       children: emojis.map((emoji) {
//                         return ValueListenableBuilder(
//                           valueListenable: originalReactionsNotifier,
//                           builder: (context, reactions, _) {
//                             final filtered = reactions
//                                 .where((r) =>
//                                     r.emoji.emojiTitle ==
//                                     emoji.emoji.emojiTitle)
//                                 .toList();
//                             return ListView.builder(
//                               itemCount: filtered.length,
//                               itemBuilder: (_, i) => ListTile(
//                                 title: Text(filtered[i].userName),
//                               ),
//                             );
//                           },
//                         );
//                       }).toList(),
//                     ),
//                   )
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class FitFlexReactionsPage extends StatefulWidget {
  final String announcementId;
  const FitFlexReactionsPage({
    super.key,
    required this.announcementId,
  });

  static const route = 'reactions_page';

  @override
  State<FitFlexReactionsPage> createState() => _FitFlexReactionsPageState();
}

class _FitFlexReactionsPageState extends State<FitFlexReactionsPage>
    with TickerProviderStateMixin {
  final ValueNotifier<List<Reaction>> originalReactionsNotifier =
      ValueNotifier([]);
  final ValueNotifier<List<Reaction>> emojiTabs = ValueNotifier([]);
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // print(widget.announcementId);
    context
        .read<WatchReactionsbyAnnouncmentIdCubit>()
        .getReactionsByAnnouncementId(widget.announcementId);
  }

  String timeAgoSinceDate(DateTime postDate) {
    final now = DateTime.now();
    final difference = now.difference(postDate);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mon';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}yr';
    }
  }

  void _updateEmojiTabs(List<Reaction> reactions) {
    final uniqueEmojiReactions = <String, Reaction>{};

    for (var reaction in reactions) {
      uniqueEmojiReactions.putIfAbsent(
          reaction.emoji.emojiTitle, () => reaction);
    }

    final uniqueReactions = uniqueEmojiReactions.values.toList()
      ..sort(
        (a, b) => a.emoji.emojiTitle.compareTo(b.emoji.emojiTitle),
      );

    _tabController?.dispose();
    _tabController = TabController(length: uniqueReactions.length, vsync: this);

    emojiTabs.value = uniqueReactions;
  }

  @override
  void dispose() {
    _tabController?.dispose();
    originalReactionsNotifier.dispose();
    emojiTabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: "Reactions",
        foregroundColor: globalColorScheme.primary,
        context: context,
        backgroundColor: globalColorScheme.onPrimaryContainer,
      ),
      body: BlocListener<WatchReactionsbyAnnouncmentIdCubit,
          WatchReactionsbyAnnouncmentIdState>(
        listener: (context, state) {
          if (state is WatchReactionsbyAnnouncmentIdComplete) {
            originalReactionsNotifier.value = state.reactions;
            _updateEmojiTabs([
              Reaction(
                userId: '',
                id: '',
                announcementId: '',
                userName: '',
                emoji: EmojiModel(
                  emojiId: '',
                  emojiTitle: 'All',
                  emojiUrl: "",
                ),
                timestamp: DateTime.now(),
              ),
              ...state.reactions
            ]);
            // print(state.reactions);
          }
        },
        child: ValueListenableBuilder(
          valueListenable: emojiTabs,
          builder: (context, emojis, _) {
            if (emojis.isEmpty || _tabController == null) {
              return const Center(
                child: Text(
                  "No reactions found",
                ),
              );
            }

            return Column(
              children: [
                TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: _tabController!,
                  isScrollable: true,
                  tabs: emojis
                      .map(
                        (emoji) => Tab(
                          child: emoji.emoji.emojiTitle == "All"
                              ? Text('All')
                              : Image.network(
                                  emoji.emoji.emojiUrl,
                                ),
                        ),
                      )
                      .toList(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController!,
                    children: emojis.map((emoji) {
                      return ValueListenableBuilder(
                        valueListenable: originalReactionsNotifier,
                        builder: (context, reactions, _) {
                          final filtered = emoji.emoji.emojiTitle == "All"
                              ? reactions
                              : reactions
                                  .where((r) =>
                                      r.emoji.emojiTitle ==
                                      emoji.emoji.emojiTitle)
                                  .toList();
                          return ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (_, i) => ListTile(
                              dense: true,
                              leading: CircleAvatar(
                                child: Text(
                                  filtered[i].userName[0],
                                ),
                              ),
                              title: Text(filtered[i].userName),
                              subtitle: Text(
                                timeAgoSinceDate(
                                  filtered[i].timestamp,
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: globalColorScheme.onPrimary
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

// class _FitFlexReactionsPageState extends State<FitFlexReactionsPage>
//     with SingleTickerProviderStateMixin {
//   final ValueNotifier<List<Reaction>> originalReactionsNotifier =
//       ValueNotifier([]);
//   late TabController _tabController;
//   final ValueNotifier<List<String>> emojiTabs = ValueNotifier([]);

//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<WatchReactionsbyAnnouncmentIdCubit>()
//         .getReactionsByAnnouncementId(widget.announcementId);
//     _tabController = TabController(
//       length: emojiTabs.value.length,
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _updateEmojiTabs(List<Reaction> reactions) {
//     final uniqueEmojis =
//         reactions.map((r) => r.emoji.emojiUrl).toSet().toList();
//     emojiTabs.value = uniqueEmojis;

//     _tabController = TabController(length: uniqueEmojis.length, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PlatformAppbar.basicAppBar(
//         title: "Reactions",
//         foregroundColor: globalColorScheme.primary,
//         context: context,
//         backgroundColor: globalColorScheme.onPrimaryContainer,
//       ),
//       body: BlocListener<WatchReactionsbyAnnouncmentIdCubit,
//           WatchReactionsbyAnnouncmentIdState>(
//         listener: (context, state) {
//           if (state is WatchReactionsbyAnnouncmentIdComplete) {
//             originalReactionsNotifier.value = state.reactions;
//             _updateEmojiTabs(state.reactions);
//           }
//         },
//         child: ValueListenableBuilder<List<Reaction>>(
//           valueListenable: originalReactionsNotifier,
//           builder: (context, reactions, _) {
//             return ValueListenableBuilder<List<String>>(
//               valueListenable: emojiTabs,
//               builder: (context, tabs, _) {
//                 if (tabs.isEmpty) {
//                   return const Center(child: Text("No reactions yet"));
//                 }

//                 return Column(
//                   children: [
//                     TabBar(
//                       controller: _tabController,
//                       tabs: tabs
//                           .map(
//                             (emoji) => Tab(
//                               child: Text(
//                                 emoji,
//                                 style: const TextStyle(
//                                   fontSize: 24,
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                       isScrollable: true,
//                     ),
//                     Expanded(
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: tabs.map(
//                           (emoji) {
//                             final filtered = reactions
//                                 .where((r) => r.emoji.emojiUrl == emoji)
//                                 .toList();
//                             return ListView.builder(
//                               itemCount: filtered.length,
//                               itemBuilder: (context, index) {
//                                 final r = filtered[index];
//                                 return ListTile(
//                                   leading: CircleAvatar(
//                                     child: Text(
//                                       r.userName[0],
//                                     ),
//                                   ),
//                                   title: Text(r.userName),
//                                   subtitle: Text(
//                                     r.timestamp.toLocal().toString(),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ).toList(),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
