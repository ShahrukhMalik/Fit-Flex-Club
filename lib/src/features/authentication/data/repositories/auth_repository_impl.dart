import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:fit_flex_club/src/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failures, Stream<bool>>>? checkWhetherUserIsLoggedIn() {
    // TODO: implement checkWhetherUserIsLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>>? forgotPassword(String email) async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.forgotPassword(
            AuthEntity(
              email: email,
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
    } else {
      return const Left(NetworkFailure(message: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<Failures, void>>? logIn({
    required String email,
    required String password,
  }) async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.logIn(
            authEntity: AuthEntity(
              email: email,
              password: password,
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
    } else {
      return const Left(NetworkFailure(message: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<Failures, void>>? logOut() async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.logOut(),
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
      return const Left(NetworkFailure(message: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<Failures, void>>? resetPassword(String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, AuthEntity?>>? signup({
    required String email,
    required String password,
  }) async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.signup(
            authEntity: AuthEntity(
              email: email,
              password: password,
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
    } else {
      return const Left(
        NetworkFailure(
          message: 'No Internet Connection',
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool?>>? isUserActive() async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.isUserActive(),
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

  @override
  Future<Either<Failures, bool?>>? isUserLogged() async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.isUserLogged(),
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

  @override
  Future<Either<Failures, bool?>>? isProfileCreated() async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.isProfileCreated(),
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

  @override
  Future<Either<Failures, AuthEntity?>>? authenticateUser() async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.authenticateUser(),
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

  @override
  Future<Either<Failures, Stream<Map<String,dynamic>?>?>> listenToEvents() async {
    final isNetworkConnected = await networkInfo.isConnected;
    if (isNetworkConnected!) {
      try {
        return Right(
          await remoteDatasource.listenToEvents(),
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
