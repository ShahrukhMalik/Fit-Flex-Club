import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_tracking_event.dart';
part 'workout_tracking_state.dart';

class WorkoutTrackingBloc extends Bloc<WorkoutTrackingEvent, WorkoutTrackingState> {
  WorkoutTrackingBloc() : super(WorkoutTrackingInitial()) {
    on<WorkoutTrackingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
