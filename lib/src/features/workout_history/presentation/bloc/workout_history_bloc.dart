import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_history/domain/usecases/get_workout_history_models_usecase.dart';
import 'package:fit_flex_club/src/features/workout_history/domain/usecases/log_workout_history_usecase.dart'
    as log;
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:injectable/injectable.dart';

part 'workout_history_event.dart';
part 'workout_history_state.dart';

@injectable
class WorkoutHistoryBloc
    extends Bloc<WorkoutHistoryEvent, WorkoutHistoryState> {
  final log.LogWorkoutHistoryUsecase logWorkoutHistoryUsecase;
  final GetWorkoutHistoryUsecase getWorkoutHistoryUsecase;
  WorkoutHistoryBloc(
    this.logWorkoutHistoryUsecase,
    this.getWorkoutHistoryUsecase,
  ) : super(WorkoutHistoryInitial()) {
    on<WorkoutHistoryEvent>((event, emit) async {
      if (event is LogWorkoutHistoryEvent) {
        await _logWorkoutHistory(event, emit);
      }
      if (event is GetWorkoutHistoryEvent) {
        await _getWorkoutHistory(event, emit);
      }
    });
  }

  _logWorkoutHistory(
    LogWorkoutHistoryEvent event,
    Emitter<WorkoutHistoryState> emit,
  ) async {
    emit(LogWorkoutHistoryLoading());
    final result = await logWorkoutHistoryUsecase(
      log.Params(event.exerciseModel),
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

  _getWorkoutHistory(
    GetWorkoutHistoryEvent event,
    Emitter<WorkoutHistoryState> emit,
  ) async {
    emit(GetWorkoutHistoryLoading());
    final result = await getWorkoutHistoryUsecase(
      Params(
        cliendId: event.cliendId,
      ),
    );

    if (result == null) {
      emit(WorkoutHistoryError(failures: ServerFailure()));
    } else {
      result.fold(
        (l) {
          emit(WorkoutHistoryError(failures: l));
        },
        (r) {
          emit(
            GetWorkoutHistoryComplete(workoutHistory: r),
          );
        },
      );
    }
  }
}
