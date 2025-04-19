part of 'watchchatstream_cubit.dart';

abstract class WatchChatStreamState extends Equatable {
  const WatchChatStreamState();

  @override
  List<Object> get props => [];
}

class WatchChatStreamInitial extends WatchChatStreamState {}

class WatchChatStreamError extends WatchChatStreamState {
  final Failures failure;
  const WatchChatStreamError({required this.failure});
}

class WatchChatStreamLoading extends WatchChatStreamState {}

class WatchChatStreamComplete extends WatchChatStreamState {
  final List<ChatEntity> chats;
  const WatchChatStreamComplete(this.chats);
  @override
  List<Object> get props => [chats];
}
