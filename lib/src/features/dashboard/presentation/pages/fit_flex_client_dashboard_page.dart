// import 'dart:ui';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fit_flex_club/src/core/common/services/fcm_service.dart';
// import 'package:fit_flex_club/src/core/common/services/local_notification_service.dart';
// import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
// import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
// import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
// import 'package:fit_flex_club/src/core/util/network/network_info.dart';
// import 'package:fit_flex_club/src/core/util/sharedpref/shared_prefs_util.dart';
// import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
// import 'package:fit_flex_club/src/features/chat/presentation/cubit/startchat/startchat_cubit.dart';
// import 'package:fit_flex_club/src/features/chat/presentation/cubit/watchchatstream/watchchatstream_cubit.dart';
// import 'package:fit_flex_club/src/features/chat/presentation/pages/fit_flex_client_chat_window_page.dart';
// import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_profile_page.dart';
// import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
// import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // ... other imports remain the same

// class FitFlexClientDashboardPage extends StatefulWidget {
//   final StatefulNavigationShell navigationShell;
//   final bool showBottomNavBar;
//   final bool showFloatingAction;
//   final bool showBlurEffectBottomNavbar;

//   const FitFlexClientDashboardPage({
//     super.key,
//     required this.navigationShell,
//     this.showBottomNavBar = false,
//     this.showFloatingAction = false,
//     this.showBlurEffectBottomNavbar = true,
//   });

//   @override
//   State<FitFlexClientDashboardPage> createState() =>
//       _FitFlexClientDashboardPageState();
// }

// class _FitFlexClientDashboardPageState
//     extends State<FitFlexClientDashboardPage> {
//   final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

//   @override
//   void initState() {
//     super.initState();
//     final savedContext = context;
//     getIt<NetworkInfo>().isConnected?.then(
//       (isConnected) async {
//         if (isConnected) {
//           LocalNotificationService.initialize(context).then(
//             (value) async {
//               await FCMService.initializeFCM();
//             },
//           );
//         }
//       },
//     );
//     selectedIndex.value = widget.navigationShell.currentIndex;
//     context.read<WatchChatStreamCubit>().getChats();
//   }

