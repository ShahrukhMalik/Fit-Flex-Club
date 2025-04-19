part of 'startchat_cubit.dart';

abstract class StartChatState extends Equatable {
  const StartChatState();

  @override
  List<Object> get props => [];
}

class StartChatInitial extends StartChatState {}

class StartChatError extends StartChatState {
  final Failures failure;

  const StartChatError({required this.failure});
}

class StartChatLoading extends StartChatState {}

class StartChatComplete extends StartChatState {}
