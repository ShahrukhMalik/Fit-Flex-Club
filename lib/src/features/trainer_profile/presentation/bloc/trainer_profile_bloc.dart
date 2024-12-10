import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/trainer_profile/domain/usecases/get_clients_usecase.dart';
import 'package:injectable/injectable.dart';

part 'trainer_profile_event.dart';
part 'trainer_profile_state.dart';

@injectable
class TrainerProfileBloc
    extends Bloc<TrainerProfileEvent, TrainerProfileState> {
  final GetClientsUsecaseUsecase getClientsUsecaseUsecase;
  TrainerProfileBloc(this.getClientsUsecaseUsecase)
      : super(TrainerProfileInitial()) {
    on<TrainerProfileEvent>((event, emit) async {
      if (event is TrainerProfileGetClientsEvent) {
        await _getClients(event, emit);
      }
    });
  }

  Future<void> _getClients(
    TrainerProfileGetClientsEvent event,
    Emitter<TrainerProfileState> emit,
  ) async {
    emit(TrainerProfileLoading());
    final result = await getClientsUsecaseUsecase(NoParams());

    if (result == null) {
      emit(
        TrainerProfileError(
          failures: ServerFailure(message: "Something Went Wrong!"),
        ),
      );
    } else {
      result.fold(
        (l) {
          emit(
            TrainerProfileError(
              failures: l,
            ),
          );
        },
        (r) {
          if (r == null) {
            emit(
              TrainerProfileError(
                failures: ServerFailure(
                  message: "No Clients found",
                ),
              ),
            );
          } else {
            emit(TrainerProfileComplete(entities: r));
          }
        },
      );
    }
  }
}
