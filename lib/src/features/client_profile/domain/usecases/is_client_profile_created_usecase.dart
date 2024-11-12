import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/client_profile_usecase.dart';

///[Marker Interface] to let user IsClientProfileCreated 
abstract class IsClientProfileCreatedActiveUsecase extends ClientProfileUsecase
    implements UseCase<bool, NoParams> {}


@Singleton(as: IsClientProfileCreatedActiveUsecase)
class IsClientProfileCreatedActiveUsecaseImpl
    extends IsClientProfileCreatedActiveUsecase {
  final ClientProfileRepository clientProfileRepository;

  IsClientProfileCreatedActiveUsecaseImpl(
      {required this.clientProfileRepository});

  @override
  Future<Either<Failures, bool>>? call(NoParams params) {
    return clientProfileRepository.isClientProfileCreated();
  }
}
