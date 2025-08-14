// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/sharedpref/shared_prefs_util.dart';
import 'package:fit_flex_club/src/features/client_management/data/models/client_weight_model.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/gym_model.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/trainer_model.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';

abstract class ClientProfileRemoteDatasource {
  ///
  Future<List<GymModel>> getGyms();

  ///
  Future<void> mapClientToTrainer({
    required GymModel gym,
    required TrainerModel trainer,
    required ClientModel client,
  });

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
  Future<List<ClientWeightEntity>?>? getClientWeights(String? clientId);

  ///Get clients weights
  Future<void>? addClientWeight(ClientWeightModel clientWeightModel);
}

@Singleton(as: ClientProfileRemoteDatasource)
class ClientProfileRemoteDatasourceImpl extends ClientProfileRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;
  final SharedPrefsUtil prefs;

  ClientProfileRemoteDatasourceImpl({
    required this.auth,
    required this.db,
    required this.prefs,
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
      await ref.doc(auth.currentUser?.uid).update(
            clientModel.toFirestore(),
          );
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
            'isListendAlready': false,
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
      final authId = auth.currentUser?.uid;
      if (authId == null) {
        throw ServerException(
          errorMessage: "Auth ID not found",
        );
      }

      final CollectionReference usersRef = db.collection('Users');
      final mappingDoc =
          await db.collection('trainer_clients').doc(authId).get();

      if (!mappingDoc.exists) {
        return [];
      }

      final data = mappingDoc.data();

      if (data == null) {
        return [];
      }

      final clientIds = (data['clients'] as List?)?.map(
        (obj) => obj['id'],
      );

      // Query to get clients who are not trainers
      final QuerySnapshot querySnapshot = await usersRef
          .where(
            FieldPath.documentId,
            whereIn: clientIds,
          )
          .get();

      // Map the QuerySnapshot documents to a List<ClientModel>
      final List<ClientModel> clients =
          await Future.wait(querySnapshot.docs.map((doc) async {
        final CollectionReference gymRef = db.collection('gyms');
        final gymId = (doc.data() as Map<String, dynamic>)['gymId'] as String?;
        final trainerId =
            (doc.data() as Map<String, dynamic>)['trainerId'] as String?;
        final trainerDocSnapshot =
            await gymRef.doc(gymId).collection('trainers').doc(trainerId).get();
        final trainerImageUrl = (trainerDocSnapshot.data())!['trainerImageUrl'];

        final mapObject = doc.data() as Map<String, dynamic>;
        mapObject['trainerImageUrl'] = trainerImageUrl;
        final client = ClientModel.fromFirestore(mapObject, doc.id);

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
      final CollectionReference gymRef = db.collection('gyms');
      final gymId =
          (userDoc.data() as Map<String, dynamic>)['gymId'] as String?;
      final trainerId =
          (userDoc.data() as Map<String, dynamic>)['trainerId'] as String?;
      final trainerDocSnapshot =
          await gymRef.doc(gymId).collection('trainers').doc(trainerId).get();
      final trainerImageUrl = (trainerDocSnapshot.data())?['trainerImageUrl'];

      final mapObject = userDoc.data() as Map<String, dynamic>;
      mapObject['trainerImageUrl'] = trainerImageUrl;
      final user = ClientModel.fromFirestore(
        mapObject,
        userDoc.id,
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
  Future<List<ClientWeightEntity>?>? getClientWeights(String? clientId) async {
    try {
      final clientUid = clientId ?? getIt<FirebaseAuth>().currentUser?.uid;
      final CollectionReference clients = db.collection('Users');
      final clientWeightsDocs = await clients
          .doc(clientUid)
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

  @override
  Future<List<GymModel>> getGyms() async {
    try {
      final gymsCollection = FirebaseFirestore.instance.collection('gyms');

      final gymsSnapshot = await gymsCollection.get();

      List<GymModel> gyms = [];

      for (var gymDoc in gymsSnapshot.docs) {
        final gymData = gymDoc.data();
        final trainersSnapshot =
            await gymDoc.reference.collection('trainers').get();

        final trainers = trainersSnapshot.docs.map((trainerDoc) {
          return TrainerModel.fromJson(trainerDoc.data()).toEntity();
        }).toList();

        gyms.add(
          GymModel(
            gymId: gymDoc.id,
            gymName: gymData['name'] ?? '',
            trainers: trainers,
          ),
        );
      }

      return gyms;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> mapClientToTrainer({
    required GymModel gym,
    required TrainerModel trainer,
    required ClientModel client, // One client only
  }) async {
    try {
      final authId = auth.currentUser?.uid;
      if (authId == null) {
        throw ServerException(
          errorMessage: "Auth ID not found",
        );
      }

      final userRef = db.collection('Users').doc(authId);
      final trainerClientRef =
          db.collection('trainer_clients').doc(trainer.trainerId);
      await userRef.set(
        {
          'trainerId': trainer.trainerId,
          'gymId': gym.gymId,
          'gymName': gym.gymName,
        },
        SetOptions(
          merge: true,
        ),
      );
      await prefs.setGymName(gym.gymName);
      await prefs.setGymId(gym.gymId);
      await prefs.setTrainerId(trainer.trainerId);
      await prefs.setAuthRole('client');
      await trainerClientRef.set({
        'trainerId': trainer.trainerId,
        'trainerName': trainer.trainerName,
        'trainerEmail': trainer.email,
        'gymId': gym.gymId,
        'gymName': gym.gymName,
        'clients': FieldValue.arrayUnion([
          client
              .copyWith(
                id: authId,
              )
              .toFirestore()
        ]),
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("✅ Client successfully mapped to trainer ${trainer.trainerName}");
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
