import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';

///[Marker Interface] to let user IsClientProfileCreated 
abstract class IsClientProfileCreatedActiveUsecase extends AuthUsecase
    implements UseCase<bool?, NoParams> {}


@Singleton(as: IsClientProfileCreatedActiveUsecase)
class IsClientProfileCreatedActiveUsecaseImpl
    extends IsClientProfileCreatedActiveUsecase {
  final AuthRepository clientProfileRepository;

  IsClientProfileCreatedActiveUsecaseImpl(
      {required this.clientProfileRepository});

  @override
  Future<Either<Failures, bool?>>? call(NoParams params) {
    return clientProfileRepository.isProfileCreated();
  }
}
