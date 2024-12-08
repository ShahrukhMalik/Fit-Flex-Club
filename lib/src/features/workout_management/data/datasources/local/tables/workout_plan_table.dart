import 'package:drift/drift.dart';

class WorkoutPlans extends Table {
  TextColumn get uid => text()(); // Primary key
  TextColumn get name => text().withLength(min: 1, max: 255)(); // Plan name
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  IntColumn get updatedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {uid};
}

//    ├── tables/
// │   │   ├── workout_plan_table.dart
// │   │   ├── week_table.dart
// │   │   ├── day_table.dart
// │   │   ├── exercise_table.dart
// │   │   └── set_table.dart
// │   ├── daos/
// │   │   ├── workout_plan_dao.dart
// │   │   ├── week_dao.dart
// │   │   ├── day_dao.dart
// │   │   ├── exercise_dao.dart
// │   │   └── set_dao.dart