import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'syncmanager_event.dart';
part 'syncmanager_state.dart';

class SyncmanagerBloc extends Bloc<SyncmanagerEvent, SyncmanagerState> {
  SyncmanagerBloc() : super(SyncmanagerInitial()) {
    on<SyncmanagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
