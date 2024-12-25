import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';

///[Marker Interface] abstraction of Sync Manager repository
abstract class SyncManagerRepository {
  ///
  Future<Either<Failures, Stream<ListenerEvents>>> eventsListener();

  ///
  Future<Either<Failures, void>> logEventListened();

  ///
  Future<Either<Failures, void>> syncData();

  ///
  Future<Either<Failures, Stream<bool>>> isOnline();

  ///
  Future<Either<Failures, Stream<Map<String,dynamic>?>?>> eventListener();

  ///
  Future<Either<Failures, void>> markEventListened(String docId);
}

enum ListenerEvents {
  updateAssignedWorkoutPlan,
  deleteAssignedWorkoutPlan,
  assignWorkoutPlan,
  addUser,
  addClientWeight,
  deactivateUser,
  logWorkoutProgress,
  createWorkoutPlan,
  updateWorkoutPlan,
  deleteWorkoutPlan,
}
