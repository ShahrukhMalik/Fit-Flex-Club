part of 'updatemessage_cubit.dart';

abstract class UpdateMessageState extends Equatable {
  const UpdateMessageState();

  @override
  List<Object> get props => [];
}

class UpdateMessageInitial extends UpdateMessageState {}

class UpdateMessageError extends UpdateMessageState {
  final Failures failure;
  const UpdateMessageError({required this.failure});
}

class UpdateMessageComplete extends UpdateMessageState {}

class UpdateMessageLoading extends UpdateMessageState {}
