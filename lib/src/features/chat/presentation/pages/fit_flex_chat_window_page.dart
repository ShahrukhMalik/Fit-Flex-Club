// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/chat/data/models/message_model.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/sendmessage/sendmessage_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/updatemessage/updatemessage_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/watchmessagesbychatid/watchmessagesbychatid_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FitFlexChatWindowPage extends StatefulWidget {
  static const route = 'chat_window';
  final ChatEntity chat;
  const FitFlexChatWindowPage({
    super.key,
    required this.chat,

  });

  @override
  State<FitFlexChatWindowPage> createState() => _FitFlexChatWindowPageState();
}

class _FitFlexChatWindowPageState extends State<FitFlexChatWindowPage> {
  final _messageController = TextEditingController();
  @override
  void initState() {
    currentUserId = getIt<FirebaseAuth>().currentUser!.uid;
    super.initState();
    context
        .read<WatchMessagesbyChatIdCubit>()
        .getMessagesByChatId(widget.chat.id);
  }

  late String currentUserId;

  @override
  Widget build(BuildContext context) {

    final userName = widget.chat.members
        .where(
          (element) => element['userId'] != currentUserId,
        )
        .first['userName'];
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: userName,
        foregroundColor: globalColorScheme.primary,
        context: context,
        backgroundColor: globalColorScheme.onPrimaryContainer,
        onLeadingPressed: context.pop,
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        leadingWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: globalColorScheme.primary,
              ),
              CircleAvatar(
                child: Icon(Icons.person_2_sharp),
              )
            ],
          ),
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

          ///
          Positioned.fill(
            bottom: 70,
            child: BlocConsumer<WatchMessagesbyChatIdCubit,
                WatchMessagesbyChatIdState>(
              listener: (context, state) {
                if (state is WatchMessagesbyChatIdComplete) {
                  final messages = state.messages;
                  final unReadMessages = messages.where(
                    (message) {
                      if (!(message.readBy.contains(currentUserId))) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                  ).toList();
                  context.read<UpdateMessageCubit>().updateMessageStatus(
                        unReadMessages: unReadMessages,
                        chat: widget.chat,
                      );
                }
              },
              builder: (context, state) {
                if (state is WatchMessagesbyChatIdLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is WatchMessagesbyChatIdComplete) {
                  final messages = state.messages
                      .reversed; // Make sure this is a List<MessageEntity>

                  if (messages.isNotEmpty) {
                    final List<dynamic> groupedItems = [];
                    String? lastDate;

                    for (var msg in messages) {
                      final msgDate =
                          DateFormat('yyyyMMdd').format(msg.timestamp);

                      if (lastDate != msgDate) {
                        groupedItems
                            .add('__DATE__${msg.timestamp.toIso8601String()}');
                        lastDate = msgDate;
                      }

                      groupedItems.add(msg);
                    }

                    // Reverse the list AFTER building, to match reverse: true
                    final reversedItems = groupedItems.reversed.toList();

                    return ListView.builder(
                      reverse: true,
                      itemCount: reversedItems.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemBuilder: (context, index) {
                        final item = reversedItems[index];
                        if (item is String && item.startsWith('__DATE__')) {
                          final date =
                              DateTime.parse(item.replaceFirst('__DATE__', ''));
                          final now = DateTime.now();

                          final isToday = DateFormat('yyyyMMdd').format(date) ==
                              DateFormat('yyyyMMdd').format(now);
                          final isYesterday =
                              DateFormat('yyyyMMdd').format(date) ==
                                  DateFormat('yyyyMMdd')
                                      .format(now.subtract(Duration(days: 1)));

                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(date);
                          if (isToday) {
                            formattedDate = 'Today';
                          } else if (isYesterday) {
                            formattedDate = 'Yesterday';
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: globalColorScheme.onPrimaryContainer
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: globalColorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        // Message bubble rendering
                        final message = item as MessageEntity;
                        final isCurrentUser =
                            message.senderId == currentUserId;
                        final formattedTime =
                            DateFormat.Hm().format(message.timestamp);

                        return Align(
                          alignment: isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 1.5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isCurrentUser
                                  ? globalColorScheme.primary.withOpacity(0.8)
                                  : globalColorScheme.onPrimaryContainer
                                      .withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    message.messageText,
                                    style: TextStyle(
                                      color: isCurrentUser
                                          ? globalColorScheme.onPrimary
                                          : globalColorScheme.onSecondary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    formattedTime,
                                    style: TextStyle(
                                      color: isCurrentUser
                                          ? globalColorScheme.onPrimaryContainer
                                              .withOpacity(0.8)
                                          : globalColorScheme.surface
                                              .withOpacity(0.7),
                                      fontSize: 9,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    // return ListView.builder(
                    //   reverse: true, // newest messages at the bottom
                    //   itemCount: messages.length,
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 16, vertical: 8),
                    //   itemBuilder: (context, index) {
                    //     final message = messages[index];

                    //     final isCurrentUser =
                    //         message.senderId == currentUserId;
                    //     final formattedTime =
                    //         DateFormat.Hm().format(message.timestamp);
                    //     return Align(
                    //       alignment: isCurrentUser
                    //           ? Alignment.centerRight
                    //           : Alignment.centerLeft,
                    //       child: Column(
                    //         children: [
                    //           Container(
                    //             margin:
                    //                 const EdgeInsets.symmetric(vertical: 1.5),
                    //             padding: const EdgeInsets.symmetric(
                    //                 horizontal: 10, vertical: 5),
                    //             decoration: BoxDecoration(
                    //               color: isCurrentUser
                    //                   ? globalColorScheme.primary
                    //                       .withOpacity(0.8)
                    //                   : globalColorScheme.onPrimaryContainer
                    //                       .withOpacity(0.7),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.min,
                    //               spacing: 5,
                    //               children: [
                    //                 Flexible(
                    //                   child: Text(
                    //                     message
                    //                         .messageText, // Or whatever your field is
                    //                     style: TextStyle(
                    //                       color: isCurrentUser
                    //                           ? globalColorScheme.onPrimary
                    //                           : globalColorScheme.onSecondary,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Align(
                    //                   alignment: Alignment.bottomCenter,
                    //                   child: Text(
                    //                     formattedTime,
                    //                     style: TextStyle(
                    //                       color: isCurrentUser
                    //                           ? globalColorScheme
                    //                               .onPrimaryContainer
                    //                               .withOpacity(0.8)
                    //                           : globalColorScheme.surface
                    //                               .withOpacity(0.7),
                    //                       fontSize: 9,
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // );
                  } else {
                    return Center(child: Text('No messages yet..'));
                  }
                }

                return Center(child: CupertinoActivityIndicator());
              },
            ),
          ),

          ///
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              spacing: 0,
              children: [
                Expanded(
                  child: AppTextFields.prefixSuffixTextField(
                    onFieldSubmitted: (message) {
                      if (_messageController.text.isNotEmpty) {
                        context.read<SendMessageCubit>().sendMessage(
                              message: MessageEntity(
                                id: '',
                                chatId: widget.chat.id,
                                senderId: currentUserId,
                                messageText: message,
                                timestamp: DateTime.now(),
                                type: 'text',
                                sentTo: [],
                                deliveredTo: [],
                                readBy: [],
                              ),
                              chat: widget.chat,
                            );
                      }
                      _messageController.clear();
                    },
                    controller: _messageController,
                    filledColor:
                        globalColorScheme.onPrimaryContainer.withOpacity(1),
                    style: TextStyle(
                      color: globalColorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor:
                          globalColorScheme.primary.withOpacity(0.3)),
                  icon: Icon(
                    Icons.send_sharp,
                    color: globalColorScheme.onPrimaryContainer,
                  ),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      context.read<SendMessageCubit>().sendMessage(
                            message: MessageEntity(
                              id: '',
                              chatId: widget.chat.id,
                              senderId: currentUserId,
                              messageText: _messageController.text.trim(),
                              timestamp: DateTime.now(),
                              type: 'text',
                              sentTo: [],
                              deliveredTo: [],
                              readBy: [],
                            ),
                            chat: widget.chat,
                          );
                    }
                    _messageController.clear();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
