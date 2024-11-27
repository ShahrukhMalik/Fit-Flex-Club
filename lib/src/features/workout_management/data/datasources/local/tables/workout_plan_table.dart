import 'package:drift/drift.dart';

class WorkoutPlans extends Table {
  TextColumn get uid => text().customConstraint('PRIMARY KEY NOT NULL')(); // Primary key
  TextColumn get name => text().withLength(min: 1, max: 255)(); // Plan name
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