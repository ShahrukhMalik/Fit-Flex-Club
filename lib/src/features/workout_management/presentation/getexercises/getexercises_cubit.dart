import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/get_exercises_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'getexercises_state.dart';

@injectable
class GetexercisesCubit extends Cubit<GetexercisesState> {
  final GetExercisesUsecase getExercisesUsecase;
  GetexercisesCubit(this.getExercisesUsecase) : super(GetexercisesInitial());

  Future<void> getExercises() async {
    if (kDebugMode) {
      print("Request reached cubit : ${DateTime.now().millisecondsSinceEpoch}");
    }
    emit(GetexercisesLoading());
    final result = await getExercisesUsecase(NoParams());
    if (kDebugMode) {
      print("Response from usecase : ${DateTime.now().millisecondsSinceEpoch}");
    }

    if (result == null) {
      emit(
        GetexercisesError(
          failures: ServerFailure(
            message: "Something went wrong",
          ),
        ),
      );
    } else {
      result.fold(
        (l) {
          emit(GetexercisesError(failures: l));
        },
        (r) {
          if (r == null) {
            emit(
              GetexercisesError(
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
