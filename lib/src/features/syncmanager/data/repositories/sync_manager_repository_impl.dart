import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/remote/sync_manager_remote_datasource.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SyncManagerRepository)
class SyncManagerRepositoryImpl extends SyncManagerRepository {
  final SyncManagerRemoteDatasource remoteDatasource;

  SyncManagerRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failures, Stream<ListenerEvents>>> eventsListener() {
    // TODO: implement eventsListener
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, Stream<bool>>> isOnline() async {
    try {
      return Right(await remoteDatasource.isOnline());
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
  Future<Either<Failures, void>> logEventListened() {
    // TODO: implement logEventListened
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> syncData() {
    // TODO: implement syncData
    throw UnimplementedError();
  }
}
