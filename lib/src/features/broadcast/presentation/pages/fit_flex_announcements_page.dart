import 'dart:ui';

import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/util/sharedpref/shared_prefs_util.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/emoji_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/watch_comments_by_announcement_id_usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/addcomment/addcomment_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/addreaction/addreaction_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/getemojis/getemojis_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/watchannouncement/watchannouncement_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/watchcommentsbyannouncmentid/watchcommentsbyannouncmentid_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_post_announcments_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_reactions_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_trainer_hub_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/widgets/announcement_image_widget.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/widgets/comment_sheet_widget.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/widgets/reaction_bar_widget.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/widgets/video_preview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexAnnouncementsPage extends StatefulWidget {
  static const route = 'announcements_page';
  static const clientRoute = '/announcements_page';
  final bool isTrainer;
  const FitFlexAnnouncementsPage({
    super.key,
    this.isTrainer = false,
  });

  @override
  State<FitFlexAnnouncementsPage> createState() =>
      _FitFlexAnnouncementsPageState();
}

class _FitFlexAnnouncementsPageState extends State<FitFlexAnnouncementsPage> {
  final ValueNotifier<List<EmojiEntity>> emojisNotifier = ValueNotifier([]);
  final ValueNotifier<Map<String, Reaction?>> reactionsNotifier =
      ValueNotifier<Map<String, Reaction?>>({});

  @override
  void initState() {
    super.initState();
    context.read<WatchAnnouncementCubit>().getAnnouncements();
    context.read<GetEmojisCubit>().getEmojis();
  }

