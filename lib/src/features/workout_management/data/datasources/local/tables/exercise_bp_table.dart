import 'package:drift/drift.dart';

class ExerciseBp extends Table {
  IntColumn get id => integer().autoIncrement()(); // Primary key, auto-incremented
  IntColumn get code => integer()(); // Exercise code
  TextColumn get category => text().withLength(min: 1, max: 100)(); // Category (e.g., equipment)
  TextColumn get muscleGroup => text().withLength(min: 1, max: 100)(); // Muscle group
  TextColumn get name => text().withLength(min: 1, max: 255)(); // Exercise name
  TextColumn get parameters => text()(); // Parameters stored as JSON string
  
  // Additional Boolean fields
  BoolColumn get distance => boolean().withDefault(Constant(false))(); // Defaults to false
  BoolColumn get reps => boolean().withDefault(Constant(true))(); // Defaults to true
  BoolColumn get time => boolean().withDefault(Constant(false))(); // Defaults to false
  BoolColumn get weight => boolean().withDefault(Constant(true))(); // Defaults to true

  IntColumn get createdAt => integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))(); // Creation timestamp
  IntColumn get updatedAt => integer().nullable()(); // Nullable updated timestamp
}
