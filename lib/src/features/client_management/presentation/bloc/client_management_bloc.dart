import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'client_management_event.dart';
part 'client_management_state.dart';

class ClientManagementBloc extends Bloc<ClientManagementEvent, ClientManagementState> {
  ClientManagementBloc() : super(ClientManagementInitial()) {
    on<ClientManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
