import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failures, Stream<bool>>>? checkWhetherUserIsLoggedIn() {
    // TODO: implement checkWhetherUserIsLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>>? forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>>? logIn(
      {required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>>? logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>>? resetPassword(String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>>? signup({
    required String email,
    required String password,
  }) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
