part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationComplete extends AuthenticationState {
  final String? authId;
  final bool? isSignedUp;
  final bool? isLoggedIn;
  final bool? isLoggedOut;
  final bool? isChangePasswordMailSent;

  const AuthenticationComplete({
    this.authId,
    this.isSignedUp,
    this.isLoggedIn,
    this.isLoggedOut,
    this.isChangePasswordMailSent,
  });

  @override
  List<Object?> get props =>
      [isSignedUp, isLoggedIn, isChangePasswordMailSent, authId, isLoggedOut];
}

class AuthenticationError extends AuthenticationState {
  final Failures failures;

  const AuthenticationError({required this.failures});

  @override
  List<Object?> get props => [failures];
}
