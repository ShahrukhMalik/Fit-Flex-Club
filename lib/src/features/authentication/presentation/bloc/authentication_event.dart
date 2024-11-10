part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class CreateAccountAuthenticationEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const CreateAccountAuthenticationEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LogInAuthenticationEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LogInAuthenticationEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class ForgotPasswordAuthenticationEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const ForgotPasswordAuthenticationEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LogOutAuthenticationEvent extends AuthenticationEvent {}