  void updateReaction(String announcementId, Reaction? reaction) {
    final currentReactions =
        Map<String, Reaction?>.from(reactionsNotifier.value);
    currentReactions[announcementId] = reaction;
    reactionsNotifier.value = currentReactions;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: "Announcements",
        foregroundColor: globalColorScheme.primary,
        context: context,
        backgroundColor: globalColorScheme.onPrimaryContainer,
        onLeadingPressed: () {
          if (widget.isTrainer) {
            context.pop();
          } else {
            context.go('/');
          }
        },
        // trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ),
      floatingActionButton: widget.isTrainer
          ? FloatingActionButton.extended(
              onPressed: () => context.go(
                '${FitFlexTrainerHubPage.route}/${FitFlexAnnouncementsPage.route}/${FitFlexPostAnnouncmentsPage.route}',
              ),
              icon: IconButton.filled(
                onPressed: null,
                icon: Icon(
                  Icons.add,
                ),
              ),
              label: Text(
                'Post',
              ),
            )
          : null,
      body: BlocListener<GetEmojisCubit, GetEmojisState>(
        listener: (context, state) {
          if (state is GetEmojisComplete) {
            emojisNotifier.value = state.emojis;
            // context.pop();
          }

          if (state is GetEmojisLoading) {
            // PlatformDialog.showLoadingDialog(context: context);
          }

          if (state is GetEmojisError) {
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Announcement",
                  message: state.failure.message ?? "Something went wrong.",
                );
              },
            );
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/chat_bg_fit_flex_club.png',
                fit: BoxFit.cover,
              ),
            ),
            BlocConsumer<WatchAnnouncementCubit, WatchAnnouncementState>(
              builder: (context, state) {
                if (state is WatchAnnouncementComplete) {
                  final announcements = state.announcements;

                  if (announcements.isEmpty) {
                    return Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 6.0,
                          sigmaY: 6.0,
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'No announcments done yet..',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    // reverse: true,
                    itemCount: announcements.length,
                    itemBuilder: (context, index) {
                      final announcement = announcements[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              globalColorScheme.inversePrimary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- Post Header ---
                            Row(
                              children: [
                                IconButton(
                                  style: IconButton.styleFrom(
                                    foregroundColor:
                                        globalColorScheme.onPrimaryContainer,
                                    backgroundColor: globalColorScheme.surface,
                                  ),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.fitness_center,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (announcement.postedFor == PostedFor.Gym)
                                      Text(
                                        announcement.gymName ?? 'Anonymous',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: globalColorScheme.onPrimary,
                                        ),
                                      )
                                    else
                                      Text(
                                        announcement.trainerName ?? 'Anonymous',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: globalColorScheme.onPrimary,
                                        ),
                                      ),
                                    Text(
                                      timeAgoSinceDate(
                                        announcement.createdAt,
                                      ),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: globalColorScheme.onPrimary
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),

                            // --- Post Content Text ---
                            if ((announcement.content ?? '').isNotEmpty) ...[
                              Text(
                                announcement.content ?? '',
                                style: TextStyle(
                                  color: globalColorScheme.onPrimary,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],

                            // --- Media Preview ---
                            if (announcement.postType == PostType.image)
                              SizedBox(
                                height: 250,
                                child: AnnouncementImageWidget(
                                  mediaUrl: announcement.mediaUrl,
                                  mediaBytes: announcement.mediaBytes,
                                ),
                              ),
                            if (announcement.postType == PostType.video)
                              SizedBox(
                                height: 250,
                                child: VideoPreview(
                                  networkUrl: announcement.mediaUrl,
                                  bytes: announcement.mediaBytes,
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if ((announcement.reactionCount ?? 0) > 0)
                                  InkWell(
                                    onTap: () => widget.isTrainer
                                        ? context.go(
                                            '${FitFlexTrainerHubPage.route}/${FitFlexAnnouncementsPage.route}/${FitFlexReactionsPage.route}',
                                            extra: {
                                              'announcementId': announcement.id
                                            },
                                          )
                                        : context.go(
                                            '${FitFlexAnnouncementsPage.clientRoute}/${FitFlexReactionsPage.route}',
                                            extra: {
                                              'announcementId': announcement.id
                                            },
                                          ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      spacing: 5,
                                      children: [
                                        Text(
                                          (announcement.reactionCount ?? 0)
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('Reactions')
                                      ],
                                    ),
                                  ),
                                if ((announcement.commentsCount ?? 0) > 0)
                                  BlocListener<AddcommentCubit,
                                      AddcommentState>(
                                    listener: (context, state) {
                                      if (state is AddcommentLoading) {
                                        // PlatformDialog.showLoadingDialog(
                                        //   context: context,
                                        // );
                                      }

                                      if (state is AddcommentError) {
                                        context.pop();
                                        PlatformDialog.showAlertDialog(
                                          context: context,
                                          title: 'Announcments',
                                          message: state.failure.message ??
                                              "Something went wrong",
                                        );
                                      }
                                      if (state is AddcommentComplete) {
                                        // context
                                        //     .read<
                                        //         WatchCommentsByAnnouncmentIdCubit>()
                                        //     .getCommentsByAnnouncement(
                                        //       announcement.id,
                                        //     );
                                      }
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<
                                                WatchCommentsByAnnouncmentIdCubit>()
                                            .getCommentsByAnnouncement(
                                              announcement.id,
                                            );

                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(16)),
                                          ),
                                          builder: (_) {
                                            return BlocBuilder<
                                                WatchCommentsByAnnouncmentIdCubit,
                                                WatchCommentsByAnnouncmentIdState>(
                                              builder: (context, state) {
                                                if (state
                                                    is WatchCommentsByAnnouncmentIdComplete) {
                                                  final comments =
                                                      state.comments;
                                                  return CommentsSheet(
                                                    comments:
                                                        comments, // List<Comment>
                                                    onSend: (text) {
                                                      context
                                                          .read<
                                                              AddcommentCubit>()
                                                          .addComment(
                                                            comment: Comment(
                                                              id: '',
                                                              userId: '',
                                                              announcementId:
                                                                  announcement
                                                                      .id,
                                                              content: text,
                                                              timestamp:
                                                                  DateTime
                                                                      .now(),
                                                              userName: '',
                                                            ),
                                                            announcementId:
                                                                announcement.id,
                                                          );
                                                    },
                                                  );
                                                }
                                                return CupertinoActivityIndicator();
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        spacing: 5,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            (announcement.commentsCount ?? 0)
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('Comments')
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Divider(
                              color: globalColorScheme.onPrimaryContainer
                                  .withOpacity(
                                0.2,
                              ),
                            ),

                            // --- Like & Comment Buttons ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        barrierColor: Colors.transparent,
                                        builder: (_) => Center(
                                          child: Builder(
                                            builder: (context) {
                                              return ValueListenableBuilder(
                                                valueListenable: emojisNotifier,
                                                builder: (context, emojis, _) {
                                                  return ReactionBar(
                                                    emojis: emojis,
                                                    onReact: (emoji) {
                                                      final reaction = Reaction(
                                                        userId: '',
                                                        id: '',
                                                        announcementId:
                                                            announcement.id,
                                                        userName: '',
                                                        emoji: emoji,
                                                        timestamp:
                                                            DateTime.now(),
                                                      );
                                                      updateReaction(
                                                          announcement.id,
                                                          reaction);
                                                      context
                                                          .read<
                                                              AddReactionCubit>()
                                                          .addReaction(
                                                            reaction: reaction,
                                                            announcementId:
                                                                announcement.id,
                                                          );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child:
                                        // announcement.myReaction == null
                                        //     ?
                                        ValueListenableBuilder(
                                      valueListenable: reactionsNotifier,
                                      builder: (context, myReaction, _) {
                                        if (myReaction[announcement.id] ==
                                            null) {
                                          return InkWell(
                                            onTap: () {
                                              final reaction = Reaction(
                                                userId: '',
                                                id: '',
                                                announcementId: announcement.id,
                                                userName: '',
                                                emoji: EmojiEntity(
                                                  emojiId:
                                                      'OrdFvRtWZeQFLhd0xUBa',
                                                  emojiTitle: 'Like',
                                                  emojiUrl:
                                                      'https://firebasestorage.googleapis.com/v0/b/fitflexclub-fa604.firebasestorage.app/o/emojis%2Flike_emoji.png?alt=media&token=dbfaf7c5-de85-4bb5-9e12-87b9c1297e81',
                                                ),
                                                timestamp: DateTime.now(),
                                              );
                                              updateReaction(
                                                  announcement.id, reaction);
                                              context
                                                  .read<AddReactionCubit>()
                                                  .addReaction(
                                                    reaction: reaction,
                                                    announcementId:
                                                        announcement.id,
                                                  );
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/emojis/like.png',
                                                ),
                                                SizedBox.shrink(),
                                                Text('Like')
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              Image.network(
                                                myReaction[announcement.id]!
                                                    .emoji
                                                    .emojiUrl,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return const Center(
                                                    child:
                                                        CupertinoActivityIndicator(),
                                                  );
                                                },
                                              ),
                                              SizedBox.shrink(),
                                              Text(
                                                myReaction[announcement.id]!
                                                    .emoji
                                                    .emojiTitle,
                                              )
                                            ],
                                          );
                                        }
                                      },
                                    )),
                                BlocListener<AddcommentCubit, AddcommentState>(
                                  listener: (context, state) {
                                    if (state is AddcommentLoading) {
                                      // PlatformDialog.showLoadingDialog(
                                      //   context: context,
                                      // );
                                    }

                                    if (state is AddcommentError) {
                                      context.pop();
                                      PlatformDialog.showAlertDialog(
                                        context: context,
                                        title: 'Announcments',
                                        message: state.failure.message ??
                                            "Something went wrong",
                                      );
                                    }
                                    if (state is AddcommentComplete) {
                                      // context
                                      //     .read<
                                      //         WatchCommentsByAnnouncmentIdCubit>()
                                      //     .getCommentsByAnnouncement(
                                      //       announcement.id,
                                      //     );
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<
                                              WatchCommentsByAnnouncmentIdCubit>()
                                          .getCommentsByAnnouncement(
                                            announcement.id,
                                          );

                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16)),
                                        ),
                                        builder: (_) {
                                          return BlocBuilder<
                                              WatchCommentsByAnnouncmentIdCubit,
                                              WatchCommentsByAnnouncmentIdState>(
                                            builder: (context, state) {
                                              // if (state is SubjectFailed) {
                                              //   return ErrorOutput(
                                              //       message: state.message);
                                              // }
                                              if (state
                                                  is WatchCommentsByAnnouncmentIdComplete) {
                                                final comments = state.comments;
                                                return CommentsSheet(
                                                  comments:
                                                      comments, // List<Comment>
                                                  onSend: (text) {
                                                    context
                                                        .read<AddcommentCubit>()
                                                        .addComment(
                                                          comment: Comment(
                                                            id: '',
                                                            userId: '',
                                                            announcementId:
                                                                announcement.id,
                                                            content: text,
                                                            timestamp:
                                                                DateTime.now(),
                                                            userName: '',
                                                          ),
                                                          announcementId:
                                                              announcement.id,
                                                        );
                                                  },
                                                );
                                              }
                                              return CupertinoActivityIndicator();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            'assets/emojis/comments.png'),
                                        SizedBox.shrink(),
                                        Text('Comment')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                if (state is WatchAnnouncementError) {
                  return Center(
                    child: Text(
                      textAlign: TextAlign.justify,
                      state.failure.message ?? "Something went wrong",
                    ),
                  );
                  // PlatformDialog.showAlertDialog(
                  //   context: context,
                  //   title: "Announcements",
                  //   message: state.failure.message ?? "Something went wrong",
                  // );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              listener: (context, state) {
                if (state is WatchAnnouncementComplete) {
                  final announcements = state.announcements;
                  for (final announcement in announcements) {
                    updateReaction(
                      announcement.id,
                      announcement.myReaction,
                    );
                  }
                }
                if (state is WatchAnnouncementError) {
                  PlatformDialog.showAlertDialog(
                    onConfirm: () {
                      context.pop();
                      if (context.canPop()) context.pop();
                    },
                    context: context,
                    title: "Announcements",
                    message: state.failure.message ?? "Something went wrong",
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