//   Widget _buildBottomNavOverlay(
//     BuildContext context,
//     double width,
//   ) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 75, vertical: 10),
//       padding: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: globalColorScheme.onPrimaryContainer,
//         borderRadius: BorderRadius.circular(100),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 10,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           ValueListenableBuilder<int>(
//             valueListenable: selectedIndex,
//             builder: (context, currentIndex, _) {
//               return AnimatedPositioned(
//                 duration: Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 left: currentIndex * (width * 0.2),
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: globalColorScheme.surfaceContainer.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               );
//             },
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               _buildIcon(
//                 0,
//                 Icons.person,
//                 selectedIndex,
//                 widget.navigationShell,
//               ),
//               _buildIcon(
//                 1,
//                 Icons.history_rounded,
//                 selectedIndex,
//                 widget.navigationShell,
//               ),
//               _buildIcon(
//                 2,
//                 Icons.campaign_rounded,
//                 selectedIndex,
//                 widget.navigationShell,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildIcon(
//     int index,
//     IconData icon,
//     ValueNotifier<int> valueNotifier,
//     StatefulNavigationShell navigationShell,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         valueNotifier.value = index;
//         navigationShell.goBranch(
//           index,
//           initialLocation: index == navigationShell.currentIndex,
//         );
//         if (index == 0) {
//           context.read<WorkoutManagementBloc>().add(
//                 GetWorkoutPlansForClientEvent(
//                   clientId: getIt<FirebaseAuth>().currentUser!.uid,
//                 ),
//               );
//         }
//         if (index == 1) {
//           context.read<WorkoutHistoryBloc>().add(
//                 GetWorkoutHistoryEvent(
//                   cliendId: getIt<FirebaseAuth>().currentUser?.uid,
//                 ),
//               );
//         }
//       },
//       child: ValueListenableBuilder<int>(
//         valueListenable: valueNotifier,
//         builder: (context, currentIndex, _) {
//           bool isSelected = currentIndex == index;
//           return Material(
//             color: Colors.transparent,
//             shape: const CircleBorder(),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(50),
//               splashColor: globalColorScheme.tertiaryContainer.withOpacity(0.4),
//               highlightColor:
//                   globalColorScheme.surfaceContainer.withOpacity(0.2),
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 decoration: isSelected
//                     ? BoxDecoration(
//                         color: globalColorScheme.surfaceContainer,
//                         shape: BoxShape.circle,
//                       )
//                     : null,
//                 padding: EdgeInsets.all(15),
//                 child: Icon(
//                   icon,
//                   color: isSelected
//                       ? globalColorScheme.tertiaryContainer
//                       : globalColorScheme.surfaceContainer,
//                   size: isSelected ? 28 : 24,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     final double height = MediaQuery.of(context).size.height;

//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.transparent,
//         floatingActionButton: !widget.showFloatingAction
//             ? null
//             : FloatingActionButton(
//                 onPressed: () {},
//                 child: BlocConsumer<WatchChatStreamCubit, WatchChatStreamState>(
//                   listener: (context, state) {},
//                   builder: (context, state) {
//                     // if (state is SubjectFailed) {
//                     //   return ErrorOutput(message: state.message);
//                     // }
//                     if (state is WatchChatStreamComplete) {
//                       final currentUserId =
//                           getIt<FirebaseAuth>().currentUser?.uid;

//                       final chats = state.chats
//                           .where(
//                             (chat) => chat.members.any(
//                               (member) => member['userId'] == currentUserId,
//                             ),
//                           )
//                           .toList();
//                       String unreadCount = '';
//                       ChatEntity? chat;

//                       if (chats.isNotEmpty) {
//                         chat = chats[0];
//                         unreadCount = (chat.unreadCount[getIt<FirebaseAuth>()
//                                         .currentUser
//                                         ?.uid] ??
//                                     0) >
//                                 0
//                             ? (chat.unreadCount[getIt<FirebaseAuth>()
//                                         .currentUser
//                                         ?.uid] ??
//                                     0)
//                                 .toString()
//                             : '';
//                       }
//                       return Stack(
//                         children: [
//                           BlocListener<StartChatCubit, StartChatState>(
//                             listener: (context, state) {
//                               if (state is StartChatLoading) {
//                                 PlatformDialog.showLoadingDialog(
//                                     context: context,
//                                     message: "Initiating Chat...");
//                               }

//                               if (state is StartChatComplete) {
//                                 context.pop();
//                                 context.push(
//                                   '${FitFlexClientProfilePage.route}/${FitFlexClientChatWindowPage.route}',
//                                   extra: {
//                                     'chat': chat,
//                                   },
//                                 );
//                               }
//                             },
//                             child: IconButton(
//                               onPressed: () {
//                                 if (chat != null) {
//                                   context.push(
//                                     '${FitFlexClientProfilePage.route}/${FitFlexClientChatWindowPage.route}',
//                                     extra: {
//                                       'chat': chat,
//                                     },
//                                   );
//                                 } else {
//                                   final clientId = currentUserId ??
//                                       getIt<SharedPrefsUtil>().getAuthUid();
//                                   final clientName =
//                                       getIt<SharedPrefsUtil>().getUserName();
//                                   final trainerId =
//                                       getIt<SharedPrefsUtil>().getTrainerId();

//                                   final chat = ChatEntity(
//                                     id: '',
//                                     members: [
//                                       {
//                                         'userId': clientId,
//                                         'userName': clientName,
//                                       },
//                                       {
//                                         'userId': trainerId,
//                                         'userName': "Trainer",
//                                       },
//                                     ],
//                                     lastMessage: 'No messages yet..',
//                                     lastSender: clientId ?? '',
//                                     lastTimestamp: DateTime.now(),
//                                     unreadCount: {
//                                       clientId ?? 'N/A': 0,
//                                       trainerId ?? "N/A": 0
//                                     },
//                                   );
//                                   context
//                                       .read<StartChatCubit>()
//                                       .startChat(chat);
//                                 }
//                               },
//                               icon: Icon(Icons.chat_bubble),
//                             ),
//                           ),
//                           if (unreadCount.isNotEmpty)
//                             Positioned(
//                               right: 0,
//                               top: 0,
//                               child: CircleAvatar(
//                                 backgroundColor:
//                                     globalColorScheme.secondaryContainer,
//                                 minRadius: 12,
//                                 child: Center(
//                                   child: Text(
//                                     unreadCount,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                         ],
//                       );
//                     }
//                     return CupertinoActivityIndicator();
//                   },
//                 ),
//               ),
//         body: Stack(
//           children: [
//             // Background (can be your main content or image)
//             Positioned.fill(
//               child: widget.navigationShell,
//             ),

//             // Glass overlay
//             if (widget.showBottomNavBar)
//               if (widget.showBlurEffectBottomNavbar)
//                 Positioned(
//                   bottom: 0, // or wherever you want
//                   left: 0,
//                   right: 0,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ), // Optional
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                       child: Container(
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.white
//                               .withOpacity(0.15), // Semi-transparent
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.2),
//                           ),
//                         ),
//                         child: _buildBottomNavOverlay(context, width),
//                       ),
//                     ),
//                   ),
//                 )
//               else
//                 Positioned(
//                   bottom: 0, // or wherever you want
//                   left: 0,
//                   right: 0,
//                   child: _buildBottomNavOverlay(context, width),
//                 ),
//           ],
//         )
//         // Column(
//         //   children: [
//         //     // Main content
//         //     Expanded(child: widget.navigationShell),
//         //     // Bottom navigation overlay
//         //     if (widget.showBottomNavBar)
//         //       ClipRRect(
//         //         // borderRadius: BorderRadius.circular(20), // Optional
//         //         child: BackdropFilter(
//         //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         //           child: Container(
//         //             padding: EdgeInsets.all(12),
//         //             decoration: BoxDecoration(
//         //               color: globalColorScheme.primary.withOpacity(0.15), // Semi-transparent
//         //               // borderRadius: BorderRadius.circular(20),
//         //               border: Border.all(
//         //                 color: Colors.white.withOpacity(0.2),
//         //               ),
//         //             ),
//         //             child: _buildBottomNavOverlay(context, width),
//         //           ),
//         //         ),
//         //       )
//         //   ],
//         // )
//         ,
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/util/sharedpref/shared_prefs_util.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/startchat/startchat_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/watchchatstream/watchchatstream_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/pages/fit_flex_client_chat_window_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_profile_page.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexClientDashboardPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final bool showBottomNavBar;
  final bool showFloatingAction;
  final bool showBlurEffectBottomNavbar;

  const FitFlexClientDashboardPage({
    super.key,
    required this.navigationShell,
    this.showBottomNavBar = false,
    this.showFloatingAction = false,
    this.showBlurEffectBottomNavbar = true,
  });

  @override
  State<FitFlexClientDashboardPage> createState() =>
      _FitFlexClientDashboardPageState();
}

