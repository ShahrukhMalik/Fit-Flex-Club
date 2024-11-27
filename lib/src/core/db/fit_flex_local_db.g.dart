// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fit_flex_local_db.dart';

// ignore_for_file: type=lint
class $WorkoutPlansTable extends WorkoutPlans
    with TableInfo<$WorkoutPlansTable, WorkoutPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'PRIMARY KEY NOT NULL');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [uid, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_plans';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutPlan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  WorkoutPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutPlan(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $WorkoutPlansTable createAlias(String alias) {
    return $WorkoutPlansTable(attachedDatabase, alias);
  }
}

class WorkoutPlan extends DataClass implements Insertable<WorkoutPlan> {
  final String uid;
  final String name;
  const WorkoutPlan({required this.uid, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['name'] = Variable<String>(name);
    return map;
  }

  WorkoutPlansCompanion toCompanion(bool nullToAbsent) {
    return WorkoutPlansCompanion(
      uid: Value(uid),
      name: Value(name),
    );
  }

  factory WorkoutPlan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutPlan(
      uid: serializer.fromJson<String>(json['uid']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'name': serializer.toJson<String>(name),
    };
  }

  WorkoutPlan copyWith({String? uid, String? name}) => WorkoutPlan(
        uid: uid ?? this.uid,
        name: name ?? this.name,
      );
  WorkoutPlan copyWithCompanion(WorkoutPlansCompanion data) {
    return WorkoutPlan(
      uid: data.uid.present ? data.uid.value : this.uid,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlan(')
          ..write('uid: $uid, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutPlan &&
          other.uid == this.uid &&
          other.name == this.name);
}

class WorkoutPlansCompanion extends UpdateCompanion<WorkoutPlan> {
  final Value<String> uid;
  final Value<String> name;
  final Value<int> rowid;
  const WorkoutPlansCompanion({
    this.uid = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutPlansCompanion.insert({
    required String uid,
    required String name,
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        name = Value(name);
  static Insertable<WorkoutPlan> custom({
    Expression<String>? uid,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutPlansCompanion copyWith(
      {Value<String>? uid, Value<String>? name, Value<int>? rowid}) {
    return WorkoutPlansCompanion(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlansCompanion(')
          ..write('uid: $uid, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeksTable extends Weeks with TableInfo<$WeeksTable, Week> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutPlanUidMeta =
      const VerificationMeta('workoutPlanUid');
  @override
  late final GeneratedColumn<String> workoutPlanUid = GeneratedColumn<String>(
      'workout_plan_uid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workout_plans (uid)'));
  static const VerificationMeta _weekNumberMeta =
      const VerificationMeta('weekNumber');
  @override
  late final GeneratedColumn<int> weekNumber = GeneratedColumn<int>(
      'week_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, workoutPlanUid, weekNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weeks';
  @override
  VerificationContext validateIntegrity(Insertable<Week> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_plan_uid')) {
      context.handle(
          _workoutPlanUidMeta,
          workoutPlanUid.isAcceptableOrUnknown(
              data['workout_plan_uid']!, _workoutPlanUidMeta));
    } else if (isInserting) {
      context.missing(_workoutPlanUidMeta);
    }
    if (data.containsKey('week_number')) {
      context.handle(
          _weekNumberMeta,
          weekNumber.isAcceptableOrUnknown(
              data['week_number']!, _weekNumberMeta));
    } else if (isInserting) {
      context.missing(_weekNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Week map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Week(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workoutPlanUid: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}workout_plan_uid'])!,
      weekNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}week_number'])!,
    );
  }

  @override
  $WeeksTable createAlias(String alias) {
    return $WeeksTable(attachedDatabase, alias);
  }
}

class Week extends DataClass implements Insertable<Week> {
  final int id;
  final String workoutPlanUid;
  final int weekNumber;
  const Week(
      {required this.id,
      required this.workoutPlanUid,
      required this.weekNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['workout_plan_uid'] = Variable<String>(workoutPlanUid);
    map['week_number'] = Variable<int>(weekNumber);
    return map;
  }

  WeeksCompanion toCompanion(bool nullToAbsent) {
    return WeeksCompanion(
      id: Value(id),
      workoutPlanUid: Value(workoutPlanUid),
      weekNumber: Value(weekNumber),
    );
  }

  factory Week.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Week(
      id: serializer.fromJson<int>(json['id']),
      workoutPlanUid: serializer.fromJson<String>(json['workoutPlanUid']),
      weekNumber: serializer.fromJson<int>(json['weekNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workoutPlanUid': serializer.toJson<String>(workoutPlanUid),
      'weekNumber': serializer.toJson<int>(weekNumber),
    };
  }

  Week copyWith({int? id, String? workoutPlanUid, int? weekNumber}) => Week(
        id: id ?? this.id,
        workoutPlanUid: workoutPlanUid ?? this.workoutPlanUid,
        weekNumber: weekNumber ?? this.weekNumber,
      );
  Week copyWithCompanion(WeeksCompanion data) {
    return Week(
      id: data.id.present ? data.id.value : this.id,
      workoutPlanUid: data.workoutPlanUid.present
          ? data.workoutPlanUid.value
          : this.workoutPlanUid,
      weekNumber:
          data.weekNumber.present ? data.weekNumber.value : this.weekNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Week(')
          ..write('id: $id, ')
          ..write('workoutPlanUid: $workoutPlanUid, ')
          ..write('weekNumber: $weekNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workoutPlanUid, weekNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Week &&
          other.id == this.id &&
          other.workoutPlanUid == this.workoutPlanUid &&
          other.weekNumber == this.weekNumber);
}

class WeeksCompanion extends UpdateCompanion<Week> {
  final Value<int> id;
  final Value<String> workoutPlanUid;
  final Value<int> weekNumber;
  const WeeksCompanion({
    this.id = const Value.absent(),
    this.workoutPlanUid = const Value.absent(),
    this.weekNumber = const Value.absent(),
  });
  WeeksCompanion.insert({
    this.id = const Value.absent(),
    required String workoutPlanUid,
    required int weekNumber,
  })  : workoutPlanUid = Value(workoutPlanUid),
        weekNumber = Value(weekNumber);
  static Insertable<Week> custom({
    Expression<int>? id,
    Expression<String>? workoutPlanUid,
    Expression<int>? weekNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutPlanUid != null) 'workout_plan_uid': workoutPlanUid,
      if (weekNumber != null) 'week_number': weekNumber,
    });
  }

  WeeksCompanion copyWith(
      {Value<int>? id, Value<String>? workoutPlanUid, Value<int>? weekNumber}) {
    return WeeksCompanion(
      id: id ?? this.id,
      workoutPlanUid: workoutPlanUid ?? this.workoutPlanUid,
      weekNumber: weekNumber ?? this.weekNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workoutPlanUid.present) {
      map['workout_plan_uid'] = Variable<String>(workoutPlanUid.value);
    }
    if (weekNumber.present) {
      map['week_number'] = Variable<int>(weekNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeksCompanion(')
          ..write('id: $id, ')
          ..write('workoutPlanUid: $workoutPlanUid, ')
          ..write('weekNumber: $weekNumber')
          ..write(')'))
        .toString();
  }
}

class $DaysTable extends Days with TableInfo<$DaysTable, Day> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _weekUidMeta =
      const VerificationMeta('weekUid');
  @override
  late final GeneratedColumn<int> weekUid = GeneratedColumn<int>(
      'week_uid', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES weeks (id)'));
  static const VerificationMeta _dayNumberMeta =
      const VerificationMeta('dayNumber');
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
      'day_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, weekUid, dayNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'days';
  @override
  VerificationContext validateIntegrity(Insertable<Day> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('week_uid')) {
      context.handle(_weekUidMeta,
          weekUid.isAcceptableOrUnknown(data['week_uid']!, _weekUidMeta));
    } else if (isInserting) {
      context.missing(_weekUidMeta);
    }
    if (data.containsKey('day_number')) {
      context.handle(_dayNumberMeta,
          dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta));
    } else if (isInserting) {
      context.missing(_dayNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Day map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Day(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      weekUid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}week_uid'])!,
      dayNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_number'])!,
    );
  }

  @override
  $DaysTable createAlias(String alias) {
    return $DaysTable(attachedDatabase, alias);
  }
}

class Day extends DataClass implements Insertable<Day> {
  final int id;
  final int weekUid;
  final int dayNumber;
  const Day({required this.id, required this.weekUid, required this.dayNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['week_uid'] = Variable<int>(weekUid);
    map['day_number'] = Variable<int>(dayNumber);
    return map;
  }

  DaysCompanion toCompanion(bool nullToAbsent) {
    return DaysCompanion(
      id: Value(id),
      weekUid: Value(weekUid),
      dayNumber: Value(dayNumber),
    );
  }

  factory Day.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Day(
      id: serializer.fromJson<int>(json['id']),
      weekUid: serializer.fromJson<int>(json['weekUid']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'weekUid': serializer.toJson<int>(weekUid),
      'dayNumber': serializer.toJson<int>(dayNumber),
    };
  }

  Day copyWith({int? id, int? weekUid, int? dayNumber}) => Day(
        id: id ?? this.id,
        weekUid: weekUid ?? this.weekUid,
        dayNumber: dayNumber ?? this.dayNumber,
      );
  Day copyWithCompanion(DaysCompanion data) {
    return Day(
      id: data.id.present ? data.id.value : this.id,
      weekUid: data.weekUid.present ? data.weekUid.value : this.weekUid,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Day(')
          ..write('id: $id, ')
          ..write('weekUid: $weekUid, ')
          ..write('dayNumber: $dayNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, weekUid, dayNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Day &&
          other.id == this.id &&
          other.weekUid == this.weekUid &&
          other.dayNumber == this.dayNumber);
}

class DaysCompanion extends UpdateCompanion<Day> {
  final Value<int> id;
  final Value<int> weekUid;
  final Value<int> dayNumber;
  const DaysCompanion({
    this.id = const Value.absent(),
    this.weekUid = const Value.absent(),
    this.dayNumber = const Value.absent(),
  });
  DaysCompanion.insert({
    this.id = const Value.absent(),
    required int weekUid,
    required int dayNumber,
  })  : weekUid = Value(weekUid),
        dayNumber = Value(dayNumber);
  static Insertable<Day> custom({
    Expression<int>? id,
    Expression<int>? weekUid,
    Expression<int>? dayNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekUid != null) 'week_uid': weekUid,
      if (dayNumber != null) 'day_number': dayNumber,
    });
  }

  DaysCompanion copyWith(
      {Value<int>? id, Value<int>? weekUid, Value<int>? dayNumber}) {
    return DaysCompanion(
      id: id ?? this.id,
      weekUid: weekUid ?? this.weekUid,
      dayNumber: dayNumber ?? this.dayNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (weekUid.present) {
      map['week_uid'] = Variable<int>(weekUid.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DaysCompanion(')
          ..write('id: $id, ')
          ..write('weekUid: $weekUid, ')
          ..write('dayNumber: $dayNumber')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dayUidMeta = const VerificationMeta('dayUid');
  @override
  late final GeneratedColumn<int> dayUid = GeneratedColumn<int>(
      'day_uid', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES days (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<int> code = GeneratedColumn<int>(
      'code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, dayUid, name, code];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<Exercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day_uid')) {
      context.handle(_dayUidMeta,
          dayUid.isAcceptableOrUnknown(data['day_uid']!, _dayUidMeta));
    } else if (isInserting) {
      context.missing(_dayUidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dayUid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_uid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}code'])!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final int dayUid;
  final String name;
  final int code;
  const Exercise(
      {required this.id,
      required this.dayUid,
      required this.name,
      required this.code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day_uid'] = Variable<int>(dayUid);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<int>(code);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      dayUid: Value(dayUid),
      name: Value(name),
      code: Value(code),
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      dayUid: serializer.fromJson<int>(json['dayUid']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<int>(json['code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dayUid': serializer.toJson<int>(dayUid),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<int>(code),
    };
  }

  Exercise copyWith({int? id, int? dayUid, String? name, int? code}) =>
      Exercise(
        id: id ?? this.id,
        dayUid: dayUid ?? this.dayUid,
        name: name ?? this.name,
        code: code ?? this.code,
      );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      dayUid: data.dayUid.present ? data.dayUid.value : this.dayUid,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('dayUid: $dayUid, ')
          ..write('name: $name, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dayUid, name, code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.dayUid == this.dayUid &&
          other.name == this.name &&
          other.code == this.code);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<int> dayUid;
  final Value<String> name;
  final Value<int> code;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.dayUid = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int dayUid,
    required String name,
    required int code,
  })  : dayUid = Value(dayUid),
        name = Value(name),
        code = Value(code);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<int>? dayUid,
    Expression<String>? name,
    Expression<int>? code,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayUid != null) 'day_uid': dayUid,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
    });
  }

  ExercisesCompanion copyWith(
      {Value<int>? id,
      Value<int>? dayUid,
      Value<String>? name,
      Value<int>? code}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      dayUid: dayUid ?? this.dayUid,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dayUid.present) {
      map['day_uid'] = Variable<int>(dayUid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<int>(code.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('dayUid: $dayUid, ')
          ..write('name: $name, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetsTable extends ExerciseSets
    with TableInfo<$ExerciseSetsTable, ExerciseSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _exerciseUidMeta =
      const VerificationMeta('exerciseUid');
  @override
  late final GeneratedColumn<int> exerciseUid = GeneratedColumn<int>(
      'exercise_uid', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exercises (id)'));
  static const VerificationMeta _targetRepsMeta =
      const VerificationMeta('targetReps');
  @override
  late final GeneratedColumn<int> targetReps = GeneratedColumn<int>(
      'target_reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _targetWeightMeta =
      const VerificationMeta('targetWeight');
  @override
  late final GeneratedColumn<double> targetWeight = GeneratedColumn<double>(
      'target_weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetDistanceMeta =
      const VerificationMeta('targetDistance');
  @override
  late final GeneratedColumn<double> targetDistance = GeneratedColumn<double>(
      'target_distance', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetTimeMeta =
      const VerificationMeta('targetTime');
  @override
  late final GeneratedColumn<int> targetTime = GeneratedColumn<int>(
      'target_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _actualRepsMeta =
      const VerificationMeta('actualReps');
  @override
  late final GeneratedColumn<int> actualReps = GeneratedColumn<int>(
      'actual_reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _actualWeightMeta =
      const VerificationMeta('actualWeight');
  @override
  late final GeneratedColumn<double> actualWeight = GeneratedColumn<double>(
      'actual_weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _actualDistanceMeta =
      const VerificationMeta('actualDistance');
  @override
  late final GeneratedColumn<double> actualDistance = GeneratedColumn<double>(
      'actual_distance', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _actualTimeMeta =
      const VerificationMeta('actualTime');
  @override
  late final GeneratedColumn<int> actualTime = GeneratedColumn<int>(
      'actual_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        exerciseUid,
        targetReps,
        targetWeight,
        targetDistance,
        targetTime,
        actualReps,
        actualWeight,
        actualDistance,
        actualTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_sets';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_uid')) {
      context.handle(
          _exerciseUidMeta,
          exerciseUid.isAcceptableOrUnknown(
              data['exercise_uid']!, _exerciseUidMeta));
    } else if (isInserting) {
      context.missing(_exerciseUidMeta);
    }
    if (data.containsKey('target_reps')) {
      context.handle(
          _targetRepsMeta,
          targetReps.isAcceptableOrUnknown(
              data['target_reps']!, _targetRepsMeta));
    }
    if (data.containsKey('target_weight')) {
      context.handle(
          _targetWeightMeta,
          targetWeight.isAcceptableOrUnknown(
              data['target_weight']!, _targetWeightMeta));
    }
    if (data.containsKey('target_distance')) {
      context.handle(
          _targetDistanceMeta,
          targetDistance.isAcceptableOrUnknown(
              data['target_distance']!, _targetDistanceMeta));
    }
    if (data.containsKey('target_time')) {
      context.handle(
          _targetTimeMeta,
          targetTime.isAcceptableOrUnknown(
              data['target_time']!, _targetTimeMeta));
    }
    if (data.containsKey('actual_reps')) {
      context.handle(
          _actualRepsMeta,
          actualReps.isAcceptableOrUnknown(
              data['actual_reps']!, _actualRepsMeta));
    }
    if (data.containsKey('actual_weight')) {
      context.handle(
          _actualWeightMeta,
          actualWeight.isAcceptableOrUnknown(
              data['actual_weight']!, _actualWeightMeta));
    }
    if (data.containsKey('actual_distance')) {
      context.handle(
          _actualDistanceMeta,
          actualDistance.isAcceptableOrUnknown(
              data['actual_distance']!, _actualDistanceMeta));
    }
    if (data.containsKey('actual_time')) {
      context.handle(
          _actualTimeMeta,
          actualTime.isAcceptableOrUnknown(
              data['actual_time']!, _actualTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exerciseUid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_uid'])!,
      targetReps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_reps']),
      targetWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_weight']),
      targetDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_distance']),
      targetTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_time']),
      actualReps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_reps']),
      actualWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_weight']),
      actualDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_distance']),
      actualTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_time']),
    );
  }

  @override
  $ExerciseSetsTable createAlias(String alias) {
    return $ExerciseSetsTable(attachedDatabase, alias);
  }
}

class ExerciseSet extends DataClass implements Insertable<ExerciseSet> {
  final int id;
  final int exerciseUid;
  final int? targetReps;
  final double? targetWeight;
  final double? targetDistance;
  final int? targetTime;
  final int? actualReps;
  final double? actualWeight;
  final double? actualDistance;
  final int? actualTime;
  const ExerciseSet(
      {required this.id,
      required this.exerciseUid,
      this.targetReps,
      this.targetWeight,
      this.targetDistance,
      this.targetTime,
      this.actualReps,
      this.actualWeight,
      this.actualDistance,
      this.actualTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_uid'] = Variable<int>(exerciseUid);
    if (!nullToAbsent || targetReps != null) {
      map['target_reps'] = Variable<int>(targetReps);
    }
    if (!nullToAbsent || targetWeight != null) {
      map['target_weight'] = Variable<double>(targetWeight);
    }
    if (!nullToAbsent || targetDistance != null) {
      map['target_distance'] = Variable<double>(targetDistance);
    }
    if (!nullToAbsent || targetTime != null) {
      map['target_time'] = Variable<int>(targetTime);
    }
    if (!nullToAbsent || actualReps != null) {
      map['actual_reps'] = Variable<int>(actualReps);
    }
    if (!nullToAbsent || actualWeight != null) {
      map['actual_weight'] = Variable<double>(actualWeight);
    }
    if (!nullToAbsent || actualDistance != null) {
      map['actual_distance'] = Variable<double>(actualDistance);
    }
    if (!nullToAbsent || actualTime != null) {
      map['actual_time'] = Variable<int>(actualTime);
    }
    return map;
  }

  ExerciseSetsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetsCompanion(
      id: Value(id),
      exerciseUid: Value(exerciseUid),
      targetReps: targetReps == null && nullToAbsent
          ? const Value.absent()
          : Value(targetReps),
      targetWeight: targetWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(targetWeight),
      targetDistance: targetDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDistance),
      targetTime: targetTime == null && nullToAbsent
          ? const Value.absent()
          : Value(targetTime),
      actualReps: actualReps == null && nullToAbsent
          ? const Value.absent()
          : Value(actualReps),
      actualWeight: actualWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(actualWeight),
      actualDistance: actualDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDistance),
      actualTime: actualTime == null && nullToAbsent
          ? const Value.absent()
          : Value(actualTime),
    );
  }

  factory ExerciseSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSet(
      id: serializer.fromJson<int>(json['id']),
      exerciseUid: serializer.fromJson<int>(json['exerciseUid']),
      targetReps: serializer.fromJson<int?>(json['targetReps']),
      targetWeight: serializer.fromJson<double?>(json['targetWeight']),
      targetDistance: serializer.fromJson<double?>(json['targetDistance']),
      targetTime: serializer.fromJson<int?>(json['targetTime']),
      actualReps: serializer.fromJson<int?>(json['actualReps']),
      actualWeight: serializer.fromJson<double?>(json['actualWeight']),
      actualDistance: serializer.fromJson<double?>(json['actualDistance']),
      actualTime: serializer.fromJson<int?>(json['actualTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseUid': serializer.toJson<int>(exerciseUid),
      'targetReps': serializer.toJson<int?>(targetReps),
      'targetWeight': serializer.toJson<double?>(targetWeight),
      'targetDistance': serializer.toJson<double?>(targetDistance),
      'targetTime': serializer.toJson<int?>(targetTime),
      'actualReps': serializer.toJson<int?>(actualReps),
      'actualWeight': serializer.toJson<double?>(actualWeight),
      'actualDistance': serializer.toJson<double?>(actualDistance),
      'actualTime': serializer.toJson<int?>(actualTime),
    };
  }

  ExerciseSet copyWith(
          {int? id,
          int? exerciseUid,
          Value<int?> targetReps = const Value.absent(),
          Value<double?> targetWeight = const Value.absent(),
          Value<double?> targetDistance = const Value.absent(),
          Value<int?> targetTime = const Value.absent(),
          Value<int?> actualReps = const Value.absent(),
          Value<double?> actualWeight = const Value.absent(),
          Value<double?> actualDistance = const Value.absent(),
          Value<int?> actualTime = const Value.absent()}) =>
      ExerciseSet(
        id: id ?? this.id,
        exerciseUid: exerciseUid ?? this.exerciseUid,
        targetReps: targetReps.present ? targetReps.value : this.targetReps,
        targetWeight:
            targetWeight.present ? targetWeight.value : this.targetWeight,
        targetDistance:
            targetDistance.present ? targetDistance.value : this.targetDistance,
        targetTime: targetTime.present ? targetTime.value : this.targetTime,
        actualReps: actualReps.present ? actualReps.value : this.actualReps,
        actualWeight:
            actualWeight.present ? actualWeight.value : this.actualWeight,
        actualDistance:
            actualDistance.present ? actualDistance.value : this.actualDistance,
        actualTime: actualTime.present ? actualTime.value : this.actualTime,
      );
  ExerciseSet copyWithCompanion(ExerciseSetsCompanion data) {
    return ExerciseSet(
      id: data.id.present ? data.id.value : this.id,
      exerciseUid:
          data.exerciseUid.present ? data.exerciseUid.value : this.exerciseUid,
      targetReps:
          data.targetReps.present ? data.targetReps.value : this.targetReps,
      targetWeight: data.targetWeight.present
          ? data.targetWeight.value
          : this.targetWeight,
      targetDistance: data.targetDistance.present
          ? data.targetDistance.value
          : this.targetDistance,
      targetTime:
          data.targetTime.present ? data.targetTime.value : this.targetTime,
      actualReps:
          data.actualReps.present ? data.actualReps.value : this.actualReps,
      actualWeight: data.actualWeight.present
          ? data.actualWeight.value
          : this.actualWeight,
      actualDistance: data.actualDistance.present
          ? data.actualDistance.value
          : this.actualDistance,
      actualTime:
          data.actualTime.present ? data.actualTime.value : this.actualTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSet(')
          ..write('id: $id, ')
          ..write('exerciseUid: $exerciseUid, ')
          ..write('targetReps: $targetReps, ')
          ..write('targetWeight: $targetWeight, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('targetTime: $targetTime, ')
          ..write('actualReps: $actualReps, ')
          ..write('actualWeight: $actualWeight, ')
          ..write('actualDistance: $actualDistance, ')
          ..write('actualTime: $actualTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      exerciseUid,
      targetReps,
      targetWeight,
      targetDistance,
      targetTime,
      actualReps,
      actualWeight,
      actualDistance,
      actualTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSet &&
          other.id == this.id &&
          other.exerciseUid == this.exerciseUid &&
          other.targetReps == this.targetReps &&
          other.targetWeight == this.targetWeight &&
          other.targetDistance == this.targetDistance &&
          other.targetTime == this.targetTime &&
          other.actualReps == this.actualReps &&
          other.actualWeight == this.actualWeight &&
          other.actualDistance == this.actualDistance &&
          other.actualTime == this.actualTime);
}

class ExerciseSetsCompanion extends UpdateCompanion<ExerciseSet> {
  final Value<int> id;
  final Value<int> exerciseUid;
  final Value<int?> targetReps;
  final Value<double?> targetWeight;
  final Value<double?> targetDistance;
  final Value<int?> targetTime;
  final Value<int?> actualReps;
  final Value<double?> actualWeight;
  final Value<double?> actualDistance;
  final Value<int?> actualTime;
  const ExerciseSetsCompanion({
    this.id = const Value.absent(),
    this.exerciseUid = const Value.absent(),
    this.targetReps = const Value.absent(),
    this.targetWeight = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.targetTime = const Value.absent(),
    this.actualReps = const Value.absent(),
    this.actualWeight = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.actualTime = const Value.absent(),
  });
  ExerciseSetsCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseUid,
    this.targetReps = const Value.absent(),
    this.targetWeight = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.targetTime = const Value.absent(),
    this.actualReps = const Value.absent(),
    this.actualWeight = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.actualTime = const Value.absent(),
  }) : exerciseUid = Value(exerciseUid);
  static Insertable<ExerciseSet> custom({
    Expression<int>? id,
    Expression<int>? exerciseUid,
    Expression<int>? targetReps,
    Expression<double>? targetWeight,
    Expression<double>? targetDistance,
    Expression<int>? targetTime,
    Expression<int>? actualReps,
    Expression<double>? actualWeight,
    Expression<double>? actualDistance,
    Expression<int>? actualTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseUid != null) 'exercise_uid': exerciseUid,
      if (targetReps != null) 'target_reps': targetReps,
      if (targetWeight != null) 'target_weight': targetWeight,
      if (targetDistance != null) 'target_distance': targetDistance,
      if (targetTime != null) 'target_time': targetTime,
      if (actualReps != null) 'actual_reps': actualReps,
      if (actualWeight != null) 'actual_weight': actualWeight,
      if (actualDistance != null) 'actual_distance': actualDistance,
      if (actualTime != null) 'actual_time': actualTime,
    });
  }

  ExerciseSetsCompanion copyWith(
      {Value<int>? id,
      Value<int>? exerciseUid,
      Value<int?>? targetReps,
      Value<double?>? targetWeight,
      Value<double?>? targetDistance,
      Value<int?>? targetTime,
      Value<int?>? actualReps,
      Value<double?>? actualWeight,
      Value<double?>? actualDistance,
      Value<int?>? actualTime}) {
    return ExerciseSetsCompanion(
      id: id ?? this.id,
      exerciseUid: exerciseUid ?? this.exerciseUid,
      targetReps: targetReps ?? this.targetReps,
      targetWeight: targetWeight ?? this.targetWeight,
      targetDistance: targetDistance ?? this.targetDistance,
      targetTime: targetTime ?? this.targetTime,
      actualReps: actualReps ?? this.actualReps,
      actualWeight: actualWeight ?? this.actualWeight,
      actualDistance: actualDistance ?? this.actualDistance,
      actualTime: actualTime ?? this.actualTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseUid.present) {
      map['exercise_uid'] = Variable<int>(exerciseUid.value);
    }
    if (targetReps.present) {
      map['target_reps'] = Variable<int>(targetReps.value);
    }
    if (targetWeight.present) {
      map['target_weight'] = Variable<double>(targetWeight.value);
    }
    if (targetDistance.present) {
      map['target_distance'] = Variable<double>(targetDistance.value);
    }
    if (targetTime.present) {
      map['target_time'] = Variable<int>(targetTime.value);
    }
    if (actualReps.present) {
      map['actual_reps'] = Variable<int>(actualReps.value);
    }
    if (actualWeight.present) {
      map['actual_weight'] = Variable<double>(actualWeight.value);
    }
    if (actualDistance.present) {
      map['actual_distance'] = Variable<double>(actualDistance.value);
    }
    if (actualTime.present) {
      map['actual_time'] = Variable<int>(actualTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseUid: $exerciseUid, ')
          ..write('targetReps: $targetReps, ')
          ..write('targetWeight: $targetWeight, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('targetTime: $targetTime, ')
          ..write('actualReps: $actualReps, ')
          ..write('actualWeight: $actualWeight, ')
          ..write('actualDistance: $actualDistance, ')
          ..write('actualTime: $actualTime')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _authIdMeta = const VerificationMeta('authId');
  @override
  late final GeneratedColumn<String> authId = GeneratedColumn<String>(
      'auth_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'PRIMARY KEY NOT NULL');
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightUnitMeta =
      const VerificationMeta('weightUnit');
  @override
  late final GeneratedColumn<String> weightUnit = GeneratedColumn<String>(
      'weight_unit', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _heightUnitMeta =
      const VerificationMeta('heightUnit');
  @override
  late final GeneratedColumn<String> heightUnit = GeneratedColumn<String>(
      'height_unit', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _isTrainerMeta =
      const VerificationMeta('isTrainer');
  @override
  late final GeneratedColumn<bool> isTrainer = GeneratedColumn<bool>(
      'is_trainer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_trainer" IN (0, 1))'));
  static const VerificationMeta _isUserActiveMeta =
      const VerificationMeta('isUserActive');
  @override
  late final GeneratedColumn<bool> isUserActive = GeneratedColumn<bool>(
      'is_user_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_user_active" IN (0, 1))'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currentWorkoutIdMeta =
      const VerificationMeta('currentWorkoutId');
  @override
  late final GeneratedColumn<String> currentWorkoutId = GeneratedColumn<String>(
      'current_workout_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        authId,
        age,
        gender,
        weight,
        weightUnit,
        height,
        heightUnit,
        isTrainer,
        isUserActive,
        username,
        email,
        phone,
        currentWorkoutId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(Insertable<Client> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('auth_id')) {
      context.handle(_authIdMeta,
          authId.isAcceptableOrUnknown(data['auth_id']!, _authIdMeta));
    } else if (isInserting) {
      context.missing(_authIdMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('weight_unit')) {
      context.handle(
          _weightUnitMeta,
          weightUnit.isAcceptableOrUnknown(
              data['weight_unit']!, _weightUnitMeta));
    } else if (isInserting) {
      context.missing(_weightUnitMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('height_unit')) {
      context.handle(
          _heightUnitMeta,
          heightUnit.isAcceptableOrUnknown(
              data['height_unit']!, _heightUnitMeta));
    } else if (isInserting) {
      context.missing(_heightUnitMeta);
    }
    if (data.containsKey('is_trainer')) {
      context.handle(_isTrainerMeta,
          isTrainer.isAcceptableOrUnknown(data['is_trainer']!, _isTrainerMeta));
    } else if (isInserting) {
      context.missing(_isTrainerMeta);
    }
    if (data.containsKey('is_user_active')) {
      context.handle(
          _isUserActiveMeta,
          isUserActive.isAcceptableOrUnknown(
              data['is_user_active']!, _isUserActiveMeta));
    } else if (isInserting) {
      context.missing(_isUserActiveMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('current_workout_id')) {
      context.handle(
          _currentWorkoutIdMeta,
          currentWorkoutId.isAcceptableOrUnknown(
              data['current_workout_id']!, _currentWorkoutIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {authId};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      authId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}auth_id'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
      weightUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weight_unit'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height'])!,
      heightUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}height_unit'])!,
      isTrainer: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_trainer'])!,
      isUserActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_user_active'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      currentWorkoutId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_workout_id']),
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final String authId;
  final int age;
  final String gender;
  final int weight;
  final String weightUnit;
  final int height;
  final String heightUnit;
  final bool isTrainer;
  final bool isUserActive;
  final String username;
  final String? email;
  final String? phone;
  final String? currentWorkoutId;
  const Client(
      {required this.authId,
      required this.age,
      required this.gender,
      required this.weight,
      required this.weightUnit,
      required this.height,
      required this.heightUnit,
      required this.isTrainer,
      required this.isUserActive,
      required this.username,
      this.email,
      this.phone,
      this.currentWorkoutId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['auth_id'] = Variable<String>(authId);
    map['age'] = Variable<int>(age);
    map['gender'] = Variable<String>(gender);
    map['weight'] = Variable<int>(weight);
    map['weight_unit'] = Variable<String>(weightUnit);
    map['height'] = Variable<int>(height);
    map['height_unit'] = Variable<String>(heightUnit);
    map['is_trainer'] = Variable<bool>(isTrainer);
    map['is_user_active'] = Variable<bool>(isUserActive);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || currentWorkoutId != null) {
      map['current_workout_id'] = Variable<String>(currentWorkoutId);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      authId: Value(authId),
      age: Value(age),
      gender: Value(gender),
      weight: Value(weight),
      weightUnit: Value(weightUnit),
      height: Value(height),
      heightUnit: Value(heightUnit),
      isTrainer: Value(isTrainer),
      isUserActive: Value(isUserActive),
      username: Value(username),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      currentWorkoutId: currentWorkoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentWorkoutId),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      authId: serializer.fromJson<String>(json['authId']),
      age: serializer.fromJson<int>(json['age']),
      gender: serializer.fromJson<String>(json['gender']),
      weight: serializer.fromJson<int>(json['weight']),
      weightUnit: serializer.fromJson<String>(json['weightUnit']),
      height: serializer.fromJson<int>(json['height']),
      heightUnit: serializer.fromJson<String>(json['heightUnit']),
      isTrainer: serializer.fromJson<bool>(json['isTrainer']),
      isUserActive: serializer.fromJson<bool>(json['isUserActive']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      currentWorkoutId: serializer.fromJson<String?>(json['currentWorkoutId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'authId': serializer.toJson<String>(authId),
      'age': serializer.toJson<int>(age),
      'gender': serializer.toJson<String>(gender),
      'weight': serializer.toJson<int>(weight),
      'weightUnit': serializer.toJson<String>(weightUnit),
      'height': serializer.toJson<int>(height),
      'heightUnit': serializer.toJson<String>(heightUnit),
      'isTrainer': serializer.toJson<bool>(isTrainer),
      'isUserActive': serializer.toJson<bool>(isUserActive),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'currentWorkoutId': serializer.toJson<String?>(currentWorkoutId),
    };
  }

  Client copyWith(
          {String? authId,
          int? age,
          String? gender,
          int? weight,
          String? weightUnit,
          int? height,
          String? heightUnit,
          bool? isTrainer,
          bool? isUserActive,
          String? username,
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> currentWorkoutId = const Value.absent()}) =>
      Client(
        authId: authId ?? this.authId,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        weight: weight ?? this.weight,
        weightUnit: weightUnit ?? this.weightUnit,
        height: height ?? this.height,
        heightUnit: heightUnit ?? this.heightUnit,
        isTrainer: isTrainer ?? this.isTrainer,
        isUserActive: isUserActive ?? this.isUserActive,
        username: username ?? this.username,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        currentWorkoutId: currentWorkoutId.present
            ? currentWorkoutId.value
            : this.currentWorkoutId,
      );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      authId: data.authId.present ? data.authId.value : this.authId,
      age: data.age.present ? data.age.value : this.age,
      gender: data.gender.present ? data.gender.value : this.gender,
      weight: data.weight.present ? data.weight.value : this.weight,
      weightUnit:
          data.weightUnit.present ? data.weightUnit.value : this.weightUnit,
      height: data.height.present ? data.height.value : this.height,
      heightUnit:
          data.heightUnit.present ? data.heightUnit.value : this.heightUnit,
      isTrainer: data.isTrainer.present ? data.isTrainer.value : this.isTrainer,
      isUserActive: data.isUserActive.present
          ? data.isUserActive.value
          : this.isUserActive,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      currentWorkoutId: data.currentWorkoutId.present
          ? data.currentWorkoutId.value
          : this.currentWorkoutId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('authId: $authId, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('weight: $weight, ')
          ..write('weightUnit: $weightUnit, ')
          ..write('height: $height, ')
          ..write('heightUnit: $heightUnit, ')
          ..write('isTrainer: $isTrainer, ')
          ..write('isUserActive: $isUserActive, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('currentWorkoutId: $currentWorkoutId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      authId,
      age,
      gender,
      weight,
      weightUnit,
      height,
      heightUnit,
      isTrainer,
      isUserActive,
      username,
      email,
      phone,
      currentWorkoutId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.authId == this.authId &&
          other.age == this.age &&
          other.gender == this.gender &&
          other.weight == this.weight &&
          other.weightUnit == this.weightUnit &&
          other.height == this.height &&
          other.heightUnit == this.heightUnit &&
          other.isTrainer == this.isTrainer &&
          other.isUserActive == this.isUserActive &&
          other.username == this.username &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.currentWorkoutId == this.currentWorkoutId);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<String> authId;
  final Value<int> age;
  final Value<String> gender;
  final Value<int> weight;
  final Value<String> weightUnit;
  final Value<int> height;
  final Value<String> heightUnit;
  final Value<bool> isTrainer;
  final Value<bool> isUserActive;
  final Value<String> username;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> currentWorkoutId;
  final Value<int> rowid;
  const ClientsCompanion({
    this.authId = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.weight = const Value.absent(),
    this.weightUnit = const Value.absent(),
    this.height = const Value.absent(),
    this.heightUnit = const Value.absent(),
    this.isTrainer = const Value.absent(),
    this.isUserActive = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.currentWorkoutId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsCompanion.insert({
    required String authId,
    required int age,
    required String gender,
    required int weight,
    required String weightUnit,
    required int height,
    required String heightUnit,
    required bool isTrainer,
    required bool isUserActive,
    required String username,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.currentWorkoutId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : authId = Value(authId),
        age = Value(age),
        gender = Value(gender),
        weight = Value(weight),
        weightUnit = Value(weightUnit),
        height = Value(height),
        heightUnit = Value(heightUnit),
        isTrainer = Value(isTrainer),
        isUserActive = Value(isUserActive),
        username = Value(username);
  static Insertable<Client> custom({
    Expression<String>? authId,
    Expression<int>? age,
    Expression<String>? gender,
    Expression<int>? weight,
    Expression<String>? weightUnit,
    Expression<int>? height,
    Expression<String>? heightUnit,
    Expression<bool>? isTrainer,
    Expression<bool>? isUserActive,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? currentWorkoutId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (authId != null) 'auth_id': authId,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (weight != null) 'weight': weight,
      if (weightUnit != null) 'weight_unit': weightUnit,
      if (height != null) 'height': height,
      if (heightUnit != null) 'height_unit': heightUnit,
      if (isTrainer != null) 'is_trainer': isTrainer,
      if (isUserActive != null) 'is_user_active': isUserActive,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (currentWorkoutId != null) 'current_workout_id': currentWorkoutId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsCompanion copyWith(
      {Value<String>? authId,
      Value<int>? age,
      Value<String>? gender,
      Value<int>? weight,
      Value<String>? weightUnit,
      Value<int>? height,
      Value<String>? heightUnit,
      Value<bool>? isTrainer,
      Value<bool>? isUserActive,
      Value<String>? username,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? currentWorkoutId,
      Value<int>? rowid}) {
    return ClientsCompanion(
      authId: authId ?? this.authId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      isTrainer: isTrainer ?? this.isTrainer,
      isUserActive: isUserActive ?? this.isUserActive,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      currentWorkoutId: currentWorkoutId ?? this.currentWorkoutId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (authId.present) {
      map['auth_id'] = Variable<String>(authId.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (weightUnit.present) {
      map['weight_unit'] = Variable<String>(weightUnit.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (heightUnit.present) {
      map['height_unit'] = Variable<String>(heightUnit.value);
    }
    if (isTrainer.present) {
      map['is_trainer'] = Variable<bool>(isTrainer.value);
    }
    if (isUserActive.present) {
      map['is_user_active'] = Variable<bool>(isUserActive.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (currentWorkoutId.present) {
      map['current_workout_id'] = Variable<String>(currentWorkoutId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('authId: $authId, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('weight: $weight, ')
          ..write('weightUnit: $weightUnit, ')
          ..write('height: $height, ')
          ..write('heightUnit: $heightUnit, ')
          ..write('isTrainer: $isTrainer, ')
          ..write('isUserActive: $isUserActive, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('currentWorkoutId: $currentWorkoutId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorkoutPlansTable workoutPlans = $WorkoutPlansTable(this);
  late final $WeeksTable weeks = $WeeksTable(this);
  late final $DaysTable days = $DaysTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ExerciseSetsTable exerciseSets = $ExerciseSetsTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [workoutPlans, weeks, days, exercises, exerciseSets, clients];
}

typedef $$WorkoutPlansTableCreateCompanionBuilder = WorkoutPlansCompanion
    Function({
  required String uid,
  required String name,
  Value<int> rowid,
});
typedef $$WorkoutPlansTableUpdateCompanionBuilder = WorkoutPlansCompanion
    Function({
  Value<String> uid,
  Value<String> name,
  Value<int> rowid,
});

final class $$WorkoutPlansTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutPlansTable, WorkoutPlan> {
  $$WorkoutPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WeeksTable, List<Week>> _weeksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.weeks,
          aliasName: $_aliasNameGenerator(
              db.workoutPlans.uid, db.weeks.workoutPlanUid));

  $$WeeksTableProcessedTableManager get weeksRefs {
    final manager = $$WeeksTableTableManager($_db, $_db.weeks)
        .filter((f) => f.workoutPlanUid.uid($_item.uid));

    final cache = $_typedResult.readTableOrNull(_weeksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutPlansTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTable> {
  $$WorkoutPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> weeksRefs(
      Expression<bool> Function($$WeeksTableFilterComposer f) f) {
    final $$WeeksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.workoutPlanUid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeeksTableFilterComposer(
              $db: $db,
              $table: $db.weeks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTable> {
  $$WorkoutPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTable> {
  $$WorkoutPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> weeksRefs<T extends Object>(
      Expression<T> Function($$WeeksTableAnnotationComposer a) f) {
    final $$WeeksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.workoutPlanUid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeeksTableAnnotationComposer(
              $db: $db,
              $table: $db.weeks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutPlansTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutPlansTable,
    WorkoutPlan,
    $$WorkoutPlansTableFilterComposer,
    $$WorkoutPlansTableOrderingComposer,
    $$WorkoutPlansTableAnnotationComposer,
    $$WorkoutPlansTableCreateCompanionBuilder,
    $$WorkoutPlansTableUpdateCompanionBuilder,
    (WorkoutPlan, $$WorkoutPlansTableReferences),
    WorkoutPlan,
    PrefetchHooks Function({bool weeksRefs})> {
  $$WorkoutPlansTableTableManager(_$AppDatabase db, $WorkoutPlansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlansCompanion(
            uid: uid,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlansCompanion.insert(
            uid: uid,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutPlansTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({weeksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (weeksRefs) db.weeks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (weeksRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$WorkoutPlansTableReferences._weeksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutPlansTableReferences(db, table, p0)
                                .weeksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutPlanUid == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutPlansTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutPlansTable,
    WorkoutPlan,
    $$WorkoutPlansTableFilterComposer,
    $$WorkoutPlansTableOrderingComposer,
    $$WorkoutPlansTableAnnotationComposer,
    $$WorkoutPlansTableCreateCompanionBuilder,
    $$WorkoutPlansTableUpdateCompanionBuilder,
    (WorkoutPlan, $$WorkoutPlansTableReferences),
    WorkoutPlan,
    PrefetchHooks Function({bool weeksRefs})>;
typedef $$WeeksTableCreateCompanionBuilder = WeeksCompanion Function({
  Value<int> id,
  required String workoutPlanUid,
  required int weekNumber,
});
typedef $$WeeksTableUpdateCompanionBuilder = WeeksCompanion Function({
  Value<int> id,
  Value<String> workoutPlanUid,
  Value<int> weekNumber,
});

final class $$WeeksTableReferences
    extends BaseReferences<_$AppDatabase, $WeeksTable, Week> {
  $$WeeksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutPlansTable _workoutPlanUidTable(_$AppDatabase db) =>
      db.workoutPlans.createAlias(
          $_aliasNameGenerator(db.weeks.workoutPlanUid, db.workoutPlans.uid));

  $$WorkoutPlansTableProcessedTableManager? get workoutPlanUid {
    if ($_item.workoutPlanUid == null) return null;
    final manager = $$WorkoutPlansTableTableManager($_db, $_db.workoutPlans)
        .filter((f) => f.uid($_item.workoutPlanUid!));
    final item = $_typedResult.readTableOrNull(_workoutPlanUidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DaysTable, List<Day>> _daysRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.days,
          aliasName: $_aliasNameGenerator(db.weeks.id, db.days.weekUid));

  $$DaysTableProcessedTableManager get daysRefs {
    final manager = $$DaysTableTableManager($_db, $_db.days)
        .filter((f) => f.weekUid.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_daysRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WeeksTableFilterComposer extends Composer<_$AppDatabase, $WeeksTable> {
  $$WeeksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => ColumnFilters(column));

  $$WorkoutPlansTableFilterComposer get workoutPlanUid {
    final $$WorkoutPlansTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutPlanUid,
        referencedTable: $db.workoutPlans,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlansTableFilterComposer(
              $db: $db,
              $table: $db.workoutPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> daysRefs(
      Expression<bool> Function($$DaysTableFilterComposer f) f) {
    final $$DaysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.days,
        getReferencedColumn: (t) => t.weekUid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DaysTableFilterComposer(
              $db: $db,
              $table: $db.days,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WeeksTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeksTable> {
  $$WeeksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => ColumnOrderings(column));

  $$WorkoutPlansTableOrderingComposer get workoutPlanUid {
    final $$WorkoutPlansTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutPlanUid,
        referencedTable: $db.workoutPlans,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlansTableOrderingComposer(
              $db: $db,
              $table: $db.workoutPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeeksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeksTable> {
  $$WeeksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => column);

  $$WorkoutPlansTableAnnotationComposer get workoutPlanUid {
    final $$WorkoutPlansTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutPlanUid,
        referencedTable: $db.workoutPlans,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlansTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> daysRefs<T extends Object>(
      Expression<T> Function($$DaysTableAnnotationComposer a) f) {
    final $$DaysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.days,
        getReferencedColumn: (t) => t.weekUid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DaysTableAnnotationComposer(
              $db: $db,
              $table: $db.days,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WeeksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeeksTable,
    Week,
    $$WeeksTableFilterComposer,
    $$WeeksTableOrderingComposer,
    $$WeeksTableAnnotationComposer,
    $$WeeksTableCreateCompanionBuilder,
    $$WeeksTableUpdateCompanionBuilder,
    (Week, $$WeeksTableReferences),
    Week,
    PrefetchHooks Function({bool workoutPlanUid, bool daysRefs})> {
  $$WeeksTableTableManager(_$AppDatabase db, $WeeksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> workoutPlanUid = const Value.absent(),
            Value<int> weekNumber = const Value.absent(),
          }) =>
              WeeksCompanion(
            id: id,
            workoutPlanUid: workoutPlanUid,
            weekNumber: weekNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String workoutPlanUid,
            required int weekNumber,
          }) =>
              WeeksCompanion.insert(
            id: id,
            workoutPlanUid: workoutPlanUid,
            weekNumber: weekNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WeeksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({workoutPlanUid = false, daysRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (daysRefs) db.days],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutPlanUid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutPlanUid,
                    referencedTable:
                        $$WeeksTableReferences._workoutPlanUidTable(db),
                    referencedColumn:
                        $$WeeksTableReferences._workoutPlanUidTable(db).uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (daysRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$WeeksTableReferences._daysRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WeeksTableReferences(db, table, p0).daysRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.weekUid == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WeeksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeeksTable,
    Week,
    $$WeeksTableFilterComposer,
    $$WeeksTableOrderingComposer,
    $$WeeksTableAnnotationComposer,
    $$WeeksTableCreateCompanionBuilder,
    $$WeeksTableUpdateCompanionBuilder,
    (Week, $$WeeksTableReferences),
    Week,
    PrefetchHooks Function({bool workoutPlanUid, bool daysRefs})>;
typedef $$DaysTableCreateCompanionBuilder = DaysCompanion Function({
  Value<int> id,
  required int weekUid,
  required int dayNumber,
});
typedef $$DaysTableUpdateCompanionBuilder = DaysCompanion Function({
  Value<int> id,
  Value<int> weekUid,
  Value<int> dayNumber,
});

final class $$DaysTableReferences
    extends BaseReferences<_$AppDatabase, $DaysTable, Day> {
  $$DaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeeksTable _weekUidTable(_$AppDatabase db) =>
      db.weeks.createAlias($_aliasNameGenerator(db.days.weekUid, db.weeks.id));

  $$WeeksTableProcessedTableManager? get weekUid {
    if ($_item.weekUid == null) return null;
    final manager = $$WeeksTableTableManager($_db, $_db.weeks)
        .filter((f) => f.id($_item.weekUid!));
    final item = $_typedResult.readTableOrNull(_weekUidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExercisesTable, List<Exercise>>
      _exercisesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exercises,
              aliasName: $_aliasNameGenerator(db.days.id, db.exercises.dayUid));

  $$ExercisesTableProcessedTableManager get exercisesRefs {
    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.dayUid.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DaysTableFilterComposer extends Composer<_$AppDatabase, $DaysTable> {
  $$DaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayNumber => $composableBuilder(
      column: $table.dayNumber, builder: (column) => ColumnFilters(column));

  $$WeeksTableFilterComposer get weekUid {
    final $$WeeksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.weekUid,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeeksTableFilterComposer(
              $db: $db,
              $table: $db.weeks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> exercisesRefs(
      Expression<bool> Function($$ExercisesTableFilterComposer f) f) {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.dayUid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DaysTableOrderingComposer extends Composer<_$AppDatabase, $DaysTable> {
  $$DaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayNumber => $composableBuilder(
      column: $table.dayNumber, builder: (column) => ColumnOrderings(column));

  $$WeeksTableOrderingComposer get weekUid {
    final $$WeeksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.weekUid,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeeksTableOrderingComposer(
              $db: $db,
              $table: $db.weeks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $DaysTable> {
  $$DaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  $$WeeksTableAnnotationComposer get weekUid {
    final $$WeeksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.weekUid,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeeksTableAnnotationComposer(
              $db: $db,
              $table: $db.weeks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> exercisesRefs<T extends Object>(
      Expression<T> Function($$ExercisesTableAnnotationComposer a) f) {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.dayUid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DaysTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DaysTable,
    Day,
    $$DaysTableFilterComposer,
    $$DaysTableOrderingComposer,
    $$DaysTableAnnotationComposer,
    $$DaysTableCreateCompanionBuilder,
    $$DaysTableUpdateCompanionBuilder,
    (Day, $$DaysTableReferences),
    Day,
    PrefetchHooks Function({bool weekUid, bool exercisesRefs})> {
  $$DaysTableTableManager(_$AppDatabase db, $DaysTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> weekUid = const Value.absent(),
            Value<int> dayNumber = const Value.absent(),
          }) =>
              DaysCompanion(
            id: id,
            weekUid: weekUid,
            dayNumber: dayNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int weekUid,
            required int dayNumber,
          }) =>
              DaysCompanion.insert(
            id: id,
            weekUid: weekUid,
            dayNumber: dayNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DaysTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({weekUid = false, exercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (exercisesRefs) db.exercises],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (weekUid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.weekUid,
                    referencedTable: $$DaysTableReferences._weekUidTable(db),
                    referencedColumn:
                        $$DaysTableReferences._weekUidTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exercisesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$DaysTableReferences._exercisesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DaysTableReferences(db, table, p0).exercisesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dayUid == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DaysTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DaysTable,
    Day,
    $$DaysTableFilterComposer,
    $$DaysTableOrderingComposer,
    $$DaysTableAnnotationComposer,
    $$DaysTableCreateCompanionBuilder,
    $$DaysTableUpdateCompanionBuilder,
    (Day, $$DaysTableReferences),
    Day,
    PrefetchHooks Function({bool weekUid, bool exercisesRefs})>;
typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  required int dayUid,
  required String name,
  required int code,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  Value<int> dayUid,
  Value<String> name,
  Value<int> code,
});

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DaysTable _dayUidTable(_$AppDatabase db) => db.days
      .createAlias($_aliasNameGenerator(db.exercises.dayUid, db.days.id));

  $$DaysTableProcessedTableManager? get dayUid {
    if ($_item.dayUid == null) return null;
    final manager = $$DaysTableTableManager($_db, $_db.days)
        .filter((f) => f.id($_item.dayUid!));
    final item = $_typedResult.readTableOrNull(_dayUidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExerciseSetsTable, List<ExerciseSet>>
      _exerciseSetsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exerciseSets,
              aliasName: $_aliasNameGenerator(
                  db.exercises.id, db.exerciseSets.exerciseUid));

  $$ExerciseSetsTableProcessedTableManager get exerciseSetsRefs {
    final manager = $$ExerciseSetsTableTableManager($_db, $_db.exerciseSets)
        .filter((f) => f.exerciseUid.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_exerciseSetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  $$DaysTableFilterComposer get dayUid {
    final $$DaysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayUid,
        referencedTable: $db.days,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DaysTableFilterComposer(
              $db: $db,
              $table: $db.days,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> exerciseSetsRefs(
      Expression<bool> Function($$ExerciseSetsTableFilterComposer f) f) {
    final $$ExerciseSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseSets,
        getReferencedColumn: (t) => t.exerciseUid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSetsTableFilterComposer(
              $db: $db,
              $table: $db.exerciseSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  $$DaysTableOrderingComposer get dayUid {
    final $$DaysTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayUid,
        referencedTable: $db.days,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DaysTableOrderingComposer(
              $db: $db,
              $table: $db.days,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  $$DaysTableAnnotationComposer get dayUid {
    final $$DaysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayUid,
        referencedTable: $db.days,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DaysTableAnnotationComposer(
              $db: $db,
              $table: $db.days,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> exerciseSetsRefs<T extends Object>(
      Expression<T> Function($$ExerciseSetsTableAnnotationComposer a) f) {
    final $$ExerciseSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseSets,
        getReferencedColumn: (t) => t.exerciseUid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSetsTableAnnotationComposer(
              $db: $db,
              $table: $db.exerciseSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, $$ExercisesTableReferences),
    Exercise,
    PrefetchHooks Function({bool dayUid, bool exerciseSetsRefs})> {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dayUid = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> code = const Value.absent(),
          }) =>
              ExercisesCompanion(
            id: id,
            dayUid: dayUid,
            name: name,
            code: code,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dayUid,
            required String name,
            required int code,
          }) =>
              ExercisesCompanion.insert(
            id: id,
            dayUid: dayUid,
            name: name,
            code: code,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExercisesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dayUid = false, exerciseSetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (exerciseSetsRefs) db.exerciseSets],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (dayUid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dayUid,
                    referencedTable:
                        $$ExercisesTableReferences._dayUidTable(db),
                    referencedColumn:
                        $$ExercisesTableReferences._dayUidTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exerciseSetsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ExercisesTableReferences
                            ._exerciseSetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExercisesTableReferences(db, table, p0)
                                .exerciseSetsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseUid == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, $$ExercisesTableReferences),
    Exercise,
    PrefetchHooks Function({bool dayUid, bool exerciseSetsRefs})>;
typedef $$ExerciseSetsTableCreateCompanionBuilder = ExerciseSetsCompanion
    Function({
  Value<int> id,
  required int exerciseUid,
  Value<int?> targetReps,
  Value<double?> targetWeight,
  Value<double?> targetDistance,
  Value<int?> targetTime,
  Value<int?> actualReps,
  Value<double?> actualWeight,
  Value<double?> actualDistance,
  Value<int?> actualTime,
});
typedef $$ExerciseSetsTableUpdateCompanionBuilder = ExerciseSetsCompanion
    Function({
  Value<int> id,
  Value<int> exerciseUid,
  Value<int?> targetReps,
  Value<double?> targetWeight,
  Value<double?> targetDistance,
  Value<int?> targetTime,
  Value<int?> actualReps,
  Value<double?> actualWeight,
  Value<double?> actualDistance,
  Value<int?> actualTime,
});

final class $$ExerciseSetsTableReferences
    extends BaseReferences<_$AppDatabase, $ExerciseSetsTable, ExerciseSet> {
  $$ExerciseSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExercisesTable _exerciseUidTable(_$AppDatabase db) =>
      db.exercises.createAlias(
          $_aliasNameGenerator(db.exerciseSets.exerciseUid, db.exercises.id));

  $$ExercisesTableProcessedTableManager? get exerciseUid {
    if ($_item.exerciseUid == null) return null;
    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.id($_item.exerciseUid!));
    final item = $_typedResult.readTableOrNull(_exerciseUidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExerciseSetsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTable> {
  $$ExerciseSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetWeight => $composableBuilder(
      column: $table.targetWeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetTime => $composableBuilder(
      column: $table.targetTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualReps => $composableBuilder(
      column: $table.actualReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualWeight => $composableBuilder(
      column: $table.actualWeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualDistance => $composableBuilder(
      column: $table.actualDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualTime => $composableBuilder(
      column: $table.actualTime, builder: (column) => ColumnFilters(column));

  $$ExercisesTableFilterComposer get exerciseUid {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseUid,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTable> {
  $$ExerciseSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetWeight => $composableBuilder(
      column: $table.targetWeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetTime => $composableBuilder(
      column: $table.targetTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actualReps => $composableBuilder(
      column: $table.actualReps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualWeight => $composableBuilder(
      column: $table.actualWeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualDistance => $composableBuilder(
      column: $table.actualDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actualTime => $composableBuilder(
      column: $table.actualTime, builder: (column) => ColumnOrderings(column));

  $$ExercisesTableOrderingComposer get exerciseUid {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseUid,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableOrderingComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTable> {
  $$ExerciseSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => column);

  GeneratedColumn<double> get targetWeight => $composableBuilder(
      column: $table.targetWeight, builder: (column) => column);

  GeneratedColumn<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance, builder: (column) => column);

  GeneratedColumn<int> get targetTime => $composableBuilder(
      column: $table.targetTime, builder: (column) => column);

  GeneratedColumn<int> get actualReps => $composableBuilder(
      column: $table.actualReps, builder: (column) => column);

  GeneratedColumn<double> get actualWeight => $composableBuilder(
      column: $table.actualWeight, builder: (column) => column);

  GeneratedColumn<double> get actualDistance => $composableBuilder(
      column: $table.actualDistance, builder: (column) => column);

  GeneratedColumn<int> get actualTime => $composableBuilder(
      column: $table.actualTime, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseUid {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseUid,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseSetsTable,
    ExerciseSet,
    $$ExerciseSetsTableFilterComposer,
    $$ExerciseSetsTableOrderingComposer,
    $$ExerciseSetsTableAnnotationComposer,
    $$ExerciseSetsTableCreateCompanionBuilder,
    $$ExerciseSetsTableUpdateCompanionBuilder,
    (ExerciseSet, $$ExerciseSetsTableReferences),
    ExerciseSet,
    PrefetchHooks Function({bool exerciseUid})> {
  $$ExerciseSetsTableTableManager(_$AppDatabase db, $ExerciseSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> exerciseUid = const Value.absent(),
            Value<int?> targetReps = const Value.absent(),
            Value<double?> targetWeight = const Value.absent(),
            Value<double?> targetDistance = const Value.absent(),
            Value<int?> targetTime = const Value.absent(),
            Value<int?> actualReps = const Value.absent(),
            Value<double?> actualWeight = const Value.absent(),
            Value<double?> actualDistance = const Value.absent(),
            Value<int?> actualTime = const Value.absent(),
          }) =>
              ExerciseSetsCompanion(
            id: id,
            exerciseUid: exerciseUid,
            targetReps: targetReps,
            targetWeight: targetWeight,
            targetDistance: targetDistance,
            targetTime: targetTime,
            actualReps: actualReps,
            actualWeight: actualWeight,
            actualDistance: actualDistance,
            actualTime: actualTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int exerciseUid,
            Value<int?> targetReps = const Value.absent(),
            Value<double?> targetWeight = const Value.absent(),
            Value<double?> targetDistance = const Value.absent(),
            Value<int?> targetTime = const Value.absent(),
            Value<int?> actualReps = const Value.absent(),
            Value<double?> actualWeight = const Value.absent(),
            Value<double?> actualDistance = const Value.absent(),
            Value<int?> actualTime = const Value.absent(),
          }) =>
              ExerciseSetsCompanion.insert(
            id: id,
            exerciseUid: exerciseUid,
            targetReps: targetReps,
            targetWeight: targetWeight,
            targetDistance: targetDistance,
            targetTime: targetTime,
            actualReps: actualReps,
            actualWeight: actualWeight,
            actualDistance: actualDistance,
            actualTime: actualTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExerciseSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({exerciseUid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (exerciseUid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseUid,
                    referencedTable:
                        $$ExerciseSetsTableReferences._exerciseUidTable(db),
                    referencedColumn:
                        $$ExerciseSetsTableReferences._exerciseUidTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExerciseSetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseSetsTable,
    ExerciseSet,
    $$ExerciseSetsTableFilterComposer,
    $$ExerciseSetsTableOrderingComposer,
    $$ExerciseSetsTableAnnotationComposer,
    $$ExerciseSetsTableCreateCompanionBuilder,
    $$ExerciseSetsTableUpdateCompanionBuilder,
    (ExerciseSet, $$ExerciseSetsTableReferences),
    ExerciseSet,
    PrefetchHooks Function({bool exerciseUid})>;
typedef $$ClientsTableCreateCompanionBuilder = ClientsCompanion Function({
  required String authId,
  required int age,
  required String gender,
  required int weight,
  required String weightUnit,
  required int height,
  required String heightUnit,
  required bool isTrainer,
  required bool isUserActive,
  required String username,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> currentWorkoutId,
  Value<int> rowid,
});
typedef $$ClientsTableUpdateCompanionBuilder = ClientsCompanion Function({
  Value<String> authId,
  Value<int> age,
  Value<String> gender,
  Value<int> weight,
  Value<String> weightUnit,
  Value<int> height,
  Value<String> heightUnit,
  Value<bool> isTrainer,
  Value<bool> isUserActive,
  Value<String> username,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> currentWorkoutId,
  Value<int> rowid,
});

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get authId => $composableBuilder(
      column: $table.authId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weightUnit => $composableBuilder(
      column: $table.weightUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get heightUnit => $composableBuilder(
      column: $table.heightUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isTrainer => $composableBuilder(
      column: $table.isTrainer, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isUserActive => $composableBuilder(
      column: $table.isUserActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentWorkoutId => $composableBuilder(
      column: $table.currentWorkoutId,
      builder: (column) => ColumnFilters(column));
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get authId => $composableBuilder(
      column: $table.authId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weightUnit => $composableBuilder(
      column: $table.weightUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get heightUnit => $composableBuilder(
      column: $table.heightUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isTrainer => $composableBuilder(
      column: $table.isTrainer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isUserActive => $composableBuilder(
      column: $table.isUserActive,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentWorkoutId => $composableBuilder(
      column: $table.currentWorkoutId,
      builder: (column) => ColumnOrderings(column));
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get authId =>
      $composableBuilder(column: $table.authId, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get weightUnit => $composableBuilder(
      column: $table.weightUnit, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get heightUnit => $composableBuilder(
      column: $table.heightUnit, builder: (column) => column);

  GeneratedColumn<bool> get isTrainer =>
      $composableBuilder(column: $table.isTrainer, builder: (column) => column);

  GeneratedColumn<bool> get isUserActive => $composableBuilder(
      column: $table.isUserActive, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get currentWorkoutId => $composableBuilder(
      column: $table.currentWorkoutId, builder: (column) => column);
}

class $$ClientsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientsTable,
    Client,
    $$ClientsTableFilterComposer,
    $$ClientsTableOrderingComposer,
    $$ClientsTableAnnotationComposer,
    $$ClientsTableCreateCompanionBuilder,
    $$ClientsTableUpdateCompanionBuilder,
    (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
    Client,
    PrefetchHooks Function()> {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> authId = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<int> weight = const Value.absent(),
            Value<String> weightUnit = const Value.absent(),
            Value<int> height = const Value.absent(),
            Value<String> heightUnit = const Value.absent(),
            Value<bool> isTrainer = const Value.absent(),
            Value<bool> isUserActive = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> currentWorkoutId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientsCompanion(
            authId: authId,
            age: age,
            gender: gender,
            weight: weight,
            weightUnit: weightUnit,
            height: height,
            heightUnit: heightUnit,
            isTrainer: isTrainer,
            isUserActive: isUserActive,
            username: username,
            email: email,
            phone: phone,
            currentWorkoutId: currentWorkoutId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String authId,
            required int age,
            required String gender,
            required int weight,
            required String weightUnit,
            required int height,
            required String heightUnit,
            required bool isTrainer,
            required bool isUserActive,
            required String username,
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> currentWorkoutId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientsCompanion.insert(
            authId: authId,
            age: age,
            gender: gender,
            weight: weight,
            weightUnit: weightUnit,
            height: height,
            heightUnit: heightUnit,
            isTrainer: isTrainer,
            isUserActive: isUserActive,
            username: username,
            email: email,
            phone: phone,
            currentWorkoutId: currentWorkoutId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClientsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientsTable,
    Client,
    $$ClientsTableFilterComposer,
    $$ClientsTableOrderingComposer,
    $$ClientsTableAnnotationComposer,
    $$ClientsTableCreateCompanionBuilder,
    $$ClientsTableUpdateCompanionBuilder,
    (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
    Client,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorkoutPlansTableTableManager get workoutPlans =>
      $$WorkoutPlansTableTableManager(_db, _db.workoutPlans);
  $$WeeksTableTableManager get weeks =>
      $$WeeksTableTableManager(_db, _db.weeks);
  $$DaysTableTableManager get days => $$DaysTableTableManager(_db, _db.days);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$ExerciseSetsTableTableManager get exerciseSets =>
      $$ExerciseSetsTableTableManager(_db, _db.exerciseSets);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
}
