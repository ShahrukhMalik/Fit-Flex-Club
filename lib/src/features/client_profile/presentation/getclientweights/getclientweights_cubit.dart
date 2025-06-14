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

  Future<void> getClientWeights(String? clientId) async {
    print('Request reached a cubit : '
        "${DateTime.now().millisecondsSinceEpoch}");
    emit(GetclientweightsLoading());
    final result = await getClientWeightsUsecase(
      Params(
        clientId: clientId,
      ),
    );
    print('Response from a repo and usecase : '
        "${DateTime.now().millisecondsSinceEpoch}");
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
            print('Before emitting complete state : '
                "${DateTime.now().millisecondsSinceEpoch}");
            
            emit(
              GetclientweightsComplete(
                weights: r,
              ),
            );
          }
        },
      );
    }
  }
}
