import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/client_profile_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class GetClientWeightsUsecase extends ClientProfileUsecase
    implements UseCase<List<ClientWeightEntity>?, Params?> {}

class Params extends Equatable {
  final String clientId;

  const Params({required this.clientId});
  @override
  // TODO: implement props
  List<Object?> get props => [clientId];
}

@Singleton(as: GetClientWeightsUsecase)
class GetClientWeightsUsecaseImpl extends GetClientWeightsUsecase {
  final ClientProfileRepository clientProfileRepository;

  GetClientWeightsUsecaseImpl({required this.clientProfileRepository});

  @override
  Future<Either<Failures, List<ClientWeightEntity>?>>? call([Params? params]) {
    print('Request reached a usecase : '
        "${DateTime.now().millisecondsSinceEpoch}");
    return clientProfileRepository.getClientWeights(params?.clientId);
  }
}
