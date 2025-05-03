import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/watchannouncement/watchannouncement_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_post_announcments_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_trainer_hub_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/widgets/announcement_image_widget.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/widgets/video_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexAnnouncementsPage extends StatefulWidget {
  static const route = 'announcements_page';
  const FitFlexAnnouncementsPage({super.key});

  @override
  State<FitFlexAnnouncementsPage> createState() =>
      _FitFlexAnnouncementsPageState();
}

class _FitFlexAnnouncementsPageState extends State<FitFlexAnnouncementsPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchAnnouncementCubit>().getAnnouncements();
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
        onLeadingPressed: context.pop,
        // trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
      ),
      body: Stack(
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
                                  Text(
                                    announcement.trainerName ??
                                        announcement.gymName ??
                                        'Anonymous',
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
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon:
                                        const Icon(Icons.thumb_up_alt_outlined),
                                    color: globalColorScheme.onPrimary,
                                    onPressed: () {
                                      // TODO: Handle like logic
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  Text('Like')
                                ],
                              ),
                              // const SizedBox(width: 4),
                              // Text(
                              //   '${announcement.likes ?? 0}',
                              //   style: TextStyle(
                              //       color: globalColorScheme.onPrimary),
                              // ),
                              // const SizedBox(width: 20),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.comment_outlined),
                                    color: globalColorScheme.onPrimary,
                                    onPressed: () {
                                      // TODO: Handle comment logic
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  Text('Comment')
                                ],
                              ),
                              // const SizedBox(width: 4),
                              // Text(
                              //   '${announcement.comments ?? 0}',
                              //   style: TextStyle(
                              //       color: globalColorScheme.onPrimary),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (state is WatchAnnouncementError) {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Announcements",
                  message: state.failure.message ?? "Something went wrong",
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            listener: (context, state) {},
          )
        ],
      ),
    );
  }
}
