import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/client_profile_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user UpdateUser with details
abstract class UpdateUserUsecase extends ClientProfileUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final ClientEntity clientEntity;

  const Params({required this.clientEntity});

  @override
  List<Object?> get props => [
        clientEntity,
      ];
}

@Singleton(as: UpdateUserUsecase)
class UpdateUserUsecaseImpl extends UpdateUserUsecase {
  final ClientProfileRepository clientProfileRepository;

  UpdateUserUsecaseImpl({required this.clientProfileRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return clientProfileRepository.updateUser(
      clientEntity: params.clientEntity,
    );
  }
}
