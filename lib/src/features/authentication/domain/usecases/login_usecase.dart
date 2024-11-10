import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user login with email and password
abstract class LogInUsecase extends AuthUsecase
    implements UseCase<void, Params> {}

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

@Singleton(as: LogInUsecase)
class LogInUsecaseImpl extends LogInUsecase {
  final AuthRepository authRepository;

  LogInUsecaseImpl({required this.authRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return authRepository.logIn(
      email: params.email,
      password: params.password,
    );
  }
}
