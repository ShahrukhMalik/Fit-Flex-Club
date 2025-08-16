part of 'deleteaccount_cubit.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountComplete extends DeleteAccountState {}

class DeleteAccountError extends DeleteAccountState {
  final Failures failure;
  const DeleteAccountError({required this.failure});
}
