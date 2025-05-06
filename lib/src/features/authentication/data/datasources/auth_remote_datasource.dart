import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/core/util/sharedpref/shared_prefs_util.dart';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDatasource {
  ///Let user login
  Future<void>? logIn({
    required AuthEntity authEntity,
  });

  ///Let user logged in
  Future<bool>? isUserLogged();

  ///Let user active
  Future<bool>? isUserActive();

  ///Let profile created
  Future<bool>? isProfileCreated();

  ///
  Future<AuthEntity>? authenticateUser();

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

  ///
  Future<Stream<Map<String, dynamic>?>?> listenToEvents();
}

@Singleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore remoteDb;
  final AppDatabase localDb;
  final SharedPrefsUtil prefs;

  AuthRemoteDatasourceImpl(
    this.prefs,
    this.remoteDb,
    this.localDb, {
    required this.auth,
  });
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

        final uid = auth.currentUser?.uid;

        final userDoc = await remoteDb.collection('Users').doc(uid).get();

        if (!userDoc.exists) {
          throw ServerException(
            errorMessage: "User not found!",
          );
        } else {
          final isUserActive = userDoc.data()?['isUserActive'];

          if (isUserActive != true) {
            throw ServerException(
              errorMessage: "User is not active, kindly contact trainer!.",
            );
          }
        }

        if (uid != null) {
          prefs.setAuthUid(uid);
        }
      }
    } on FirebaseAuthException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something Went Wrong!",
      );
    }
  }

  @override
  Future<void>? logOut() async => await auth.signOut().then(
        (value) async {
          await prefs.clearAuthData();
          await localDb.deleteAllTables();
        },
      ).catchError(
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

        final uid = auth.currentUser?.uid;
        if (uid != null) {
          prefs.setAuthUid(uid);
        }

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

  @override
  Future<bool>? isUserActive() async {
    try {
      final CollectionReference ref = remoteDb.collection('Users');
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
  Future<bool>? isUserLogged() async {
    return Future.value(
      auth.currentUser != null,
    );
  }

  @override
  Future<bool>? isProfileCreated() async {
    final docRef = remoteDb.collection('User').doc(auth.currentUser?.uid);

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
  Future<AuthEntity>? authenticateUser() async {
    try {
      bool isUserLoggedIn = auth.currentUser != null;
      bool isUserActive = true;
      bool? isProfileCreated = false;
      bool? isTrainer;

      final AuthEntity? authEntity = prefs.getAuthEntity();
      final getUid = prefs.getAuthUid();
      // if (authEntity == null || true) {
      final CollectionReference ref = remoteDb.collection('Users');
      final DocumentSnapshot<Object?> snapshot =
          await ref.doc(auth.currentUser?.uid).get();

      if (!snapshot.exists) {
        isUserActive = false;
        isProfileCreated = false;
      }
      final data = snapshot.data() as Map<String, dynamic>?;

      final gymId = (data)?['gymId'];
      final userName = (data)?['username'];

      if (gymId != null) {
        await prefs.setGymId(gymId);
      }
      if(userName != null) {
        await prefs.setUserName(userName);
      }

      isUserActive = data == null ? false : (data)['isUserActive'] ?? false;
      isTrainer = data == null || (data)['isTrainer'] == null
          ? false
          : (data)['isTrainer'];

      if (isTrainer == null) {
        throw ServerException(
          errorMessage:
              "Your role is not defined, kindly reach out to us for help!",
        );
      } else if (isTrainer) {
        final AuthEntity toStoreEntity = AuthEntity(
          uid: auth.currentUser?.uid,
          isLoggedIn: isUserLoggedIn,
          isProfileCreated: true,
          isUserActive: isUserActive,
          isTrainer: isTrainer,
          timeStamp: DateTime.now(),
        );
        await prefs.setAuthEntity(toStoreEntity);
        return Future.value(
          toStoreEntity,
        );
      }
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
            isProfileCreated = false;
          } else {
            isProfileCreated = true;
          }
          print(isProfileCreated);
        }
      } else {
        isProfileCreated = false;
      }
      print(isProfileCreated);
      final AuthEntity toStoreEntity = AuthEntity(
        uid: auth.currentUser?.uid,
        isLoggedIn: isUserLoggedIn,
        isProfileCreated: isProfileCreated,
        isUserActive: isUserActive,
        isTrainer: isTrainer,
        timeStamp: DateTime.now(),
      );
      await prefs.setAuthEntity(toStoreEntity);
      return Future.value(
        toStoreEntity,
      );
      // } else {
      //   return Future.value(authEntity);
      // }
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<Stream<Map<String, dynamic>?>?> listenToEvents() async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      final listenerRef = remoteDb
          .collection('ListenerEvents')
          .where('clientId', isEqualTo: clientId)
          .where('isListendAlready', isEqualTo: false)
          .orderBy('timestamp', descending: true);

      return listenerRef.snapshots().asBroadcastStream().map((snapshot) {
        for (var doc in snapshot.docs) {
          if (doc.exists) {
            final data = doc.data();
            String eventType = data['eventType'];

            ListenerEvents? event;
            switch (eventType) {
              case 'updateAssignedWorkoutPlan':
                event = ListenerEvents.updateAssignedWorkoutPlan;
                break;
              case 'deleteAssignedWorkoutPlan':
                event = ListenerEvents.deleteAssignedWorkoutPlan;
                break;
              case 'assignWorkoutPlan':
                event = ListenerEvents.assignWorkoutPlan;
                break;
              case 'addUser':
                event = ListenerEvents.addUser;
                break;
              case 'addClientWeight':
                event = ListenerEvents.addClientWeight;
                break;
              case 'deactivateUser':
                event = ListenerEvents.deactivateUser;
                break;
              case 'logWorkoutProgress':
                event = ListenerEvents.logWorkoutProgress;
                break;
              case 'createWorkoutPlan':
                event = ListenerEvents.createWorkoutPlan;
                break;
              case 'updateWorkoutPlan':
                event = ListenerEvents.updateWorkoutPlan;
                break;
              case 'deleteWorkoutPlan':
                event = ListenerEvents.deleteWorkoutPlan;
                break;
              default:
                break;
            }

            if (event != null) {
              return {'eventType': event, 'docId': doc.id};
            }
          }
        }
        return null;
      });
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
