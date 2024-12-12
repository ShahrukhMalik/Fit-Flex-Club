import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/client_profile_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class GetClientByIdUsecase extends ClientProfileUsecase
    implements UseCase<ClientEntity?, Params?> {}

class Params extends Equatable {
  final String clientId;

  const Params({required this.clientId});
  @override
  // TODO: implement props
  List<Object?> get props => [clientId];
}

@Singleton(as: GetClientByIdUsecase)
class GetClientByIdUsecaseImpl extends GetClientByIdUsecase {
  final ClientProfileRepository clientProfileRepository;

  GetClientByIdUsecaseImpl({required this.clientProfileRepository});

  @override
  Future<Either<Failures, ClientEntity?>>? call([Params? params]) {
    return clientProfileRepository.getClientById(params?.clientId);
  }
}
