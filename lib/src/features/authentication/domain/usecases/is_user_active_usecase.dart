import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/client_profile_usecase.dart';

///[Marker Interface] to let user IsUserActive
abstract class IsUserActiveUsecase extends AuthUsecase
    implements UseCase<bool?, NoParams> {}

@Singleton(as: IsUserActiveUsecase)
class IsUserActiveUsecaseImpl extends IsUserActiveUsecase {
  final AuthRepository clientProfileRepository;

  IsUserActiveUsecaseImpl({required this.clientProfileRepository});

  @override
  Future<Either<Failures, bool?>>? call(NoParams params) {
    return clientProfileRepository.isUserActive();
  }
}
