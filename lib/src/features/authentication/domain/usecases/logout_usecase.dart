import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:injectable/injectable.dart';


///[Marker Interface] to let user logout
abstract class LogOutUsecase extends AuthUsecase
    implements UseCase<void, NoParams> {}


@Singleton(as: LogOutUsecase)
class LogOutUsecaseImpl extends LogOutUsecase {
  final AuthRepository authRepository;

  LogOutUsecaseImpl({required this.authRepository});

  @override
  Future<Either<Failures, void>>? call(NoParams params) {
    return authRepository.logOut();
  }
}
