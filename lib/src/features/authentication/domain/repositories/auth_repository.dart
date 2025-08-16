import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';

///[Marker Interface] abstraction of auth repository
abstract class AuthRepository {
  Future<Either<Failures, void>>? deleteAccount({String? password});

  ///Let user login
  Future<Either<Failures, void>>? logIn({
    required String email,
    required String password,
  });

  ///Let user logged in
  Future<Either<Failures, bool?>>? isUserLogged();

  ///Let user active
  Future<Either<Failures, bool?>>? isUserActive();

  ///
  Future<Either<Failures, AuthEntity?>>? authenticateUser();

  ///Let profile created
  Future<Either<Failures, bool?>>? isProfileCreated();

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

  ///
  Future<Either<Failures, Stream<Map<String, dynamic>?>?>> listenToEvents();
}
