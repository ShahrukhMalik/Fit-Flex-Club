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

  ///Check if client is active
  Future<bool?>? isUserActive();

  /// Check if client profile is created
  Future<bool> isClientProfileCreated();

  ///
  Future<List<ClientModel>?> getClients();
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
    final CollectionReference ref = db.collection('Users');
    try {
      await ref.doc(auth.currentUser?.uid).set(clientModel.toFirestore());
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
    final CollectionReference ref = db.collection('Users');
    try {
      await ref.doc(auth.currentUser?.uid).update(clientModel.toFirestore());
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<bool> isClientProfileCreated() async {
    final docRef = db.collection('User').doc(auth.currentUser?.uid);

    try {
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        return false;
      }

      final data = docSnapshot.data();

      if (data != null) {
        for (var field in [
          'age',
          'gender',
          'weightInKg',
          'weightInLb',
          'heightInCm',
          'heightInFt',
        ]) {
          if (data[field] == null) {
            return false;
          }
        }
      } else {
        return false;
      }
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
    return false;
  }

  @override
  Future<bool?>? isUserActive() async {
    try {
      final CollectionReference ref = db.collection('Users');
      final DocumentSnapshot<Object?> snapshot =
          await ref.doc(auth.currentUser?.uid).get();

      final data = snapshot.data();

      return data == null
          ? false
          : (data as Map<String, dynamic>)['isUserActive'] == true;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<List<ClientModel>?> getClients() async {
    try {
      final CollectionReference ref = db.collection('Users');

      // Query to get clients who are not trainers
      final QuerySnapshot querySnapshot =
          await ref.where('isTrainer', isEqualTo: false).get();

      // Map the QuerySnapshot documents to a List<ClientModel>
      final List<ClientModel> clients = querySnapshot.docs.map((doc) {
        return ClientModel.fromFirestore(
          (doc as DocumentSnapshot<Map<String, dynamic>>),
          null,
        );
      }).toList();

      return clients;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
