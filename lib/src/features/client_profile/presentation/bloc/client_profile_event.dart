part of 'client_profile_bloc.dart';

abstract class ClientProfileEvent extends Equatable {
  const ClientProfileEvent();

  @override
  List<Object?> get props => [];
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

class GetClientByIdEvent extends ClientProfileEvent {
  final String? clientId;

  const GetClientByIdEvent({required this.clientId});
  @override
  List<Object?> get props => [clientId];
}

class CheckClientProfileExist extends ClientProfileEvent {}

class CheckIfUserActive extends ClientProfileEvent {}
