import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/client_management/data/models/client_weight_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/add_client_weight_usecase.dart'
    as add_client_weight_usecase;
import 'package:fit_flex_club/src/features/client_profile/domain/usecases/add_user_usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/daos/sync_queue_dao.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/workout_history/domain/usecases/log_workout_history_usecase.dart'
    as log_workout_history_usecase;
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/workout_plan_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/assign_workout_plan_usecase.dart'
    as assign_workout_plan_usecase;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/create_workout_plan_usecase.dart'
    as create_workout_plan;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/delete_assigned_workout_plan_usecase.dart'
    as delete_assigned_workout_plan;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/delete_workout_plan_usecase.dart'
    as delete_workout_plan;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/update_assigned_workout_plan_usecase.dart'
    as update_assigned_workout_plan;
import 'package:fit_flex_club/src/features/workout_management/domain/usecases/update_workout_plan_usecase.dart'
    as update_workout_plan;
import 'package:injectable/injectable.dart';

abstract class SyncManagerRemoteDatasource {
  ///
  Future<Stream<bool>> isOnline();

  ///
  Future<void> syncData();
}

@Singleton(as: SyncManagerRemoteDatasource)
class SyncManagerRemoteDatasourceImpl extends SyncManagerRemoteDatasource {
  final Connectivity connectivity;
  final FirebaseAuth auth;
  final FirebaseFirestore remoteDb;
  final SyncQueueDao syncQueueDao;
  final add_client_weight_usecase.AddClientWeightUsecase addClientWeightUsecase;
  final create_workout_plan.CreateWorkoutPlanUsecase createWorkoutPlanUsecase;
  final delete_workout_plan.DeleteWorkoutPlanUsecase deleteWorkoutPlanUsecase;
  final assign_workout_plan_usecase.AssignWorkoutPlanUsecase
      assignWorkoutPlanUsecase;
  final delete_assigned_workout_plan.DeleteAssignedWorkoutPlanUsecase
      deleteAssignedWorkoutPlanUsecase;
  final update_assigned_workout_plan.UpdateAssignedWorkoutPlanUsecase
      updateAssignedWorkoutPlanUsecase;
  final update_workout_plan.UpdateWorkoutPlanUsecase updateWorkoutPlanUsecase;
  final log_workout_history_usecase.LogWorkoutHistoryUsecase
      logWorkoutHistoryUsecase;

