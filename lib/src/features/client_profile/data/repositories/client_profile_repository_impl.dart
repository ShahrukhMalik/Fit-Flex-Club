import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/features/client_management/data/models/client_weight_model.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/client_profile_local_datasource.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/remote/client_profile_remote_datasource.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/daos/sync_queue_dao.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ClientProfileRepository)
class ClientProfileRepositoryImpl implements ClientProfileRepository {
  final NetworkInfo networkInfo;
  final ClientProfileRemoteDatasource clientProfileRemoteDatasource;
  final ClientLocalDatasource clientProfileLocalDatasource;
  final SyncQueueDao syncQueueDao;

  ClientProfileRepositoryImpl(
    this.syncQueueDao, {
    required this.networkInfo,
    required this.clientProfileRemoteDatasource,
    required this.clientProfileLocalDatasource,
  });
  @override
  Future<Either<Failures, void>>? addNewUser({
    required ClientEntity clientEntity,
  }) async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected == null || !isNetworkConnected) {
      return const Left(
        NetworkFailure(message: 'No internet Connection'),
      );
    } else {
      try {
        return Right(
          clientProfileRemoteDatasource.addNewUser(
            clientModel: ClientModel.fromClientEntity(
              clientEntity,
            ),
          ),
        );
      } on ServerException catch (error) {
        return Left(
          ServerFailure(
            message: error.errorMessage,
            code: error.errorCode,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failures, void>>? updateUser({
    required ClientEntity clientEntity,
  }) async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected == null || !isNetworkConnected) {
      return const Left(
        NetworkFailure(message: 'No internet Connection'),
      );
    } else {
      try {
        return Right(
          clientProfileRemoteDatasource.updateUser(
            clientModel: ClientModel.fromClientEntity(
              clientEntity,
            ),
          ),
        );
      } on ServerException catch (error) {
        return Left(
          ServerFailure(
            message: error.errorMessage,
            code: error.errorCode,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failures, bool>> isClientProfileCreated() async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected == null || !isNetworkConnected) {
      return const Left(
        NetworkFailure(message: 'No internet Connection'),
      );
    } else {
      try {
        return Right(
          await clientProfileRemoteDatasource.isClientProfileCreated(),
        );
      } on ServerException catch (error) {
        return Left(
          ServerFailure(
            message: error.errorMessage,
            code: error.errorCode,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failures, bool?>>? isUserActive() async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected == null || !isNetworkConnected) {
      return const Left(
        NetworkFailure(message: 'No internet Connection'),
      );
    } else {
      try {
        return Right(
          await clientProfileRemoteDatasource.isUserActive(),
        );
      } on ServerException catch (error) {
        return Left(
          ServerFailure(
            message: error.errorMessage,
            code: error.errorCode,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failures, bool>>? isProfileCreated() {
    // TODO: implement isProfileCreated
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<ClientEntity>?>>? getClients() async {
    print("Request reached repo: " '${DateTime.now().millisecondsSinceEpoch}');
    print('Before checking internet connection: '
        '${DateTime.now().millisecondsSinceEpoch}');
    final isNetworkConnected = await networkInfo.isConnected;
    print('Before checking internet connection: '
        '${DateTime.now().millisecondsSinceEpoch}');
    try {
      final cache = await clientProfileLocalDatasource.getClients();
      print(
        "Response from local db: "
        '${DateTime.now().millisecondsSinceEpoch}',
      );

      return cache.fold(
        (l) async {
          if (isNetworkConnected == null || !isNetworkConnected) {
            return const Left(
              NetworkFailure(message: 'No internet Connection'),
            );
          } else {
            final remoteClients =
                await clientProfileRemoteDatasource.getClients();
            if (remoteClients != null && remoteClients.isNotEmpty) {
              await clientProfileLocalDatasource.insertClients(remoteClients);
            }
            return Right(
              remoteClients,
            );
          }
        },
        (r) {
          return Right(r);
        },
      );
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, ClientEntity?>>? getClientById([String? id]) async {
    final isNetworkConnected = await networkInfo.isConnected;

    try {
      final cache = await clientProfileLocalDatasource.getClientById();

      return cache.fold(
        (l) async {
          if (isNetworkConnected == null || !isNetworkConnected) {
            return const Left(
              NetworkFailure(message: 'No internet Connection'),
            );
          } else {
            final remoteClient =
                await clientProfileRemoteDatasource.getClientById();
            if (remoteClient != null) {
              await clientProfileLocalDatasource.insertClient(remoteClient);
            }
            return Right(
              remoteClient,
            );
          }
        },
        (r) {
          return Right(r);
        },
      );
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<ClientWeightEntity>?>>? getClientWeights([
    String? clientId,
  ]) async {
    print('Request reached a repo : '
        "${DateTime.now().millisecondsSinceEpoch}");
    final isNetworkConnected = await networkInfo.isConnected;

    try {
      final cache = await clientProfileLocalDatasource.getClientWeights();

      return cache.fold(
        (l) async {
          if (isNetworkConnected == null || !isNetworkConnected) {
            return const Left(
              NetworkFailure(message: 'No internet Connection'),
            );
          } else {
            final remoteClientWeights =
                await clientProfileRemoteDatasource.getClientWeights();
            if (remoteClientWeights != null && remoteClientWeights.isNotEmpty) {
              await clientProfileLocalDatasource
                  .insertClientWeights(remoteClientWeights);
            }
            return Right(
              remoteClientWeights,
            );
          }
        },
        (r) {
          return Right(r);
        },
      );
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, void>>? addClientWeight(
    ClientWeightEntity weight,
  ) async {
    try {
      final isNetworkConnected = await networkInfo.isConnected;
      final model = ClientWeightModel(
        timeStamp: weight.timeStamp,
        weightInKg: weight.weightInKg,
        weightInLb: weight.weightInLb,
        clientId: weight.clientId,
      );
      final cache = await clientProfileLocalDatasource.insertClientWeight(
        model,
      );
      if (isNetworkConnected == null || !isNetworkConnected) {
        return Right(
          await syncQueueDao.logSyncAction(
            ListenerEvents.addClientWeight.name,
            'Clients',
            model.toMap(),
          ),
        );
      } else {
        return Right(
          await clientProfileRemoteDatasource.addClientWeight(
            model,
          ),
        );
      }
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          message: error.errorMessage,
          code: error.errorCode,
        ),
      );
    }
  }
}
