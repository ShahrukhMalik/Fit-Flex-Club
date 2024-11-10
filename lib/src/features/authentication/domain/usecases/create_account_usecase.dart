import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user CreateAccount with email and password
abstract class CreateAccountUsecase extends AuthUsecase
    implements UseCase<AuthEntity?, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final String email;
  final String password;

  const Params({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

@Singleton(as: CreateAccountUsecase)
class CreateAccountUsecaseImpl extends CreateAccountUsecase {
  final AuthRepository authRepository;

  CreateAccountUsecaseImpl({required this.authRepository});

  @override
  Future<Either<Failures, AuthEntity?>>? call(Params params) {
    return authRepository.signup(
      email: params.email,
      password: params.password,
    );
  }
}
