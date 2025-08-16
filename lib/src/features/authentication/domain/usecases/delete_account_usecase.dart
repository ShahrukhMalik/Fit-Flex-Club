import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user CreateAccount with email and password
abstract class DeleteAccountUsecase extends AuthUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final String? password;

  const Params({
     this.password,
  });

  @override
  List<Object?> get props => [

        password,
      ];
}

@Singleton(as: DeleteAccountUsecase)
class DeleteAccountUsecaseImpl extends DeleteAccountUsecase {
  final AuthRepository authRepository;

  DeleteAccountUsecaseImpl({required this.authRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return authRepository.deleteAccount(
      password: params.password,
    );
  }
}
