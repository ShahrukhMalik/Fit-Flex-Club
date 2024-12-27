import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/functions/is_data_stale.dart';
import 'package:fit_flex_club/src/features/client_management/data/models/client_weight_model.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/daos/client_dao.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:injectable/injectable.dart';

abstract class ClientLocalDatasource {
  ///
  Future<Either<bool, List<ClientModel>?>> getClients();

  ///
  Future<Either<bool, ClientModel?>> getClientById([String? id]);

  ///
  Future<Either<bool, List<ClientWeightEntity>?>> getClientWeights(
      [String? id]);

  ///
  Future<void> insertClients(List<ClientModel> clients);

  ///
  Future<void> insertClient(ClientModel client);

  ///
  Future<void> insertClientWeights(List<ClientWeightEntity> clientWeights);

  ///
  Future<void> insertClientWeight(ClientWeightModel clientWeight);
}

@Singleton(as: ClientLocalDatasource)
class ClientLocalDatasourceImpl extends ClientLocalDatasource {
  final ClientsDao dao;
  final AppDatabase database;

  ClientLocalDatasourceImpl({
    required this.dao,
    required this.database,
  });
  @override
  Future<Either<bool, List<ClientModel>?>> getClients() async {
    print("Request reached local db: "
        '${DateTime.now().millisecondsSinceEpoch}');
    try {
      final clients = await dao.getAllClients();
      print("Response from local dao method: "
          '${DateTime.now().millisecondsSinceEpoch}');

      if (clients.isEmpty) {
        return Left(false);
      }

      if (isDataStale(
        Duration(minutes: 30).inSeconds,
        clients.first.createdAt,
        clients.first.updatedAt,
      )) {
        await database.deleteClients();
        return Left(true);
      }
      return Right(
        clients
            .map(
              (e) => ClientModel.fromMap(
                e.toJson(),
              ),
            )
            .toList(),
      );
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertClients(List<ClientModel> clients) async {
    try {
      final result = await dao.insertClients(clients);
      return Future.value(null);
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertClientWeights(
      List<ClientWeightEntity> clientWeights) async {
    try {
      return Future(
        () async => await dao.insertClientWeightsBatch(clientWeights),
      );
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<Either<bool, ClientModel?>> getClientById([String? id]) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      if (clientId != null) {
        final client = await dao.getClientByid(clientId);

        if (client == null) {
          return Left(false);
        }

        if (isDataStale(
          Duration(seconds: 1).inSeconds,
          client.createdAt,
          client.updatedAt,
        )) {
          await database.deleteClients();
          return Left(true);
        }
        return Right(
          ClientModel.fromMap(
            client.toJson(),
          ),
        );
      } else {
        throw CacheException(
          errorMessage: "No Auth ID found.",
        );
      }
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertClient(ClientModel client) async {
    try {
      return Future(() async => await dao.insertClient(client));
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<Either<bool, List<ClientWeightEntity>?>> getClientWeights(
      [String? id]) async {
    try {
      print('Request reached a local db : '
          "${DateTime.now().millisecondsSinceEpoch}");
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      if (clientId != null) {
        final clientWeights = await dao.getClientWeights(clientId);
        print('Response from a dao method : '
            "${DateTime.now().millisecondsSinceEpoch}");
        if (clientWeights.isEmpty) {
          return Left(false);
        }

        if (isDataStale(
          Duration(days: 1).inSeconds,
          clientWeights.first.createdAt,
          clientWeights.first.updatedAt,
        )) {
          await database.deleteClientWeights();
          return Left(true);
        }

        final clientWeightModels = clientWeights
            .map(
              (e) => ClientWeightModel.fromRow(e),
            )
            .toList();
        return Right(clientWeightModels);
      } else {
        throw CacheException(
          errorMessage: "No Auth ID found.",
        );
      }
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }

  @override
  Future<void> insertClientWeight(ClientWeightModel clientWeight) async {
    try {
      return Future(() async => await dao.insertClientWeight(clientWeight));
    } catch (err) {
      throw CacheException(
        errorMessage: err.toString(),
      );
    }
  }
}
