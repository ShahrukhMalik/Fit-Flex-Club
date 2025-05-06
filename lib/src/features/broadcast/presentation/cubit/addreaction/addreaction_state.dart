part of 'addreaction_cubit.dart';

abstract class AddReactionState extends Equatable {
  const AddReactionState();

  @override
  List<Object> get props => [];
}

class AddReactionInitial extends AddReactionState {}

class AddReactionLoading extends AddReactionState {}

class AddReactionError extends AddReactionState {
  final Failures failure;
  const AddReactionError({required this.failure});
}

class AddReactionComplete extends AddReactionState {}
