import 'package:drift/drift.dart';


class Clients extends Table {
  TextColumn get authId => text()
      .withLength(min: 1, max: 255)
      .customConstraint('PRIMARY KEY NOT NULL')(); // authId  // Primary key
  IntColumn get age => integer()(); // age
  TextColumn get gender => text().withLength(min: 1, max: 10)(); // gender
  IntColumn get weight => integer()(); // weight
  TextColumn get weightUnit =>
      text().withLength(min: 1, max: 10)(); // weight unit
  IntColumn get height => integer()(); // height
  TextColumn get heightUnit =>
      text().withLength(min: 1, max: 10)(); // height unit
  BoolColumn get isTrainer => boolean()(); // isTrainer
  BoolColumn get isUserActive => boolean()(); // isUserActive
  TextColumn get username => text().withLength(min: 1, max: 255)(); // username
  TextColumn get email => text().nullable()(); // email
  TextColumn get phone => text().nullable()(); // phone
  TextColumn get currentWorkoutId => text().nullable()(); // currentWorkoutId
}
