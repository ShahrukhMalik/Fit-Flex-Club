import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/exercise_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/workout_plan_table.dart';
part 'fit_flex_local_db.g.dart';

@DriftDatabase(tables: [WorkoutPlans, Weeks, Days, Exercises, ExerciseSets, Clients], daos: [])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => throw UnimplementedError();
}
