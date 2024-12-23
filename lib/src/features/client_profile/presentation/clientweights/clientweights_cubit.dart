import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/add_client_weight_usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:injectable/injectable.dart';

part 'clientweights_state.dart';

@injectable
class ClientweightsCubit extends Cubit<ClientweightsState> {
  final AddClientWeightUsecase addClientWeightUsecase;
  ClientweightsCubit(this.addClientWeightUsecase)
      : super(ClientweightsInitial());

  Future<void> addClientWeight(ClientWeightEntity weight) async {
    emit(ClientweightsLoading());
    final result = await addClientWeightUsecase(
      Params(
        weight: weight,
      ),
    );

    if (result == null) {
      emit(
        ClientweightsError(
          failures: ServerFailure(
            message: 'Something went wrong!',
          ),
        ),
      );
    } else {
      result.fold(
        (l) {
          emit(ClientweightsError(failures: l));
        },
        (r) {
          emit(ClientweightsComplete());
        },
      );
    }
  }
}
