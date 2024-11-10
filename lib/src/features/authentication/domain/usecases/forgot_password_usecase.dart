import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';

///[Marker Interface] to let user recieve password reset link
abstract class ForgotPasswordUsecase extends AuthUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final String email;

  const Params({
    required this.email,
  });

  @override
  List<Object?> get props => [
        email,
      ];
}

class ForgotPasswordUsecaseImpl extends ForgotPasswordUsecase {
  final AuthRepository authRepository;

  ForgotPasswordUsecaseImpl({required this.authRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return authRepository.forgotPassword(params.email);
  }
}
