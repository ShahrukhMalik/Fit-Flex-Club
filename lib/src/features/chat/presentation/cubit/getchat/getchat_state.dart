part of 'getchat_cubit.dart';

abstract class GetChatState extends Equatable {
  const GetChatState();

  @override
  List<Object?> get props => [];
}

class GetChatInitial extends GetChatState {}

class GetChatError extends GetChatState {
  final Failures failure;
  const GetChatError(this.failure);
}

class GetChatComplete extends GetChatState {
  final ChatEntity? chat;
  const GetChatComplete(this.chat);
  @override
  List<Object?> get props => [chat];
}

class GetChatLoading extends GetChatState {}
