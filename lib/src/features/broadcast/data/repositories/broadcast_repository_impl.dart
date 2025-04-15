// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/features/broadcast/data/datasources/broadcast_remote_datasource.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BroadcastRepository)
class BroadcastRepositoryImpl extends BroadcastRepository {
  final NetworkInfo networkInfo;
  final BroadcastRemoteDatasource broadcastRemoteDatasource;
  BroadcastRepositoryImpl({
    required this.networkInfo,
    required this.broadcastRemoteDatasource,
  });
  @override
  Future<Either<Failures, void>> sendNotification(
    NotificationEntity notification,
  ) async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected ?? false) {
      try {
        return Right(
          await broadcastRemoteDatasource.sendNotification(notification),
        );
      } on ServerException catch (error) {
        return Left(
          ServerFailure(
            message: error.errorMessage,
            code: error.errorCode,
          ),
        );
      }
    } else {
      return const Left(
        NetworkFailure(
          message: 'No Internet Connection',
        ),
      );
    }
  }
}
