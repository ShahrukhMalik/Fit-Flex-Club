import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/functions/is_data_stale.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/daos/client_dao.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:injectable/injectable.dart';

abstract class ClientLocalDatasource {
  ///
  Future<Either<bool, List<ClientModel>?>> getClients();

  ///
  Future<Either<bool, ClientModel?>> getClientById([String? id]);

  ///
  Future<void> insertClients(List<ClientModel> clients);

  ///
  Future<void> insertClient(ClientModel client);
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
    try {
      final clients = await dao.getAllClients();

      if (clients.isEmpty) {
        return Left(false);
      }

      if (isDataStale(
        Duration(minutes: 5).inSeconds,
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
  Future<Either<bool, ClientModel?>> getClientById([String? id]) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      if (clientId != null) {
        final client = await dao.getClientByid(clientId);

        if (client == null) {
          return Left(false);
        }

        if (isDataStale(
          Duration(days: 1).inSeconds,
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
}
