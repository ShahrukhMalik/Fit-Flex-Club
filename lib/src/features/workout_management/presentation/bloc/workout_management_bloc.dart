import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/create_workout_plan_usecase.dart'
    as create;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/get_exercises_usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/get_workout_plans_usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/update_workout_plan_usecase.dart'
    as update;
import 'package:injectable/injectable.dart';

part 'workout_management_event.dart';
part 'workout_management_state.dart';

@injectable
class WorkoutManagementBloc
    extends Bloc<WorkoutManagementEvent, WorkoutManagementState> {
  final GetExercisesUsecase getExercisesUsecase;
  final create.CreateWorkoutPlanUsecase createWorkoutPlanUsecase;
  final GetWorkoutPlansUsecase getWorkoutPlansUsecase;
  final update.UpdateWorkoutPlanUsecase updateWorkoutPlanUsecase;
  WorkoutManagementBloc(
    this.getExercisesUsecase,
    this.createWorkoutPlanUsecase,
    this.getWorkoutPlansUsecase,
    this.updateWorkoutPlanUsecase,
  ) : super(WorkoutManagementInitial()) {
    on<WorkoutManagementEvent>((event, emit) async {
      if (event is GetExercisesEvent) {
        await _getExercises(event, emit);
      }
      if (event is CreateWorkoutPlanEvent) {
        await _createWorkoutPlan(event, emit);
      }
      if (event is UpdateWorkoutPlanEvent) {
        await _updateWorkoutPlan(event, emit);
      }
      if (event is GetWorkoutPlansEvent) {
        await _getWorkoutPlans(event, emit);
      }
    });
  }

  Future<void> _getExercises(
    GetExercisesEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    // emit(WorkoutManagementLoading());
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

  Future<void> _createWorkoutPlan(
    CreateWorkoutPlanEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(WorkoutManagementLoading());
    final result = await createWorkoutPlanUsecase(
      create.Params(
        workoutPlan: event.workoutPlan,
      ),
    );

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
          emit(CreateWorkoutComplete());
        },
      );
    }
  }

  _getWorkoutPlans(
    GetWorkoutPlansEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(WorkoutManagementLoading());
    final result = await getWorkoutPlansUsecase(
      NoParams(),
    );

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
            emit(GetWorkoutPlansComplete(workoutPlans: r));
          }
        },
      );
    }
  }

  _updateWorkoutPlan(
    UpdateWorkoutPlanEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(WorkoutManagementLoading());
    final result = await updateWorkoutPlanUsecase(
      update.Params(
        workoutPlan: event.workoutPlan,
      ),
    );

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
          emit(UpdateWorkoutComplete());
        },
      );
    }
  }
}