  SyncManagerRemoteDatasourceImpl(
    this.auth,
    this.remoteDb,
    this.syncQueueDao,
    this.addClientWeightUsecase,
    this.createWorkoutPlanUsecase,
    this.deleteWorkoutPlanUsecase,
    this.assignWorkoutPlanUsecase,
    this.deleteAssignedWorkoutPlanUsecase,
    this.updateAssignedWorkoutPlanUsecase,
    this.updateWorkoutPlanUsecase,
    this.logWorkoutHistoryUsecase, {
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
          final result = await addClientWeightUsecase(
            add_client_weight_usecase.Params(
              weight: weight,
            ),
          );
          if (result != null) {
            result.fold(
              (l) {
                throw ServerException(
                  errorMessage: l.message ?? "Something Went Wrong",
                  errorCode: '01',
                );
              },
              (r) async {
                await syncQueueDao.markDataAsSynced(dataRow.id);
              },
            );
          } else {
            throw ServerException(
              errorMessage: "Something Went Wrong",
              errorCode: '02',
            );
          }
        }

        if (dataRow.event == ListenerEvents.createWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          final result = await createWorkoutPlanUsecase(
            create_workout_plan.Params(
              workoutPlan: workoutPlan,
            ),
          );
          if (result != null) {
            result.fold(
              (l) {
                throw ServerException(
                  errorMessage: l.message ?? "Something Went Wrong",
                  errorCode: '01',
                );
              },
              (r) async {
                await syncQueueDao.markDataAsSynced(dataRow.id);
              },
            );
          } else {
            throw ServerException(
              errorMessage: "Something Went Wrong",
              errorCode: '02',
            );
          }
        }
        if (dataRow.event == ListenerEvents.updateWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          final result = await updateWorkoutPlanUsecase(
            update_workout_plan.Params(
              workoutPlan: workoutPlan,
            ),
          );
          if (result != null) {
            result.fold(
              (l) {
                throw ServerException(
                  errorMessage: l.message ?? "Something Went Wrong",
                  errorCode: '01',
                );
              },
              (r) async {
                await syncQueueDao.markDataAsSynced(dataRow.id);
              },
            );
          } else {
            throw ServerException(
              errorMessage: "Something Went Wrong",
              errorCode: '02',
            );
          }
        }
        if (dataRow.event == ListenerEvents.deleteWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          final result = await deleteWorkoutPlanUsecase(
            delete_workout_plan.Params(
              workoutPlan: workoutPlan,
            ),
          );
          if (result != null) {
            result.fold(
              (l) {
                throw ServerException(
                  errorMessage: l.message ?? "Something Went Wrong",
                  errorCode: '01',
                );
              },
              (r) async {
                await syncQueueDao.markDataAsSynced(dataRow.id);
              },
            );
          } else {
            throw ServerException(
              errorMessage: "Something Went Wrong",
              errorCode: '02',
            );
          }
        }
        if (dataRow.event == ListenerEvents.assignWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          final result = await assignWorkoutPlanUsecase(
            assign_workout_plan_usecase.Params(
              workoutPlan: workoutPlan,
            ),
          );
          if (result != null) {
            result.fold(
              (l) {
                throw ServerException(
                  errorMessage: l.message ?? "Something Went Wrong",
                  errorCode: '01',
                );
              },
              (r) async {
                await syncQueueDao.markDataAsSynced(dataRow.id);
              },
            );
          } else {
            throw ServerException(
              errorMessage: "Something Went Wrong",
              errorCode: '02',
            );
          }
        }
        if (dataRow.event == ListenerEvents.deleteAssignedWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          final result = await deleteAssignedWorkoutPlanUsecase(
            delete_assigned_workout_plan.Params(
              workoutPlan: workoutPlan,
            ),
          );
          if (result != null) {
            result.fold(
              (l) {
                throw ServerException(
                  errorMessage: l.message ?? "Something Went Wrong",
                  errorCode: '01',
                );
              },
              (r) async {
                await syncQueueDao.markDataAsSynced(dataRow.id);
              },
            );
          } else {
            throw ServerException(
              errorMessage: "Something Went Wrong",
              errorCode: '02',
            );
          }
        }
        if (dataRow.event == ListenerEvents.updateAssignedWorkoutPlan.name) {
          final WorkoutPlanModel workoutPlan =
              WorkoutPlanModel.fromMap(jsonDecode(dataRow.data));
          final result = await updateAssignedWorkoutPlanUsecase(
            update_assigned_workout_plan.Params(
              workoutPlan: workoutPlan,
            ),
          );
          if (result != null) {
            result.fold(
              (l) {
                throw ServerException(
                  errorMessage: l.message ?? "Something Went Wrong",
                  errorCode: '01',
                );
              },
              (r) async {
                await syncQueueDao.markDataAsSynced(dataRow.id);
              },
            );
          } else {
            throw ServerException(
              errorMessage: "Something Went Wrong",
              errorCode: '02',
            );
          }
        }
        if (dataRow.event == ListenerEvents.logWorkoutProgress.name) {
          final historyData = jsonDecode(dataRow.data);
          final result = await logWorkoutHistoryUsecase(
            log_workout_history_usecase.Params(
              exerciseId: historyData['exerciseId'],
              clientId: historyData['clientId'],
              sets: (historyData['sets'] as List)
                  .map(
                    (e) => SetModel.fromMap(e),
                  )
                  .toList(),
            ),
          );
          if (result != null) {
            result.fold(
              (l) {
                throw ServerException(
                  errorMessage: l.message ?? "Something Went Wrong",
                  errorCode: '01',
                );
              },
              (r) async {
                await syncQueueDao.markDataAsSynced(dataRow.id);
              },
            );
          } else {
            throw ServerException(
              errorMessage: "Something Went Wrong",
              errorCode: '02',
            );
          }
        }
      }
    } on ServerException catch (err) {
      throw ServerException(
        errorMessage: err.errorMessage,
        errorCode: err.errorCode,
      );
    }
  }
}
