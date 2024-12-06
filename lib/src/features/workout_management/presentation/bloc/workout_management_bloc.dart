import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/get_exercises_usecase.dart';
import 'package:injectable/injectable.dart';

part 'workout_management_event.dart';
part 'workout_management_state.dart';

@injectable
class WorkoutManagementBloc
    extends Bloc<WorkoutManagementEvent, WorkoutManagementState> {
  final GetExercisesUsecase getExercisesUsecase;
  WorkoutManagementBloc(this.getExercisesUsecase)
      : super(WorkoutManagementInitial()) {
    on<WorkoutManagementEvent>((event, emit) async {
      if (event is GetExercisesEvent) {
        await _getExercises(event, emit);
      }
    });
  }

  Future<void> _getExercises(
    GetExercisesEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(WorkoutManagementLoading());
    final result = await getExercisesUsecase(NoParams());

    if (result == null) {
      emit(
        WorkoutManagementError(
          failures: ServerFailure(
            message: "Something went wrong",
          ),
        ),
      );
    } else {
      result.fold(
        (l) {
          emit(WorkoutManagementError(failures: l));
        },
        (r) {
          if (r == null) {
            emit(
              WorkoutManagementError(
                failures: ServerFailure(
                  message: "Something went wrong",
                ),
              ),
            );
          } else {
            emit(GetExercisesComplete(exercises: r));
          }
        },
      );
    }
  }
}
