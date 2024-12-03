import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/client_profile_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user GetClientsUsecase
abstract class GetClientsUsecaseUsecase extends ClientProfileUsecase
    implements UseCase<List<ClientEntity>?, NoParams> {}

@Singleton(as: GetClientsUsecaseUsecase)
class GetClientsUsecaseUsecaseImpl extends GetClientsUsecaseUsecase {
  final ClientProfileRepository clientProfileRepository;

  GetClientsUsecaseUsecaseImpl({required this.clientProfileRepository});

  @override
  Future<Either<Failures, List<ClientEntity>?>>? call(NoParams noParams) {
    return clientProfileRepository.getClients();
  }
}
