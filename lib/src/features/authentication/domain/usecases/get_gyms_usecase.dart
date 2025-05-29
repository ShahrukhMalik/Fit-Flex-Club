import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/gym_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:injectable/injectable.dart';

abstract class GetGymsUsecase extends AuthUsecase
    implements UseCase<List<Gym>?, NoParams> {}

@Singleton(as: GetGymsUsecase)
class GetGymsUsecaseImpl extends GetGymsUsecase {
  final ClientProfileRepository clientProfileRepository;

  GetGymsUsecaseImpl({required this.clientProfileRepository});

  @override
  Future<Either<Failures, List<Gym>?>>? call(NoParams params) {
    return clientProfileRepository.getGyms();
  }
}
