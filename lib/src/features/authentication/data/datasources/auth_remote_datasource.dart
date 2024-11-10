import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDatasource {
  ///Let user login
  Future<void>? logIn({
    required AuthEntity authEntity,
  });

  ///Let user log out
  Future<void>? logOut();

  ///Let user signup
  Future<AuthEntity>? signup({
    required AuthEntity authEntity,
  });

  ///Let user get reset password link
  Future<void>? forgotPassword(AuthEntity authEntity);

  ///Let user reset password
  Future<void>? resetPassword(String newPassword);

  ///Checks whether user is signed in already
  Future<Stream<bool>>? checkWhetherUserIsLoggedIn();
}

@Singleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth auth;

  AuthRemoteDatasourceImpl({required this.auth});
  @override
  Future<Stream<bool>>? checkWhetherUserIsLoggedIn() async => auth
      .authStateChanges()
      .asBroadcastStream()
      .map(
        (user) => user != null,
      )
      .handleError((error) => ServerException(errorMessage: error));
  @override
  Future<void>? forgotPassword(AuthEntity authEntity) async {
    try {
      if (authEntity.email == null) {
        throw ServerException(
          errorMessage: "Invalid email or password!, cannot be null or empty",
        );
      } else {
        await auth.sendPasswordResetEmail(email: authEntity.email!);
      }
    } on FirebaseAuthException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something Went Wrong!",
      );
    }
  }

  @override
  Future<void>? logIn({required AuthEntity authEntity}) async {
    try {
      final String? email = authEntity.email;
      final String? password = authEntity.password;
      if (email == null || password == null) {
        throw ServerException(
          errorMessage: "Invalid email or password!, cannot be null or empty",
        );
      } else {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something Went Wrong!",
      );
    }
  }

  @override
  Future<void>? logOut() async => await auth.signOut().catchError(
        (error) => throw (
          ServerException(
            errorMessage: error.message ?? "Something Went Wrong!",
          ),
        ),
      );

  @override
  Future<void>? resetPassword(String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity>? signup({
    required AuthEntity authEntity,
  }) async {
    try {
      final String? email = authEntity.email;
      final String? password = authEntity.password;
      if (email == null || password == null) {
        throw ServerException(
          errorMessage: "Invalid email or password!, cannot be null or empty",
        );
      } else {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return AuthEntity(
          uid: auth.currentUser?.uid,
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something Went Wrong!",
      );
    }
  }
}
