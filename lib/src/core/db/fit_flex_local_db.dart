import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fit_flex_club/src/core/db/sync/sync_queue_dao.dart';
import 'package:fit_flex_club/src/core/db/sync/sync_queue_table.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/daos/client_dao.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_weight.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/daos/workout_history_dao.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/tables/workout_history_set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/daos/workout_plan_dao.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_bp_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';
import 'package:injectable/injectable.dart';
part 'fit_flex_local_db.g.dart';

@DriftDatabase(tables: [
  WorkoutPlans,
  Weeks,
  Days,
  Exercises,
  ExerciseSets,
  ExerciseBp,
  Clients,
  ClientWeight,
  WorkoutHistorySet,
  SyncQueue
], daos: [
  WorkoutPlanDao,
  ClientsDao,
  WorkoutHistoryDao,
  SyncQueueDao
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<void> deleteClients() async {
    await clients.deleteAll();
  }
  Future<void> deleteWorkoutPlans() async {
    await workoutPlans.deleteAll();
  }

  @override
  int get schemaVersion => 1;
  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'fit_flex_club_db');
  }
}
