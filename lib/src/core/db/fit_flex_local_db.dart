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
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Handle schema version upgrades (when schemaVersion changes)

          // Example for migrating from version 1 to version 2:
          if (from == 5 && to == 6) {
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

  Future<void> deleteWorkoutPlans() async {
   final deleteIds= await Future.wait([
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

  @override
  int get schemaVersion => 5;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'fit_flex_club_db');
  }
}
