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
}

enum ListenerEvents {
  updateAssignedWorkoutPlan,
  deleteAssignedWorkoutPlan,
  addAssignedWorkoutPlan,
  deactivateUser,
}
