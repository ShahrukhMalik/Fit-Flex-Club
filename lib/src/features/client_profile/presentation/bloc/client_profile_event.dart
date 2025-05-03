part of 'client_profile_bloc.dart';

abstract class ClientProfileEvent extends Equatable {
  const ClientProfileEvent();

  @override
  List<Object?> get props => [];
}

class AddUserClientProfileEvent extends ClientProfileEvent {
  final Gym gym;
  final ClientEntity clientEntity;
  final Trainer trainer;

  const AddUserClientProfileEvent({
    required this.clientEntity,
    required this.gym,
    required this.trainer,
  });
  @override
  List<Object> get props => [
        clientEntity,
        gym,
      ];
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
