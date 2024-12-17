import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/create_workout_plan_usecase.dart'
    as create;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/delete_assigned_workout_plan_usecase.dart'
    as delete_assigned;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/delete_workout_plan_usecase.dart'
    as delete;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/get_exercises_usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/get_workout_plan_for_client_usecase.dart'
    as clientWorkoutPlan;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/get_workout_plans_usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/assign_workout_plan_usecase.dart'
    as assign;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/update_assigned_workout_plan_usecase.dart'
    as update_assigned;
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
  final assign.AssignWorkoutPlanUsecase assignWorkoutPlanUsecase;
  final clientWorkoutPlan.GetWorkoutPlansForClientUsecase
      getWorkoutPlansForClientUsecase;
  final GetWorkoutPlansUsecase getWorkoutPlansUsecase;
  final update.UpdateWorkoutPlanUsecase updateWorkoutPlanUsecase;
  final delete_assigned.DeleteAssignedWorkoutPlanUsecase
      deleteAssignedWorkoutPlanUsecase;
  final delete.DeleteWorkoutPlanUsecase deleteWorkoutPlanUsecase;
  final update_assigned.UpdateAssignedWorkoutPlanUsecase
      updateAssignedWorkoutPlanUsecase;
  WorkoutManagementBloc(
    this.getExercisesUsecase,
    this.createWorkoutPlanUsecase,
    this.getWorkoutPlansUsecase,
    this.updateWorkoutPlanUsecase,
    this.assignWorkoutPlanUsecase,
    this.getWorkoutPlansForClientUsecase,
    this.deleteAssignedWorkoutPlanUsecase,
    this.deleteWorkoutPlanUsecase,
    this.updateAssignedWorkoutPlanUsecase,
  ) : super(WorkoutManagementInitial()) {
    on<WorkoutManagementEvent>(
      (event, emit) async {
        if (event is GetExercisesEvent) {
          await _getExercises(event, emit);
        }
        if (event is CreateWorkoutPlanEvent) {
          await _createWorkoutPlan(event, emit);
        }
        if (event is UpdateWorkoutPlanEvent) {
          await _updateWorkoutPlan(event, emit);
        }
        if (event is UpdateAssignedPlanEvent) {
          await _updateAssignedWorkoutPlan(event, emit);
        }
        if (event is GetWorkoutPlansEvent) {
          await _getWorkoutPlans(event, emit);
        }
        if (event is AssignWorkoutPlanEvent) {
          await _assignWorkoutPlan(event, emit);
        }
        if (event is GetWorkoutPlansForClientEvent) {
          await _getWorkoutPlanForClient(event, emit);
        }
        if (event is DeleteAssignedWorkoutPlanEvent) {
          await _deleteAssignedWorkout(event, emit);
        }
        if (event is DeleteWorkoutPlanEvent) {
          await _deleteWorkout(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _getExercises(
    GetExercisesEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(GetExercisesLoading());
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
    emit(GetWorkoutPlansLoading());
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
    emit(UpdateWorkoutLoading());
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

  Future<void> _assignWorkoutPlan(
    AssignWorkoutPlanEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(AssigneWorkoutPlanLoading());
    final result = await assignWorkoutPlanUsecase(
      assign.Params(
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
          emit(AssignWorkoutComplete());
        },
      );
    }
  }

  _getWorkoutPlanForClient(
    GetWorkoutPlansForClientEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(GetWorkoutPlansForClientLoading());
    final result = await getWorkoutPlansForClientUsecase(
      clientWorkoutPlan.Params(
        clientId: event.clientId,
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
          emit(
            GetWorkoutPlansForClientComplete(
              workoutPlan: r,
            ),
          );
        },
      );
    }
  }

  _deleteAssignedWorkout(
    DeleteAssignedWorkoutPlanEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(DeleteWorkoutLoading());
    final result = await deleteAssignedWorkoutPlanUsecase(
      delete_assigned.Params(workoutPlan: event.workoutPlan),
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
          emit(
            DeleteWorkoutComplete(),
          );
        },
      );
    }
  }

  _deleteWorkout(
    DeleteWorkoutPlanEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(DeleteWorkoutLoading());
    final result = await deleteWorkoutPlanUsecase(
      delete.Params(workoutPlan: event.workoutPlan),
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
          emit(
            DeleteWorkoutComplete(),
          );
        },
      );
    }
  }

  _updateAssignedWorkoutPlan(
    UpdateAssignedPlanEvent event,
    Emitter<WorkoutManagementState> emit,
  ) async {
    emit(UpdateWorkoutLoading());
    final result = await updateAssignedWorkoutPlanUsecase(
      update_assigned.Params(workoutPlan: event.workoutPlan),
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
          emit(
            UpdateAssignedWorkoutComplete(),
          );
        },
      );
    }
  }
}
