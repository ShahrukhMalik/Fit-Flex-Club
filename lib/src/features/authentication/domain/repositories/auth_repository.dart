import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';

///[Marker Interface] abstraction of auth repository
abstract class AuthRepository {
  ///Let user login
  Future<Either<Failures, void>>? logIn({
    required String email,
    required String password,
  });

  ///Let user signup
  Future<Either<Failures, AuthEntity?>>? signup({
    required String email,
    required String password,
  });

  ///Let user log out
  Future<Either<Failures, void>>? logOut();

  ///Let user get reset password link
  Future<Either<Failures, void>>? forgotPassword(String email);

  ///Let user reset password
  Future<Either<Failures, void>>? resetPassword(String newPassword);

  ///Checks whether user is signed in already
  Future<Either<Failures, Stream<bool>>>? checkWhetherUserIsLoggedIn();
}
