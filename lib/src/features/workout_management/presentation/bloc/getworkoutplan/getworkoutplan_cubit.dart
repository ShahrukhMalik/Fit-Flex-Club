import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/get_workout_plan_for_client_usecase.dart';
import 'package:injectable/injectable.dart';

part 'getworkoutplan_state.dart';

@injectable
class GetworkoutplanCubit extends Cubit<GetworkoutplanState> {
  final GetWorkoutPlansForClientUsecase getWorkoutPlansForClientUsecase;
  GetworkoutplanCubit(this.getWorkoutPlansForClientUsecase)
      : super(GetworkoutplanInitial());

  Future<void> getWorkoutPlanForClient(String clientId) async {
    emit(GetworkoutplanLoading());
    final result = await getWorkoutPlansForClientUsecase(
      Params(
        clientId: clientId,
      ),
    );
    if (result == null) {
      emit(
        GetworkoutplanError(
          failures: ServerFailure(
            message: "Something went wrong",
          ),
        ),
      );
    } else {
      result.fold(
        (l) {
          emit(GetworkoutplanError(failures: l));
        },
        (r) {
          emit(
            GetworkoutplanComplete(
              workoutPlan: r,
            ),
          );
        },
      );
    }
  }
}
