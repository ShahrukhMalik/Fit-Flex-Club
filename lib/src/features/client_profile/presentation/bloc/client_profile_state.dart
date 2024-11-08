part of 'client_profile_bloc.dart';

abstract class ClientProfileState extends Equatable {
  const ClientProfileState();  

  @override
  List<Object> get props => [];
}
class ClientProfileInitial extends ClientProfileState {}
