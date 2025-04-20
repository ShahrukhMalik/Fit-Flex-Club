import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_select_clients_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_trainer_hub_page.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/startchat/startchat_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/watchchatstream/watchchatstream_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/pages/fit_flex_chat_window_page.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FitFlexOneToOneChatPage extends StatefulWidget {
  static const route = 'one_to_one_chat';
  final String currentUserId;
  const FitFlexOneToOneChatPage({
    super.key,
    required this.currentUserId,
  });

  @override
  State<FitFlexOneToOneChatPage> createState() =>
      _FitFlexOneToOneChatPageState();
}

class _FitFlexOneToOneChatPageState extends State<FitFlexOneToOneChatPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchChatStreamCubit>().getChats();
  }

  Future<void> onAddChat() async {
    final result = await context.push(
      '${FitFlexTrainerHubPage.route}/${FitFlexOneToOneChatPage.route}/${FitFlexSelectClientsPage.route}',
      extra: {
        'forChat': true,
        'selectedClients': null,
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
            'userId': widget.currentUserId,
            'userName': "Trainer",
          },
        ],
        lastMessage: 'No messages yet..',
        lastSender: widget.currentUserId,
        lastTimestamp: DateTime.now(),
        unreadCount: {client.id ?? 'N/A': 0, widget.currentUserId: 0},
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
        onPressed: onAddChat,
        child: IconButton.filledTonal(
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
          },
          builder: (context, state) {
            if (state is WatchChatStreamComplete) {
              print('--------');
              final chats = state.chats;
              if (chats.isNotEmpty) {
                print('--------');
                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    print('--------');
                    final chat = chats[index];
                    final userName = chat.members.firstWhere(
                      (element) => element['userId'] != widget.currentUserId,
                    )['userName'];

                    final unreadCount =
                        (chat.unreadCount[widget.currentUserId] ?? 0) > 0
                            ? chat.unreadCount[widget.currentUserId].toString()
                            : '';

                    final formattedTime =
                        DateFormat.Hm().format(chat.lastTimestamp);

                    return ListTile(
                      onTap: () {
                        print('--------');
                        context.go(
                          '${FitFlexTrainerHubPage.route}/${FitFlexOneToOneChatPage.route}/${FitFlexChatWindowPage.route}',
                          extra: {
                            'chat': chat,
                          },
                        );
                      },
                      leading: Icon(
                        Icons.fitness_center_rounded,
                      ),
                      title: Text(userName),
                      subtitle: Text(chat.lastMessage),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(formattedTime),
                          if (unreadCount.isNotEmpty)
                            CircleAvatar(
                              backgroundColor:
                                  globalColorScheme.secondaryContainer,
                              radius: 20,
                              child: Text(
                                unreadCount,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
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
