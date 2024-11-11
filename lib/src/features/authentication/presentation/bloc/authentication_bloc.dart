import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/create_account_usecase.dart'
    as signup;
import 'package:fit_flex_club/src/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/login_usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:injectable/injectable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final signup.CreateAccountUsecase createAccountUsecase;
  final LogInUsecase logInUsecase;
  final LogOutUsecase logOutUsecase;
  final ForgotPasswordUsecase forgotPasswordUsecase;
  AuthenticationBloc({
    required this.createAccountUsecase,
    required this.logInUsecase,
    required this.logOutUsecase,
    required this.forgotPasswordUsecase,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is CreateAccountAuthenticationEvent) {
        await _createAccount(event: event, emit: emit);
      }
    });
  }
  Future<void> _createAccount({
    required CreateAccountAuthenticationEvent event,
    required Emitter<AuthenticationState> emit,
  }) async {
    emit(AuthenticationLoading());
    await Future.delayed(Duration(seconds: 2), () {
      emit(AuthenticationComplete());
    });
    // final result = await createAccountUsecase(
    //   signup.Params(
    //     email: event.email,
    //     password: event.password,
    //   ),
    // );

    // if (result == null) {
    //   emit(
    //     AuthenticationError(
    //       failures: ServerFailure(
    //         message: "Something went wrong!",
    //       ),
    //     ),
    //   );
    // } else {
    //   result.fold(
    //     (l) => emit(AuthenticationError(failures: l)),
    //     (r) {
    //       if (r == null) {
    //         emit(
    //           AuthenticationError(
    //             failures: ServerFailure(
    //               message: "No UID found",
    //             ),
    //           ),
    //         );
    //       } else {
    //         emit(
    //           AuthenticationComplete(
    //             authId: r.uid,
    //             isSignedUp: true,
    //           ),
    //         );
    //       }
    //     },
    //   );
    // }
  }
}
