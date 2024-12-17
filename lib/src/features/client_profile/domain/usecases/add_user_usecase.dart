import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/client_profile_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user AddUser
abstract class AddUserUsecase extends ClientProfileUsecase
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

@Singleton(as: AddUserUsecase)
class AddUserUsecaseImpl extends AddUserUsecase {
  final ClientProfileRepository clientProfileRepository;

  AddUserUsecaseImpl({required this.clientProfileRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return clientProfileRepository.addNewUser(
      clientEntity: params.clientEntity,
    );
  }
}
