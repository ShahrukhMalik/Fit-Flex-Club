import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/authenticate_user_usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/create_account_usecase.dart'
    as signup;
import 'package:fit_flex_club/src/features/authentication/domain/usecases/forgot_password_usecase.dart'
    as forgot;
import 'package:fit_flex_club/src/features/authentication/domain/usecases/listen_to_events_usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/login_usecase.dart'
    as login;
import 'package:fit_flex_club/src/features/authentication/domain/usecases/logout_usecase.dart'
    as logout;
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';
import 'package:injectable/injectable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final signup.CreateAccountUsecase createAccountUsecase;
  final login.LogInUsecase logInUsecase;
  final logout.LogOutUsecase logOutUsecase;
  final AuthenticateUserUsecase authenticateUserUsecase;
  final ListenToEventsUsecase listenToEventsUsecase;
  // final client.IsClientProfileCreatedActiveUsecase
  //     isClientProfileCreatedActiveUsecase;
  // final userActive.IsUserActiveUsecase isUserActiveUsecase;
  final forgot.ForgotPasswordUsecase forgotPasswordUsecase;
  AuthenticationBloc({
    // required this.isClientProfileCreatedActiveUsecase,
    // required this.isUserActiveUsecase,
    required this.authenticateUserUsecase,
    required this.createAccountUsecase,
    required this.logInUsecase,
    required this.logOutUsecase,
    required this.forgotPasswordUsecase,
    required this.listenToEventsUsecase,
  }) : super(AuthenticationInitial(false)) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is CreateAccountAuthenticationEvent) {
        await _createAccount(event: event, emit: emit);
      }
      if (event is LogInAuthenticationEvent) {
        await _logIn(event: event, emit: emit);
      }
      if (event is LogOutAuthenticationEvent) {
        await _logOut(event: event, emit: emit);
      }

      if (event is AuthenticateUserEvent) {
        await _authenticateUser(event: event, emit: emit);
      }

      if (event is ForgotPasswordAuthenticationEvent) {
        await _forgotPassword(event: event, emit: emit);
      }
      if (event is ListenToEvents) {
        await _listenToEvents(event: event, emit: emit);
      }
      // if (event is UpdateUserEvent) {
      //   await _updateUser(event: event, emit: emit);
      // }
    });
  }

  Future<void> _forgotPassword({
    required ForgotPasswordAuthenticationEvent event,
    required Emitter<AuthenticationState> emit,
  }) async {
    emit(AuthenticationLoading(false));
    final result =
        await forgotPasswordUsecase(forgot.Params(email: event.email));
    if (result == null) {
      emit(
        AuthenticationError(
          true,
          ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthenticationError(false, l)),
        (r) => emit(AuthenticationComplete(false, AuthEntity(mailSent: true))),
      );
    }
  }

  Future<void> _authenticateUser({
    required AuthenticateUserEvent event,
    required Emitter<AuthenticationState> emit,
  }) async {
    emit(AuthenticationLoading(false));
    final result = await authenticateUserUsecase(NoParams());
    if (result == null) {
      emit(
        AuthenticationError(
          true,
          ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthenticationError(false, l)),
        (r) => emit(AuthenticationComplete(true, r)),
      );
    }
  }

  // Future<void> _userActive(
  //   CheckIfUserActive event,
  //   Emitter<AuthenticationState> emit,
  // ) async {
  //   emit(AuthenticationLoading());
  //   final result = await isUserActiveUsecase(NoParams());
  //   if (result == null) {
  //     emit(
  //       AuthenticationError(
  //         failures: ServerFailure(
  //           message: "Something went wrong!",
  //         ),
  //       ),
  //     );
  //   } else {
  //     result.fold(
  //       (l) => emit(AuthenticationError(failures: l)),
  //       (r) async {
  //         if (r == null) {
  //         } else {
  //           emit(
  //             AuthenticationComplete(
  //                 // isUserActive: r,
  //                 ),
  //           );
  //         }
  //       },
  //     );
  //   }
  // }

  Future<void> _createAccount({
    required CreateAccountAuthenticationEvent event,
    required Emitter<AuthenticationState> emit,
  }) async {
    emit(AuthenticationLoading(false));
    final result = await createAccountUsecase(
      signup.Params(
        email: event.email,
        password: event.password,
      ),
    );

    if (result == null) {
      emit(
        AuthenticationError(
          false,
          ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthenticationError(false, l)),
        (r) {
          if (r == null) {
            emit(
              AuthenticationError(
                false,
                ServerFailure(
                  message: "No UID found",
                ),
              ),
            );
          } else {
            emit(
              AuthenticationComplete(false, AuthEntity(isSignedUp: true)),
            );
          }
        },
      );
    }
  }

  Future<void> _logIn({
    required LogInAuthenticationEvent event,
    required Emitter<AuthenticationState> emit,
  }) async {
    emit(AuthenticationLoading(false));
    final result = await logInUsecase(
      login.Params(
        email: event.email,
        password: event.password,
      ),
    );

    if (result == null) {
      emit(
        AuthenticationError(
          false,
          ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthenticationError(false, l)),
        (r) {
          emit(
            AuthenticationComplete(
              false,
              AuthEntity(isLoggedIn: true),
            ),
          );
        },
      );
    }
  }

  Future<void> _logOut({
    required LogOutAuthenticationEvent event,
    required Emitter<AuthenticationState> emit,
  }) async {
    emit(AuthenticationLoading(true));
    final result = await logOutUsecase(NoParams());

    if (result == null) {
      emit(
        AuthenticationError(
          true,
          ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthenticationError(true, l)),
        (r) {
          emit(
            AuthenticationComplete(
              true,
              AuthEntity(isLoggedIn: false),
            ),
          );
        },
      );
    }
  }

  _listenToEvents({
    required ListenToEvents event,
    required Emitter<AuthenticationState> emit,
  }) async {
    emit(AuthenticationLoading(true));
    final result = await listenToEventsUsecase(NoParams());

    if (result == null) {
      emit(
        AuthenticationError(
          true,
          ServerFailure(
            message: "Something went wrong!",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthenticationError(true, l)),
        (r) {
          r?.listen(
            (event) async {
              try {
                if (event != null) {
                  final remotedb = getIt<FirebaseFirestore>();
                  final localDb = getIt<AppDatabase>();
                  final clientId = getIt<FirebaseAuth>().currentUser?.uid;
                  final listenRefCollection =
                      remotedb.collection('ListenerEvents');

                  final listenDocRef = await listenRefCollection
                      .where('clientId', isEqualTo: clientId)
                      .orderBy('timestamp', descending: true)
                      .get();
                  final listenDocs = listenDocRef.docs;

                  if (listenDocs.isNotEmpty) {
                    final listenDoc = listenDocs.first.reference;
                    if (listenDocs.first.data()['isListendAlready'] ??
                        false) {
                      add(AuthenticateUserEvent());
                    } else {
                      await listenDoc.set(
                        {
                          'isListendAlready': true,
                        },
                        SetOptions(
                          merge: true,
                        ),
                      );
                      localDb.deleteAllTables();
                      add(AuthenticateUserEvent());
                    }
                  } else {
                    add(AuthenticateUserEvent());
                  }
                } else {
                  add(AuthenticateUserEvent());
                }
              } catch (err) {
                print(err);
              }
            },
          );
        },
      );
    }
  }

  _updateUser({
    required UpdateUserEvent event,
    required Emitter<AuthenticationState> emit,
  }) async {
    emit(AuthenticationLoading(true));
    await Future.delayed(
      Duration(milliseconds: 300),
      () {
        emit(ListenEventComplete(event.event));
      },
    );
  }
}
