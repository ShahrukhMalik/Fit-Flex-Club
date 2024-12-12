import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/workout_history/domain/usecases/log_workout_history_usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:injectable/injectable.dart';

part 'workout_history_event.dart';
part 'workout_history_state.dart';

@injectable
class WorkoutHistoryBloc
    extends Bloc<WorkoutHistoryEvent, WorkoutHistoryState> {
  final LogWorkoutHistoryUsecase logWorkoutHistoryUsecase;
  WorkoutHistoryBloc(
    this.logWorkoutHistoryUsecase,
  ) : super(WorkoutHistoryInitial()) {
    on<WorkoutHistoryEvent>((event, emit) async {
      if (event is LogWorkoutHistoryEvent) {
        await _logWorkoutHistory(event, emit);
      }
    });
  }

  _logWorkoutHistory(
    LogWorkoutHistoryEvent event,
    Emitter<WorkoutHistoryState> emit,
  ) async {
    emit(LogWorkoutHistoryLoading());
    final result = await logWorkoutHistoryUsecase(
      Params(
        sets: event.sets,
        exerciseId: event.exerciseId,
        dayId: event.dayId,
        weekId: event.weekId,
        workoutPlanId: event.workoutPlanId,
      ),
    );

    if (result == null) {
      emit(WorkoutHistoryError(failures: ServerFailure()));
      return;
    } else {
      result.fold(
        (l) {
          emit(WorkoutHistoryError(failures: l));
        },
        (r) {
          emit(LogWorkoutHistoryComplete());
        },
      );
    }
  }
}
