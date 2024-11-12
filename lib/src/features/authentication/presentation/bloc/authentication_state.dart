part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final bool? rebuild;
  const AuthenticationState(this.rebuild);

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial(super.rebuild);
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading(super.rebuild);
  @override
  List<Object?> get props => [rebuild];
}

class AuthenticationComplete extends AuthenticationState {
  final AuthEntity? entity;

  const AuthenticationComplete(super.rebuild, this.entity);

  @override
  List<Object?> get props => [entity, rebuild];
}

class AuthenticationError extends AuthenticationState {
  final Failures failures;

  const AuthenticationError(super.rebuild, this.failures);
  

  @override
  List<Object?> get props => [failures, rebuild];
}
