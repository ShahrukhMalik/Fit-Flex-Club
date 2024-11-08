import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_history_event.dart';
part 'workout_history_state.dart';

class WorkoutHistoryBloc extends Bloc<WorkoutHistoryEvent, WorkoutHistoryState> {
  WorkoutHistoryBloc() : super(WorkoutHistoryInitial()) {
    on<WorkoutHistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
