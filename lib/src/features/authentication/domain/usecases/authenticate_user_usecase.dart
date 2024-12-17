import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user AuthenticateUser with email and password
abstract class AuthenticateUserUsecase extends AuthUsecase
    implements UseCase<AuthEntity?, NoParams> {}

@Singleton(as: AuthenticateUserUsecase)
class AuthenticateUserUsecaseImpl extends AuthenticateUserUsecase {
  final AuthRepository authRepository;

  AuthenticateUserUsecaseImpl({required this.authRepository});

  @override
  Future<Either<Failures, AuthEntity?>>? call(NoParams params) {
    return authRepository.authenticateUser();
  }
}
