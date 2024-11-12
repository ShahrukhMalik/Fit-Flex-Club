part of 'client_profile_bloc.dart';

abstract class ClientProfileEvent extends Equatable {
  const ClientProfileEvent();

  @override
  List<Object> get props => [];
}

class AddUserClientProfileEvent extends ClientProfileEvent {
  final ClientEntity clientEntity;

  const AddUserClientProfileEvent({required this.clientEntity});
  @override
  List<Object> get props => [clientEntity];
}

class UpdateUserClientProfileEvent extends ClientProfileEvent {
  final ClientEntity clientEntity;

  const UpdateUserClientProfileEvent({required this.clientEntity});
  @override
  List<Object> get props => [clientEntity];
}

class CheckClientProfileExist extends ClientProfileEvent {}

class CheckIfUserActive extends ClientProfileEvent {}
