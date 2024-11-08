part of 'client_management_bloc.dart';

abstract class ClientManagementState extends Equatable {
  const ClientManagementState();  

  @override
  List<Object> get props => [];
}
class ClientManagementInitial extends ClientManagementState {}
