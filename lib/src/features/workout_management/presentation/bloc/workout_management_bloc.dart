import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_management_event.dart';
part 'workout_management_state.dart';

class WorkoutManagementBloc extends Bloc<WorkoutManagementEvent, WorkoutManagementState> {
  WorkoutManagementBloc() : super(WorkoutManagementInitial()) {
    on<WorkoutManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
