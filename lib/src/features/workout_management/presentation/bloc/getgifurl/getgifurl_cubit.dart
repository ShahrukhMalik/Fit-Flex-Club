import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/api/api_service.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_gif_model.dart';
import 'package:injectable/injectable.dart';

part 'getgifurl_state.dart';

@injectable
class GetgifurlCubit extends Cubit<GetgifurlState> {
  GetgifurlCubit() : super(GetgifurlInitial());

  Future<void> getExerciseGif(String exerciseCode) async {
    emit(GetgifurlLoading());
    try {
      final ExerciseGifModel exerciseGifModel =
          await ApiService.fetchGifUrl(exerciseCode);
      emit(
        GetgifurlComplete(
          exerciseGifModel: exerciseGifModel,
        ),
      );
    } on ServerException catch (err) {
      emit(
        GetgifurlError(
          failures: ServerFailure(
            message: err.errorMessage,
          ),
        ),
      );
    }
  }
}
