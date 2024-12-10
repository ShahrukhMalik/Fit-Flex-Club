import 'package:drift/drift.dart';

class Clients extends Table {
  TextColumn get id => text()();
  IntColumn get age => integer().nullable()();
  TextColumn get gender => text().nullable()();
  IntColumn get weight => integer().nullable()(); // Default value for weight
  TextColumn get weightUnit => text().nullable()(); // Default weight unit
  IntColumn get height => integer().nullable()(); // Default value for height
  TextColumn get heightUnit => text().nullable()(); // Default height unit
  BoolColumn get isTrainer => boolean()();
  BoolColumn get isUserActive => boolean()();
  TextColumn get username => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get phoneCountryCode => text().nullable()();
  TextColumn get currentWorkoutPlanName => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer().nullable()(); // Default value for updatedAt

  @override
  Set<Column> get primaryKey => {id};
}
