part of 'sendmessage_cubit.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class SendMessageInitial extends SendMessageState {}

class SendMessageError extends SendMessageState {
  final Failures failure;
  const SendMessageError({required this.failure});
}

class SendMessageLoading extends SendMessageState {}

class SendMessageComplete extends SendMessageState {}
