import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/add_user_usecase.dart'
    as addUser;
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/get_client_by_id_usecase.dart'
    as get_client_by_id;
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/is_client_profile_created_usecase.dart'
    as client;
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/is_user_active_usecase.dart'
    as userActive;
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/update_user_usecase.dart'
    as updateUser;
import 'package:injectable/injectable.dart';

part 'client_profile_event.dart';
part 'client_profile_state.dart';

@injectable
class ClientProfileBloc extends Bloc<ClientProfileEvent, ClientProfileState> {
  final addUser.AddUserUsecase addUserUsecase;
  final updateUser.UpdateUserUsecase updateUserUsecase;
  final client.IsClientProfileCreatedActiveUsecase
      isClientProfileCreatedActiveUsecase;
  final userActive.IsUserActiveUsecase isUserActiveUsecase;

  final get_client_by_id.GetClientByIdUsecase getClientByIdUsecase;
  ClientProfileBloc(
    this.addUserUsecase,
    this.updateUserUsecase,
    this.isClientProfileCreatedActiveUsecase,
    this.isUserActiveUsecase,
    this.getClientByIdUsecase,
  ) : super(ClientProfileInitial()) {
    on<ClientProfileEvent>((event, emit) async {
      if (event is AddUserClientProfileEvent) {
        await _addUser(event, emit);
      }
      if (event is UpdateUserClientProfileEvent) {
        await _updateUser(event, emit);
      }
      if (event is GetClientByIdEvent) {
        await _getClientDetails(event, emit);
      }
    });
  }

  Future<void> _addUser(
    AddUserClientProfileEvent event,
    Emitter<ClientProfileState> emit,
  ) async {
    emit(ClientProfileLoading());
    final result = await addUserUsecase(
      addUser.Params(
        clientEntity: event.clientEntity,
      ),
    );
    if (result == null) {
      emit(
        ClientProfileError(
          failures: ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(ClientProfileError(failures: l)),
        (r) => emit(ClientProfileComplete()),
      );
    }
  }

  Future<void> _updateUser(
    UpdateUserClientProfileEvent event,
    Emitter<ClientProfileState> emit,
  ) async {
    emit(ClientProfileLoading());
    final result = await updateUserUsecase(
      updateUser.Params(
        clientEntity: event.clientEntity,
      ),
    );
    if (result == null) {
      emit(
        ClientProfileError(
          failures: ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(ClientProfileError(failures: l)),
        (r) => emit(ClientProfileComplete()),
      );
    }
  }

  Future<void> _getClientDetails(
    GetClientByIdEvent event,
    Emitter<ClientProfileState> emit,
  ) async {
    emit(ClientProfileLoading());
    final result = await getClientByIdUsecase(null);
    if (result == null) {
      emit(
        ClientProfileError(
          failures: ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(ClientProfileError(failures: l)),
        (r) {
          if (r == null) {
            emit(
              ClientProfileError(
                failures: ServerFailure(
                  message: "Something went wrong!",
                ),
              ),
            );
          } else {
            emit(GetProfileComplete(entity: r));
          }
        },
      );
    }
  }
}
