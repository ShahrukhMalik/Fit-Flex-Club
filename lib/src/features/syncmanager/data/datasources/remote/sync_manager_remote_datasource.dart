import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/client_management/data/models/client_weight_model.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/remote/client_profile_remote_datasource.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/daos/sync_queue_dao.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/remote/workout_history_remote_data_source.dart';

import 'package:fit_flex_club/src/features/workout_management/data/datasources/remote/workout_plan_management_remotedatasource.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';

import 'package:injectable/injectable.dart';

abstract class SyncManagerRemoteDatasource {
  ///
  Future<Stream<bool>> isOnline();

  ///
  Future<Stream<Map<String, dynamic>?>?> eventListener();

  ///
  Future<void> markEventListened(String docId);

  ///
  Future<void> syncData();
}

@Singleton(as: SyncManagerRemoteDatasource)
class SyncManagerRemoteDatasourceImpl extends SyncManagerRemoteDatasource {
  final Connectivity connectivity;
  final FirebaseAuth auth;
  final FirebaseFirestore remoteDb;
  final SyncQueueDao syncQueueDao;
  final ClientProfileRemoteDatasource clientProfileRemoteDatasource;
  final WorkoutPlanManagementRemotedatasource
      workoutPlanManagementRemotedatasource;
  final WorkoutHistoryRemoteDataSource workoutHistoryRemoteDataSource;

  SyncManagerRemoteDatasourceImpl(
    this.auth,
    this.remoteDb,
    this.syncQueueDao,
    this.clientProfileRemoteDatasource,
    this.workoutPlanManagementRemotedatasource,
    this.workoutHistoryRemoteDataSource, {
    required this.connectivity,
  });
  @override
  Future<Stream<bool>> isOnline() async {
    try {
      final checkConnectivity = await connectivity.checkConnectivity();

      return connectivity.onConnectivityChanged.asBroadcastStream().map(
        (event) {
          final connectionResult = event[0];
          if (connectionResult == ConnectivityResult.none) {
            return false;
          } else {
            return true;
          }
        },
      );
    } catch (err) {
      throw ServerException(errorMessage: err.toString());
    }
  }

  @override
  Future<void> syncData() async {
    try {
      final unSyncedData = await syncQueueDao.getUnsyncedData();

      for (var dataRow in unSyncedData) {
        if (dataRow.event == ListenerEvents.addClientWeight.name) {
          final ClientWeightModel weight =
              ClientWeightModel.fromMap(jsonDecode(dataRow.data));
          await clientProfileRemoteDatasource.addClientWeight(
            weight,
          );
          await syncQueueDao.markDataAsSynced(dataRow.id);
        }

        if (dataRow.event == ListenerEvents.createWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          await workoutPlanManagementRemotedatasource.createWorkoutPlan(
            workoutPlan,
          );
          await syncQueueDao.markDataAsSynced(dataRow.id);
        }
        if (dataRow.event == ListenerEvents.updateWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          await workoutPlanManagementRemotedatasource.updateWorkoutPlan(
            workoutPlan,
          );
          await syncQueueDao.markDataAsSynced(dataRow.id);
        }
        if (dataRow.event == ListenerEvents.deleteWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          await workoutPlanManagementRemotedatasource.deleteWorkoutPlan(
            workoutPlan,
          );
          await syncQueueDao.markDataAsSynced(dataRow.id);
        }
        if (dataRow.event == ListenerEvents.assignWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          await workoutPlanManagementRemotedatasource.assignWorkoutPlan(
            workoutPlan,
          );
          await syncQueueDao.markDataAsSynced(dataRow.id);
        }
        if (dataRow.event == ListenerEvents.deleteAssignedWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          await workoutPlanManagementRemotedatasource.deleteAssignedWorkoutPlan(
            workoutPlan,
          );
          await syncQueueDao.markDataAsSynced(dataRow.id);
        }
        if (dataRow.event == ListenerEvents.updateAssignedWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          await workoutPlanManagementRemotedatasource.updateAssignedWorkoutPlan(
            workoutPlan,
          );
          await syncQueueDao.markDataAsSynced(dataRow.id);
        }
        if (dataRow.event == ListenerEvents.logWorkoutProgress.name) {
          final historyData = jsonDecode(dataRow.data);
          await workoutHistoryRemoteDataSource.logWorkoutHistory(
            exerciseId: historyData['exerciseId'],
            clientId: historyData['clientId'],
            sets: (historyData['sets'] as List)
                .map(
                  (e) => SetModel.fromMap(e),
                )
                .toList(),
          );
          await syncQueueDao.markDataAsSynced(dataRow.id);
        }
      }
    } on ServerException catch (err) {
      throw ServerException(
        errorMessage: err.errorMessage,
        errorCode: err.errorCode,
      );
    }
  }

  @override
  Future<void> markEventListened(docId) async {
    try {
      final listenRefCollection = remoteDb.collection('ListenerEvents');
      await listenRefCollection.doc(docId).update({'isListendAlready': true});
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<Stream<Map<String, dynamic>?>?> eventListener() async {
    try {
      final clientId = getIt<FirebaseAuth>().currentUser?.uid;
      final listenerRef = remoteDb
          .collection('ListenerEvents')
          .where('clientId', isEqualTo: clientId)
          .where('isListendAlready', isEqualTo: null)
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
