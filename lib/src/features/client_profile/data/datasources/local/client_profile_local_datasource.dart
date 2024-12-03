import 'package:dartz/dartz.dart';
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
  Future<void> insertClients(List<ClientModel> clients);
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
}
