import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_select_clients_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_trainer_hub_page.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/startchat/startchat_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/watchchatstream/watchchatstream_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/pages/fit_flex_chat_window_page.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FitFlexOneToOneChatPage extends StatefulWidget {
  static const route = 'one_to_one_chat';

  const FitFlexOneToOneChatPage({
    super.key,
  });

  @override
  State<FitFlexOneToOneChatPage> createState() =>
      _FitFlexOneToOneChatPageState();
}

class _FitFlexOneToOneChatPageState extends State<FitFlexOneToOneChatPage> {
  final ValueNotifier<List<ChatEntity>> chatsNotifier = ValueNotifier([]);

  late String currentUserId;
  @override
  void initState() {
    super.initState();
    currentUserId = getIt<FirebaseAuth>().currentUser!.uid;
    context.read<WatchChatStreamCubit>().getChats();
  }

  String _formatChatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inDays;

    if (difference == 0 &&
        now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year) {
      return "Today";
    } else if (difference == 1 ||
        (difference == 0 && now.day != dateTime.day)) {
      return "Yesterday";
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }

  Future<void> onAddChat() async {
    final result = await context.push(
      '${FitFlexTrainerHubPage.route}/${FitFlexOneToOneChatPage.route}/${FitFlexSelectClientsPage.route}',
      extra: {
        'forChat': true,
        'selectedClients': null,
        'currentChats': chatsNotifier.value
      },
    );

    if (result.runtimeType == ClientModel) {
      final client = result as ClientModel;
      if (client.id == null) {
        Fluttertoast.showToast(msg: 'Client Id not found');
        return;
      }
      final chat = ChatEntity(
        id: '',
        members: [
          {
            'userId': client.id,
            'userName': client.username,
          },
          {
            'userId': currentUserId,
            'userName': "Trainer",
          },
        ],
        lastMessage: 'No messages yet..',
        lastSender: currentUserId,
        lastTimestamp: DateTime.now(),
        unreadCount: {client.id ?? 'N/A': 0, currentUserId: 0},
      );
      context.read<StartChatCubit>().startChat(chat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: "ChatApp",
        context: context,
        backgroundColor: globalColorScheme.surface,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: globalColorScheme.primary,
        onPressed: onAddChat,
        child: IconButton.filled(
          onPressed: onAddChat,
          icon: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Icon(Icons.chat_bubble_outline, size: 30),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: globalColorScheme.onPrimaryContainer,
                ),
                padding: EdgeInsets.all(2),
                child: Icon(Icons.add, size: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<StartChatCubit, StartChatState>(
        listener: (context, state) {
          if (state is StartChatLoading) {
            PlatformDialog.showLoadingDialog(
              context: context,
              message: "Intiating a chat",
            );
          }

          if (state is StartChatComplete) {
            context.pop();
          }
        },
        child: BlocConsumer<WatchChatStreamCubit, WatchChatStreamState>(
          listener: (context, state) {
            // TODO: implement listener

            if (state is WatchChatStreamComplete) {
              final chats = state.chats;

              if (chats.isEmpty) {
                try {
                  getIt<ChatRepository>().getAllChats();
                } on ServerException catch (error) {
                  Fluttertoast.showToast(msg: error.errorMessage);
                } on CacheException catch (error) {
                  Fluttertoast.showToast(msg: error.errorMessage);
                }
              } else {
                chatsNotifier.value = chats;
              }
            }
          },
          builder: (context, state) {
            if (state is WatchChatStreamComplete) {
              final chats = state.chats;
              if (chats.isNotEmpty) {
                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final userName = chat.members
                        .where(
                          (element) => element['userId'] != currentUserId,
                        )
                        .first['userName'];
                    final unreadCount =
                        (chat.unreadCount[currentUserId] ?? 0) > 0
                            ? (chat.unreadCount[currentUserId] ?? 0).toString()
                            : '';
                    final formattedTime =
                        DateFormat.Hm().format(chat.lastTimestamp);
                    print('-----');
                    return ListTile(
                      onTap: () {
                        context.push(
                          '${FitFlexTrainerHubPage.route}/${FitFlexOneToOneChatPage.route}/${FitFlexChatWindowPage.route}',
                          extra: {'chat': chat, 'currentUserId': currentUserId},
                        );
                      },
                      leading: CircleAvatar(
                        child: Text(userName[0].toUpperCase()),
                      ),
                      title: Text(userName),
                      subtitle: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(formattedTime),
                          if (unreadCount.isNotEmpty)
                            CircleAvatar(
                              backgroundColor:
                                  globalColorScheme.secondaryContainer,
                              maxRadius: 15,
                              minRadius: 12,
                              child: Center(
                                child: Text(
                                  unreadCount,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("Initiate a chat with your clients..."),
                );
              }
            }
            return Center(
              child: Text("Getting Your Chats..."),
            );
          },
        ),
      ),
    );
  }
}