class _FitFlexClientDashboardPageState
    extends State<FitFlexClientDashboardPage> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  // Track icon positions/sizes
  final List<GlobalKey> _iconKeys = List.generate(3, (_) => GlobalKey());
  double _indicatorX = 0;
  double _indicatorSize = 10; // default size

  final GlobalKey _parentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedIndex.value = widget.navigationShell.currentIndex;
    context.read<WatchChatStreamCubit>().getChats();

    // calculate initial position after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveIndicatorTo(selectedIndex.value);
    });
  }

  void _moveIndicatorTo(int index) {
    final key = _iconKeys[index];
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final parentBox =
        _parentKey.currentContext?.findRenderObject() as RenderBox?;

    if (box != null && parentBox != null) {
      // Get the icon position relative to the parent container
      final position = box.localToGlobal(Offset.zero, ancestor: parentBox);

      setState(() {
        // icon center relative to parent
        final iconCenterX = position.dx + box.size.width / 2;

        // indicator should align its center with icon center
        _indicatorSize = box.size.width; // OR clamp if you want
        _indicatorX = iconCenterX - _indicatorSize / 2;
      });
    }
  }

  Widget _buildBottomNavOverlay(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: globalColorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        key: _parentKey,
        children: [
          // moving indicator
          ValueListenableBuilder<int>(
            valueListenable: selectedIndex,
            builder: (context, currentIndex, _) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _indicatorX,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: globalColorScheme.surfaceContainer.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          // icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIcon(0, Icons.person, widget.navigationShell),
              _buildIcon(1, Icons.history_rounded, widget.navigationShell),
              _buildIcon(2, Icons.campaign_rounded, widget.navigationShell),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(
    int index,
    IconData icon,
    StatefulNavigationShell navigationShell,
  ) {
    return GestureDetector(
      onTap: () {
        selectedIndex.value = index;
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
        _moveIndicatorTo(index); // update indicator position

        if (index == 0) {
          context.read<WorkoutManagementBloc>().add(
                GetWorkoutPlansForClientEvent(
                  clientId: getIt<FirebaseAuth>().currentUser!.uid,
                ),
              );
        }
        if (index == 1) {
          context.read<WorkoutHistoryBloc>().add(
                GetWorkoutHistoryEvent(
                  cliendId: getIt<FirebaseAuth>().currentUser?.uid,
                ),
              );
        }
      },
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, currentIndex, _) {
          final isSelected = currentIndex == index;
          return Container(
            key: _iconKeys[index], // 👈 attach key here
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                splashColor:
                    globalColorScheme.tertiaryContainer.withOpacity(0.4),
                highlightColor:
                    globalColorScheme.surfaceContainer.withOpacity(0.2),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: isSelected
                      ? BoxDecoration(
                          color: globalColorScheme.surfaceContainer,
                          shape: BoxShape.circle,
                        )
                      : null,
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? globalColorScheme.tertiaryContainer
                        : globalColorScheme.surfaceContainer,
                    size: isSelected ? 28 : 24,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: !widget.showFloatingAction
            ? null
            : FloatingActionButton(
                onPressed: () {},
                child: BlocConsumer<WatchChatStreamCubit, WatchChatStreamState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    // if (state is SubjectFailed) {
                    //   return ErrorOutput(message: state.message);
                    // }
                    if (state is WatchChatStreamComplete) {
                      final currentUserId =
                          getIt<FirebaseAuth>().currentUser?.uid;

                      final chats = state.chats
                          .where(
                            (chat) => chat.members.any(
                              (member) => member['userId'] == currentUserId,
                            ),
                          )
                          .toList();
                      String unreadCount = '';
                      ChatEntity? chat;

                      if (chats.isNotEmpty) {
                        chat = chats[0];
                        unreadCount = (chat.unreadCount[getIt<FirebaseAuth>()
                                        .currentUser
                                        ?.uid] ??
                                    0) >
                                0
                            ? (chat.unreadCount[getIt<FirebaseAuth>()
                                        .currentUser
                                        ?.uid] ??
                                    0)
                                .toString()
                            : '';
                      }
                      return Stack(
                        children: [
                          BlocListener<StartChatCubit, StartChatState>(
                            listener: (context, state) {
                              if (state is StartChatLoading) {
                                PlatformDialog.showLoadingDialog(
                                  context: context,
                                  message: "Initiating Chat...",
                                );
                              }

                              if (state is StartChatComplete) {
                                context.pop();
                                context.push(
                                  '${FitFlexClientProfilePage.route}/${FitFlexClientChatWindowPage.route}',
                                  extra: {
                                    'chat': chat,
                                  },
                                );
                              }
                            },
                            child: IconButton(
                              onPressed: () {
                                if (chat != null) {
                                  context.push(
                                    '${FitFlexClientProfilePage.route}/${FitFlexClientChatWindowPage.route}',
                                    extra: {
                                      'chat': chat,
                                    },
                                  );
                                } else {
                                  final clientId = currentUserId ??
                                      getIt<SharedPrefsUtil>().getAuthUid();
                                  final clientName =
                                      getIt<SharedPrefsUtil>().getUserName();
                                  final trainerId =
                                      getIt<SharedPrefsUtil>().getTrainerId();

                                  final chat = ChatEntity(
                                    id: '',
                                    members: [
                                      {
                                        'userId': clientId,
                                        'userName': clientName,
                                      },
                                      {
                                        'userId': trainerId,
                                        'userName': "Trainer",
                                      },
                                    ],
                                    lastMessage: 'No messages yet..',
                                    lastSender: clientId ?? '',
                                    lastTimestamp: DateTime.now(),
                                    unreadCount: {
                                      clientId ?? 'N/A': 0,
                                      trainerId ?? "N/A": 0
                                    },
                                  );
                                  context
                                      .read<StartChatCubit>()
                                      .startChat(chat);
                                }
                              },
                              icon: Icon(Icons.chat_bubble),
                            ),
                          ),
                          if (unreadCount.isNotEmpty)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: CircleAvatar(
                                backgroundColor:
                                    globalColorScheme.secondaryContainer,
                                minRadius: 12,
                                child: Center(
                                  child: Text(
                                    unreadCount,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      );
                    }
                    return CupertinoActivityIndicator();
                  },
                ),
              ),
        body: Stack(
          children: [
            Positioned.fill(child: widget.navigationShell),
            if (widget.showBottomNavBar)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: widget.showBlurEffectBottomNavbar
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: _buildBottomNavOverlay(context),
                          ),
                        ),
                      )
                    : _buildBottomNavOverlay(context),
              ),
          ],
        ),
      ),
    );
  }
}
