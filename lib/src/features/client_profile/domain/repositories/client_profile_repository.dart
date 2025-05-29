import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/gym_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/trainer_entity.dart';

///[Marker Interface] abstraction of client profile repository
abstract class ClientProfileRepository {
  ///Add new user
  Future<Either<Failures, void>> addNewUser({
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


  ///
  Future<Either<Failures, void>> mapClientToTrainer({
    required Gym gym,
    required Trainer trainer,
    required ClientEntity client,
  });

  ///Get clients list for trainer
  Future<Either<Failures, List<Gym>?>>? getGyms();

  ///Get clients weights
  Future<Either<Failures, List<ClientWeightEntity>?>>? getClientWeights(
      [String? clientId]);

  ///Add clients weights
  Future<Either<Failures, void>>? addClientWeight(ClientWeightEntity weight);

  ///Get client details
  Future<Either<Failures, ClientEntity?>>? getClientById([String? id]);

  /// Check if client profile is created
  Future<Either<Failures, bool>> isClientProfileCreated();
}
