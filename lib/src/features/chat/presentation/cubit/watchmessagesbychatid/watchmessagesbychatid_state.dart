part of 'watchmessagesbychatid_cubit.dart';

abstract class WatchMessagesbyChatIdState extends Equatable {
  const WatchMessagesbyChatIdState();

  @override
  List<Object> get props => [];
}

class WatchMessagesbyChatIdInitial extends WatchMessagesbyChatIdState {}

class WatchMessagesbyChatIdError extends WatchMessagesbyChatIdState {
  final Failures failure;
  const WatchMessagesbyChatIdError({required this.failure});
}

class WatchMessagesbyChatIdLoading extends WatchMessagesbyChatIdState {}

class WatchMessagesbyChatIdComplete extends WatchMessagesbyChatIdState {
  final List<MessageEntity> messages;

  const WatchMessagesbyChatIdComplete(this.messages);

    @override
  List<Object> get props => [messages];
}
