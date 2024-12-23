import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/client_profile_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user AddClientWeight
abstract class AddClientWeightUsecase extends ClientProfileUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final ClientWeightEntity weight;

  const Params({required this.weight});

  @override
  List<Object?> get props => [
        weight,
      ];
}

@Singleton(as: AddClientWeightUsecase)
class AddClientWeightUsecaseImpl extends AddClientWeightUsecase {
  final ClientProfileRepository clientProfileRepository;

  AddClientWeightUsecaseImpl({required this.clientProfileRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return clientProfileRepository.addClientWeight(
      params.weight,
    );
  }
}
