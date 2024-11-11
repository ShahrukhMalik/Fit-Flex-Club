import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';

abstract class ClientProfileRemoteDatasource {
  ///Add new user
  Future<void>? addNewUser({
    required ClientModel clientModel,
  });

  ///Update existing user
  Future<void>? updateUser({
    required ClientModel clientModel,
  });
}

@Singleton(as: ClientProfileRemoteDatasource)
class ClientProfileRemoteDatasourceImpl extends ClientProfileRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  ClientProfileRemoteDatasourceImpl({
    required this.auth,
    required this.db,
  });
  @override
  Future<void>? addNewUser({
    required ClientModel clientModel,
  }) async {
    final CollectionReference ref = db.collection('users');
    try {
      await ref.doc(clientModel.authId).set(clientModel.toFirestore());
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void>? updateUser({
    required ClientModel clientModel,
  }) async {
    final CollectionReference ref = db.collection('users');
    try {
      await ref.doc(clientModel.authId).update(clientModel.toFirestore());
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
