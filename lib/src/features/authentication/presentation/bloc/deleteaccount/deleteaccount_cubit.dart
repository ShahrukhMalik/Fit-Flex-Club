import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/delete_account_usecase.dart';
import 'package:injectable/injectable.dart';

part 'deleteaccount_state.dart';

@injectable
class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this.deleteAccountUsecase) : super(DeleteAccountInitial());

  final DeleteAccountUsecase deleteAccountUsecase;

  Future<void> deleteAccount({String? password}) async {
    emit(DeleteAccountLoading());
    final result = await deleteAccountUsecase(Params(password: password));
    result?.fold(
      (l) {
        emit(DeleteAccountError(failure: l));
      },
      (r) {
        emit(DeleteAccountComplete());
      },
    );
  }
}
