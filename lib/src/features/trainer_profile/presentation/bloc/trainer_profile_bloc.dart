import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trainer_profile_event.dart';
part 'trainer_profile_state.dart';

class TrainerProfileBloc extends Bloc<TrainerProfileEvent, TrainerProfileState> {
  TrainerProfileBloc() : super(TrainerProfileInitial()) {
    on<TrainerProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
