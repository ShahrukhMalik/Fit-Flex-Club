import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/get_gyms_usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/gym_entity.dart';
import 'package:injectable/injectable.dart';
part 'getgyms_state.dart';

@injectable
class GetGymsCubit extends Cubit<GetGymsState> {
  final GetGymsUsecase getGymsUsecase;
  GetGymsCubit(this.getGymsUsecase) : super(GetGymsInitial());

  Future<void> getGyms() async {
    // emit(GetGymsComplete(gyms: [])); // Optional: reset
    emit(GetGymsLoading());

    print(state);
    final result = await getGymsUsecase(NoParams());
    print(state);
    result?.fold(
      (l) {
        emit(GetGymsError(failure: l));
      },
      (r) {
        emit(GetGymsComplete(gyms: r ?? []));
      },
    );
  }
}
