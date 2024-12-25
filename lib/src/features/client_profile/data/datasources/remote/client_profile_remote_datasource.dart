import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/client_management/data/models/client_weight_model.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
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

  ///
  Future<ClientModel?> getClientById([String? id]);

  ///Get clients weights
  Future<List<ClientWeightEntity>?>? getClientWeights();

  ///Get clients weights
  Future<void>? addClientWeight(ClientWeightModel clientWeightModel);
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
    final CollectionReference weightTrakerRef = db
        .collection('Users')
        .doc(auth.currentUser?.uid)
        .collection('weightTracker');

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
    final CollectionReference weightTrakerRef = db
        .collection('Users')
        .doc(auth.currentUser?.uid)
        .collection('weightTracker');
    final listenerRef = db.collection('ListenerEvents');
    try {
      await ref.doc(auth.currentUser?.uid).update(clientModel.toFirestore());
      await weightTrakerRef.add(
        ClientWeightModel(
          timeStamp: DateTime.now().millisecondsSinceEpoch,
          weightInKg: clientModel.weightInKg?.toDouble() ?? 0,
          weightInLb: clientModel.weightInLb?.toDouble() ?? 0,
          clientId: auth.currentUser?.uid,
        ).toMap(),
      );

      final trainers = await ref.where('isTrainer', isEqualTo: true).get();
      for (final trainer in trainers.docs) {
        await listenerRef.add(
          {
            'clientId': trainer.id,
            'eventType': ListenerEvents.addUser.name,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          },
        );
      }
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
      final CollectionReference usersRef = db.collection('Users');

      // Query to get clients who are not trainers
      final QuerySnapshot querySnapshot =
          await usersRef.where('isTrainer', isEqualTo: false).get();

      // Map the QuerySnapshot documents to a List<ClientModel>
      final List<ClientModel> clients =
          await Future.wait(querySnapshot.docs.map((doc) async {
        final client = ClientModel.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>,
          null,
        );

        try {
          // Access the workoutPlans sub-collection for this user
          final CollectionReference workoutPlansRef =
              doc.reference.collection('workoutPlans');
          final QuerySnapshot workoutPlansSnapshot =
              await workoutPlansRef.limit(1).get();

          // Assign the name of the first workout plan to currentWorkoutPlanName, if available
          if (workoutPlansSnapshot.docs.isNotEmpty) {
            final firstPlan =
                workoutPlansSnapshot.docs.first.data() as Map<String, dynamic>;
            return client.copyWith(currentWorkoutPlanName: firstPlan['name']);
          }
        } catch (e) {
          // If sub-collection does not exist or any other issue occurs, log the error (optional)
          print('No workoutPlans sub-collection found for user ${doc.id}: $e');
        }

        // Return the client as is if no workout plan is found or sub-collection doesn't exist
        return client;
      }).toList());

      return clients;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<ClientModel?> getClientById([String? id]) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      final CollectionReference usersRef = db.collection('Users');
      final userDoc = await usersRef.doc(clientId).get();

      if (!userDoc.exists) {
        return null;
      }
      final user = ClientModel.fromFirestore(
        userDoc as DocumentSnapshot<Map<String, dynamic>>,
        null,
      );

      try {
        // Access the workoutPlans sub-collection for this user
        final CollectionReference workoutPlansRef =
            userDoc.reference.collection('workoutPlans');
        final QuerySnapshot workoutPlansSnapshot =
            await workoutPlansRef.limit(1).get();

        // Assign the name of the first workout plan to currentWorkoutPlanName, if available
        if (workoutPlansSnapshot.docs.isNotEmpty) {
          final firstPlan =
              workoutPlansSnapshot.docs.first.data() as Map<String, dynamic>;
          return user.copyWith(currentWorkoutPlanName: firstPlan['name']);
        }
      } catch (e) {
        // If sub-collection does not exist or any other issue occurs, log the error (optional)
        // print('No workoutPlans sub-collection found for user ${doc.id}: $e');
      }

      return user;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<List<ClientWeightEntity>?>? getClientWeights() async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      final CollectionReference clients = db.collection('Users');
      final clientWeightsDocs = await clients
          .doc(clientId)
          .collection('weightTracker')
          .orderBy('timeStamp', descending: false)
          .get();

      if (clientWeightsDocs.docs.isEmpty) {
        return null;
      }

      final List<ClientWeightEntity> clientWeights =
          (clientWeightsDocs.docs).map(
        (e) {
          return ClientWeightModel.fromMap(e.data());
        },
      ).toList();

      return clientWeights;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void>? addClientWeight(ClientWeightModel clientWeightModel) async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      final CollectionReference weightTrakerRef =
          db.collection('Users').doc(clientId).collection('weightTracker');

      await weightTrakerRef.add(clientWeightModel.toMap());
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
