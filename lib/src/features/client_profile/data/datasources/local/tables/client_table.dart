import 'package:drift/drift.dart';

class Clients extends Table {
  TextColumn get id => text()();
  IntColumn get age => integer().nullable()();
  TextColumn get gender => text().nullable()();
  RealColumn get weightInKg => real().nullable()(); // Default value for weight
  RealColumn get weightInLb => real().nullable()(); // Default weight unit
  RealColumn get heightInFt => real().nullable()(); // Default value for height
  RealColumn get heightInCm => real().nullable()(); // Default height unit
  BoolColumn get isTrainer => boolean()();
  BoolColumn get isUserActive => boolean()();
  TextColumn get username => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get phoneCountryCode => text().nullable()();
  TextColumn get currentWorkoutPlanName => text().nullable()();
  IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)();
  IntColumn get updatedAt => integer().nullable()(); // Default value for updatedAt

  @override
  Set<Column> get primaryKey => {id};
}
