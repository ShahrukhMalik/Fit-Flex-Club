import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/get_client_weights_usecase.dart';
import 'package:injectable/injectable.dart';

part 'getclientweights_state.dart';

@injectable
class GetclientweightsCubit extends Cubit<GetclientweightsState> {
  final GetClientWeightsUsecase getClientWeightsUsecase;
  GetclientweightsCubit(this.getClientWeightsUsecase)
      : super(GetclientweightsInitial());

  Future<void> getClientWeights() async {
    emit(GetclientweightsLoading());
    final result = await getClientWeightsUsecase(
      Params(
        clientId: getIt<FirebaseAuth>().currentUser!.uid,
      ),
    );

    if (result == null) {
      emit(
        GetclientweightsError(
          failures: ServerFailure(
            message: 'Something went wrong!',
          ),
        ),
      );
    } else {
      result.fold(
        (l) {
          emit(GetclientweightsError(failures: l));
        },
        (r) {
          if (r == null) {
            emit(
              GetclientweightsError(
                failures: ServerFailure(
                  message: 'Something went wrong!',
                ),
              ),
            );
          } else {
            emit(GetclientweightsComplete(weights: r));
          }
        },
      );
    }
  }
}
