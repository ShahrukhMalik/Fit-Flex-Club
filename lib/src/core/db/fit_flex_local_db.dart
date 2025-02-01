import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/daos/sync_queue_dao.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/tables/sync_queue_table.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/daos/client_dao.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_weight.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/daos/workout_history_dao.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/tables/workout_history_exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/tables/workout_history_set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/daos/workout_plan_dao.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_bp_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';
part 'fit_flex_local_db.g.dart';

@DriftDatabase(
  tables: [
    WorkoutPlans,
    Weeks,
    Days,
    WorkoutPlanExercise,
    ExerciseSets,
    BaseExercise,
    Clients,
    ClientWeight,
    WorkoutHistorySet,
    SyncQueue,
    WorkoutHistoryExercise
  ],
  daos: [
    WorkoutPlanDao,
    ClientsDao,
    WorkoutHistoryDao,
    SyncQueueDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<void> deleteAllTables() async {
    Future.wait([
      clients.deleteAll(),
      clientWeight.deleteAll(),
      workoutPlans.deleteAll(),
      weeks.deleteAll(),
      days.deleteAll(),
      workoutPlanExercise.deleteAll(),
      exerciseSets.deleteAll(),
      baseExercise.deleteAll(),
      workoutHistorySet.deleteAll(),
      workoutHistoryExercise.deleteAll(),
    ]);
  }

  // You can handle database migration here
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          // This will be executed when the database is created for the first time.
          await m.createTable(workoutPlans);
          await m.createTable(weeks);
          await m.createTable(days);
          await m.createTable(workoutPlanExercise);
          await m.createTable(exerciseSets);
          await m.createTable(baseExercise);
          await m.createTable(clients);
          await m.createTable(clientWeight);
          await m.createTable(workoutHistorySet);
          await m.createTable(syncQueue);
          await m.createTable(workoutHistoryExercise);
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Handle schema version upgrades (when schemaVersion changes)

          // Example for migrating from version 1 to version 2:
          if (from == 9 && to == 10) {
            await m.createTable(workoutPlans);
            await m.createTable(weeks);
            await m.createTable(days);
            await m.createTable(workoutPlanExercise);
            await m.createTable(exerciseSets);
            await m.createTable(baseExercise);
            await m.createTable(clients);
            await m.createTable(clientWeight);
            await m.createTable(workoutHistorySet);
            await m.createTable(syncQueue);
            await m.createTable(workoutHistoryExercise);
            // Handle schema migration from version 1 to version 2
            // e.g., Add a new table, column, or index
            // Example: Adding a new column or table

            // You can add new tables or modify the existing schema like this:
            // await m.addColumn(workoutPlans, workoutPlans.id);
            // await m.createTable(weekTable); // Assuming you added new tables or need to recreate
          }
        },
      );

  // Other database methods and queries
  Future<void> deleteClients() async {
    await clients.deleteAll();
  }

  Future<void> deleteClientWeights() async {
    await clientWeight.deleteAll();
  }

  Future<void> deleteWorkoutPlans() async {
    final deleteIds = await Future.wait([
      workoutPlans.deleteAll(),
      weeks.deleteAll(),
      days.deleteAll(),
      workoutPlanExercise.deleteAll(),
      exerciseSets.deleteAll(),
    ]);
    print(deleteIds);
  }

  Future<void> deleteExercises() async {
    await baseExercise.deleteAll();
  }

  Future<void> deleteWorkoutHistorySets() async {
    await workoutHistorySet.deleteAll();
    await workoutHistoryExercise.deleteAll();
  }

  @override
  int get schemaVersion => 10;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'fit_flex_club_db');
  }
}
