import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:injectable/injectable.dart';

abstract class WorkoutHistoryRemoteDataSource {
  ///
  Future<void> logWorkoutHistory({
    required List<SetModel> sets,
    String? clientId,
    required String exerciseId,
    required String dayId,
    required String weekId,
    required String workoutPlanId,
  });

  ///
  Future<List<WorkoutHistoryModel>> getWorkoutHistorySets(
    String? clientUid,
    String isTrainer,
  );
}

@Singleton(as: WorkoutHistoryRemoteDataSource)
class WorkoutHistoryRemoteDataSourceImpl
    implements WorkoutHistoryRemoteDataSource {
  final FirebaseFirestore db;

  WorkoutHistoryRemoteDataSourceImpl({required this.db});
  @override
  Future<List<WorkoutHistoryModel>> getWorkoutHistorySets(
    String? clientUid,
    String isTrainer,
  ) {
    // TODO: implement getWorkoutHistorySets
    throw UnimplementedError();
  }

  @override
  Future<void> logWorkoutHistory({
    required List<SetModel> sets,
    String? clientId,
    required String exerciseId,
    required String dayId,
    required String weekId,
    required String workoutPlanId,
  }) async {
    try {
      ///
      final clientUid = getIt<FirebaseAuth>().currentUser?.uid;

      ///
      final CollectionReference ref = db.collection('Users');
      WriteBatch batch = db.batch();

      ///
      final exerciseDocRef = ref
          .doc(clientUid ?? clientId)
          .collection('workoutPlans')
          .doc(workoutPlanId)
          .collection('weeks')
          .doc(weekId)
          .collection('days')
          .doc(dayId)
          .collection('exercises')
          .doc(exerciseId);

      ///
      ///
      for (final set in sets) {
        final setMap = set.toMap();
        setMap['setNumber'] = sets.indexOf(set) + 1;
        DocumentReference setRef =
            exerciseDocRef.collection('sets').doc(set.id.toString());
        batch.set(setRef, setMap, SetOptions(merge: true));
      }

      ///
      await batch.commit();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
