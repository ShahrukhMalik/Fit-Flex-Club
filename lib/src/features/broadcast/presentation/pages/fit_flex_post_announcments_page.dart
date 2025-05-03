import 'dart:io';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';

import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/postannouncement/postannouncement_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/widgets/video_preview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

// ignore: constant_identifier_names
enum PostedFor { Gym, Trainer }

class FitFlexPostAnnouncmentsPage extends StatefulWidget {
  static const route = 'post_announcement';
  const FitFlexPostAnnouncmentsPage({super.key});

  @override
  State<FitFlexPostAnnouncmentsPage> createState() =>
      _FitFlexPostAnnouncmentsPageState();
}

class _FitFlexPostAnnouncmentsPageState
    extends State<FitFlexPostAnnouncmentsPage> {
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<PostedFor?> postByNotifier = ValueNotifier(
    null,
  );
  final ValueNotifier<Announcement?> announcementNotifier = ValueNotifier(null);

  Future<void> showCustomPostAsSheet({
    required BuildContext context,
    required String selectedOption,
    required ValueChanged<PostedFor> onSelected,
  }) async {
    final options = [PostedFor.Gym, PostedFor.Trainer];

    if (Platform.isIOS) {
      // iOS-style Action Sheet (Cupertino)
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(
            "Post By",
            style: TextStyle(fontSize: 18),
          ),
          actions: options.map(
            (option) {
              return CupertinoActionSheetAction(
                onPressed: () {
                  onSelected(option);
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    option.name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ),
      );
    } else {
      // Android-style Bottom Sheet (Material)
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Post As",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                ...options.map(
                  (option) => RadioListTile<String>(
                    value: option.name,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      if (value != null) {
                        onSelected(option);
                        Navigator.of(context).pop();
                      }
                    },
                    title: Text(option.name),
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _showMediaPickerSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
          title: const Text('Choose Media'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                context.pop();
                context.read<PostAnnouncementCubit>().pickImage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(CupertinoIcons.photo, size: 20),
                  SizedBox(width: 8),
                  Text('Pick Photo'),
                ],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                context.pop();
                context.read<PostAnnouncementCubit>().pickVideo();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    CupertinoIcons.video_camera,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text('Pick Video'),
                ],
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => context.pop(),
            isDefaultAction: true,
            child: const Text('Cancel'),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Pick Photo'),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<PostAnnouncementCubit>().pickImage();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.videocam),
                  title: Text('Pick Video'),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<PostAnnouncementCubit>().pickVideo();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<PostAnnouncementCubit, PostAnnouncementState>(
        listener: (context, state) {
          if (state is PostAnnouncementLoading) {
            PlatformDialog.showLoadingDialog(
              context: context,
            );
          }

          if (state is PostAnnouncementError) {
            context.pop();
            PlatformDialog.showAlertDialog(
              context: context,
              title: "Announcement",
              message: state.failure.message ?? "Something went wrong",
            );
          }

          if (state is PostAnnouncementComplete) {
            context.pop();
            context.pop();
          }
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showMediaPickerSheet(context),
            child: const Icon(Icons.photo_library),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.filledTonal(
                      color: globalColorScheme.onPrimaryContainer,
                      onPressed: context.pop,
                      icon: const Icon(Icons.close),
                    ),
                    ValueListenableBuilder(
                      valueListenable: postByNotifier,
                      builder: (context, value, child) {
                        return Row(
                          spacing: 10,
                          children: [
                            // if (value != null) Icon(Icons.fitness_center),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: globalColorScheme
                                    .onPrimaryContainer
                                    .withOpacity(0.1),
                                foregroundColor:
                                    globalColorScheme.onPrimaryContainer,
                                iconColor: globalColorScheme.onPrimaryContainer,
                              ),
                              icon: Icon(Icons.arrow_drop_down_rounded),
                              iconAlignment: IconAlignment.end,
                              onPressed: () {
                                showCustomPostAsSheet(
                                  context: context,
                                  selectedOption: "Trainer: You",
                                  onSelected: (value) {
                                    postByNotifier.value = value;
                                    final announcement =
                                        announcementNotifier.value ??
                                            Announcement(
                                              id: '',
                                              postType: PostType.text,
                                              postedFor: postByNotifier.value ??
                                                  PostedFor.Gym,
                                              createdAt: DateTime.now(),
                                            );
                                    announcementNotifier.value =
                                        announcement.copyWith(
                                      postedFor: value,
                                    );
                                  },
                                );
                              },
                              label: Text(
                                value == null ? "Choose Post By" : value.name,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: postByNotifier,
                      builder: (context, postBy, _) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: globalColorScheme.primaryContainer
                                .withOpacity(0.1),
                          ),
                          onPressed: () {
                            if (postBy == null) {
                              PlatformDialog.showAlertDialog(
                                context: context,
                                title: "Announcement",
                                message:
                                    "Choose wheather you are posting for Gym or Self as trainer,",
                              );
                              return;
                            }

                            final announcement = announcementNotifier.value;

                            if (announcement == null) {
                              PlatformDialog.showAlertDialog(
                                context: context,
                                title: "Announcement",
                                message:
                                    "Add text or atleast one media image or video to proceed.",
                              );
                              return;
                            }

                            final hasText = controller.text.trim().isNotEmpty;
                            final hasMedia = announcement.mediaBytes != null;

                            if (!hasText && !hasMedia) {
                              PlatformDialog.showAlertDialog(
                                context: context,
                                title: "Announcement",
                                message:
                                    "Add text or at least one media image or video to proceed.",
                              );
                              return;
                            }

                            if (!hasText && hasMedia) {
                              PlatformDialog.showAlertDialog(
                                context: context,
                                title: "Announcement",
                                message:
                                    "Continue without message, only with image or video?",
                                cancelText: 'Cancel',
                                confirmText: 'Confirm',
                                onCancel: () => context.pop(),
                                onConfirm: () => context
                                    .read<PostAnnouncementCubit>()
                                    .postAnnouncement(announcement),
                              );
                              return;
                            }

                            if (hasText && !hasMedia) {
                              context
                                  .read<PostAnnouncementCubit>()
                                  .postAnnouncement(
                                    announcement.copyWith(
                                      postType: PostType.text,
                                    ),
                                  );
                              return;
                            }

                            // If both text and media are present
                            context
                                .read<PostAnnouncementCubit>()
                                .postAnnouncement(announcement);
                          },
                          child: Text(
                            "Post",
                            style: TextStyle(
                              color: globalColorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // TextField and Media Preview
                Expanded(
                  child: Localizations(
                    locale: const Locale('en', 'US'),
                    delegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    child: Material(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Auto-growing TextFormField
                            TextFormField(
                              controller: controller,
                              maxLines: null,
                              onChanged: (value) {
                                final announcement =
                                    announcementNotifier.value ??
                                        Announcement(
                                          id: '',
                                          postType: PostType.text,
                                          postedFor: postByNotifier.value ??
                                              PostedFor.Gym,
                                          createdAt: DateTime.now(),
                                        );
                                announcementNotifier.value =
                                    announcement.copyWith(
                                  content: value,
                                );
                              },
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: 'Share your thoughts...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(20),
                              ),
                            ),

                            // Media Preview from Cubit
                            BlocConsumer<PostAnnouncementCubit,
                                PostAnnouncementState>(
                              listener: (context, state) {
                                if (state is MediaPicked) {
                                  final announcement =
                                      announcementNotifier.value ??
                                          Announcement(
                                            id: '',
                                            postType: PostType.text,
                                            postedFor: postByNotifier.value ??
                                                PostedFor.Gym,
                                            createdAt: DateTime.now(),
                                          );
                                  if (state.type == MediaType.image) {
                                    announcementNotifier.value =
                                        announcement.copyWith(
                                      postType: PostType.image,
                                      mediaBytes: state.bytes,
                                    );
                                  } else {
                                    announcementNotifier.value =
                                        announcement.copyWith(
                                      postType: PostType.video,
                                      mediaBytes: state.bytes,
                                    );
                                  }
                                }

                                if (state is PostAnnouncementInitial) {
                                  announcementNotifier.value =
                                      announcementNotifier.value?.copyWith(
                                    postType: null,
                                    mediaBytes: null,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is MediaPicked) {
                                  if (state.type == MediaType.image) {
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.memory(
                                              state.bytes,
                                              width: double.infinity,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          right: 10,
                                          child: IconButton.filledTonal(
                                            color: Colors.black,
                                            onPressed: () => context
                                                .read<PostAnnouncementCubit>()
                                                .removeMedia(),
                                            icon: Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  } else if (state.type == MediaType.video) {
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: VideoPreview(
                                              bytes: state.bytes,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          right: 10,
                                          child: IconButton.filledTonal(
                                            color: Colors.black,
                                            onPressed: () => context
                                                .read<PostAnnouncementCubit>()
                                                .removeMedia(),
                                            icon: Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                }
                                return const SizedBox.shrink(); // No media
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
