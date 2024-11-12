part of 'client_profile_bloc.dart';

abstract class ClientProfileState extends Equatable {
  const ClientProfileState();

  @override
  List<Object> get props => [];
}

class ClientProfileInitial extends ClientProfileState {}

class ClientProfileLoading extends ClientProfileState {}

class ClientProfileComplete extends ClientProfileState {
  final bool? isUserActive;
  final bool? clientProfileExist;

  const ClientProfileComplete({
     this.isUserActive,
     this.clientProfileExist,
  });
}

class ClientProfileError extends ClientProfileState {
  final Failures failures;
  const ClientProfileError({required this.failures});
  @override
  List<Object> get props => [failures];
}
