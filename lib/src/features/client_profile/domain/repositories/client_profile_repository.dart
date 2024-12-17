import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';

///[Marker Interface] abstraction of client profile repository
abstract class ClientProfileRepository {
  ///Add new user
  Future<Either<Failures, void>>? addNewUser({
    required ClientEntity clientEntity,
  });

  ///Update existing user
  Future<Either<Failures, void>>? updateUser({
    required ClientEntity clientEntity,
  });

  ///Check if client is active
  Future<Either<Failures, bool?>>? isUserActive();

  ///Get clients list for trainer
  Future<Either<Failures, List<ClientEntity>?>>? getClients();

  ///Get client details
  Future<Either<Failures, ClientEntity?>>? getClientById([String? id]);

  /// Check if client profile is created
  Future<Either<Failures, bool>> isClientProfileCreated();
}
