import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/workout_plan_entity.dart';

///[Marker Interface] abstraction of client management repositories
abstract class ClientManagementRepository {
  ///Let user get client data
  Future<Either<Failures, ClientEntity>>? getClientData();

  ///Let user get the client workout plan
  Future<Either<Failures, WorkoutPlan>>? getWorkoutPlan(String? clientUid);

  ///Let user get the client weight record
  Future<Either<Failures, List<ClientWeightEntity>>>? getClientWeights(
    String? clientUid,
  );

  ///Let user get the client weight record
  Future<Either<Failures, List<ClientWeightEntity>>>? getClientWorkoutHistory(
    String? clientUid,
  );
}
