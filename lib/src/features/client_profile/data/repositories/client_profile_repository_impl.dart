import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/client_profile_remote_datasource.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/repositories/client_profile_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ClientProfileRepository)
class ClientProfileRepositoryImpl implements ClientProfileRepository {
  final NetworkInfo networkInfo;
  final ClientProfileRemoteDatasource clientProfileRemoteDatasource;

  ClientProfileRepositoryImpl({
    required this.networkInfo,
    required this.clientProfileRemoteDatasource,
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
}
