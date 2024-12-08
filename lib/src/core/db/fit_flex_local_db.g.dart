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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().millisecondsSinceEpoch));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [uid, name, createdAt, updatedAt];
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
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
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
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
  final int createdAt;
  final int? updatedAt;
  const WorkoutPlan(
      {required this.uid,
      required this.name,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  WorkoutPlansCompanion toCompanion(bool nullToAbsent) {
    return WorkoutPlansCompanion(
      uid: Value(uid),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory WorkoutPlan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutPlan(
      uid: serializer.fromJson<String>(json['uid']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  WorkoutPlan copyWith(
          {String? uid,
          String? name,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      WorkoutPlan(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  WorkoutPlan copyWithCompanion(WorkoutPlansCompanion data) {
    return WorkoutPlan(
      uid: data.uid.present ? data.uid.value : this.uid,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlan(')
          ..write('uid: $uid, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutPlan &&
          other.uid == this.uid &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutPlansCompanion extends UpdateCompanion<WorkoutPlan> {
  final Value<String> uid;
  final Value<String> name;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const WorkoutPlansCompanion({
    this.uid = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutPlansCompanion.insert({
    required String uid,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        name = Value(name);
  static Insertable<WorkoutPlan> custom({
    Expression<String>? uid,
    Expression<String>? name,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutPlansCompanion copyWith(
      {Value<String>? uid,
      Value<String>? name,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return WorkoutPlansCompanion(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workoutPlanIdMeta =
      const VerificationMeta('workoutPlanId');
  @override
  late final GeneratedColumn<String> workoutPlanId = GeneratedColumn<String>(
      'workout_plan_id', aliasedName, false,
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
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().millisecondsSinceEpoch));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workoutPlanId, weekNumber, createdAt, updatedAt];
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workout_plan_id')) {
      context.handle(
          _workoutPlanIdMeta,
          workoutPlanId.isAcceptableOrUnknown(
              data['workout_plan_id']!, _workoutPlanIdMeta));
    } else if (isInserting) {
      context.missing(_workoutPlanIdMeta);
    }
    if (data.containsKey('week_number')) {
      context.handle(
          _weekNumberMeta,
          weekNumber.isAcceptableOrUnknown(
              data['week_number']!, _weekNumberMeta));
    } else if (isInserting) {
      context.missing(_weekNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
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
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workoutPlanId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}workout_plan_id'])!,
      weekNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}week_number'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $WeeksTable createAlias(String alias) {
    return $WeeksTable(attachedDatabase, alias);
  }
}

class Week extends DataClass implements Insertable<Week> {
  final String id;
  final String workoutPlanId;
  final int weekNumber;
  final int createdAt;
  final int? updatedAt;
  const Week(
      {required this.id,
      required this.workoutPlanId,
      required this.weekNumber,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_plan_id'] = Variable<String>(workoutPlanId);
    map['week_number'] = Variable<int>(weekNumber);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  WeeksCompanion toCompanion(bool nullToAbsent) {
    return WeeksCompanion(
      id: Value(id),
      workoutPlanId: Value(workoutPlanId),
      weekNumber: Value(weekNumber),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Week.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Week(
      id: serializer.fromJson<String>(json['id']),
      workoutPlanId: serializer.fromJson<String>(json['workoutPlanId']),
      weekNumber: serializer.fromJson<int>(json['weekNumber']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workoutPlanId': serializer.toJson<String>(workoutPlanId),
      'weekNumber': serializer.toJson<int>(weekNumber),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  Week copyWith(
          {String? id,
          String? workoutPlanId,
          int? weekNumber,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      Week(
        id: id ?? this.id,
        workoutPlanId: workoutPlanId ?? this.workoutPlanId,
        weekNumber: weekNumber ?? this.weekNumber,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Week copyWithCompanion(WeeksCompanion data) {
    return Week(
      id: data.id.present ? data.id.value : this.id,
      workoutPlanId: data.workoutPlanId.present
          ? data.workoutPlanId.value
          : this.workoutPlanId,
      weekNumber:
          data.weekNumber.present ? data.weekNumber.value : this.weekNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Week(')
          ..write('id: $id, ')
          ..write('workoutPlanId: $workoutPlanId, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workoutPlanId, weekNumber, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Week &&
          other.id == this.id &&
          other.workoutPlanId == this.workoutPlanId &&
          other.weekNumber == this.weekNumber &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WeeksCompanion extends UpdateCompanion<Week> {
  final Value<String> id;
  final Value<String> workoutPlanId;
  final Value<int> weekNumber;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const WeeksCompanion({
    this.id = const Value.absent(),
    this.workoutPlanId = const Value.absent(),
    this.weekNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeksCompanion.insert({
    required String id,
    required String workoutPlanId,
    required int weekNumber,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workoutPlanId = Value(workoutPlanId),
        weekNumber = Value(weekNumber);
  static Insertable<Week> custom({
    Expression<String>? id,
    Expression<String>? workoutPlanId,
    Expression<int>? weekNumber,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutPlanId != null) 'workout_plan_id': workoutPlanId,
      if (weekNumber != null) 'week_number': weekNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeksCompanion copyWith(
      {Value<String>? id,
      Value<String>? workoutPlanId,
      Value<int>? weekNumber,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return WeeksCompanion(
      id: id ?? this.id,
      workoutPlanId: workoutPlanId ?? this.workoutPlanId,
      weekNumber: weekNumber ?? this.weekNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workoutPlanId.present) {
      map['workout_plan_id'] = Variable<String>(workoutPlanId.value);
    }
    if (weekNumber.present) {
      map['week_number'] = Variable<int>(weekNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeksCompanion(')
          ..write('id: $id, ')
          ..write('workoutPlanId: $workoutPlanId, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weekIdMeta = const VerificationMeta('weekId');
  @override
  late final GeneratedColumn<String> weekId = GeneratedColumn<String>(
      'week_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES weeks (id)'));
  static const VerificationMeta _dayNumberMeta =
      const VerificationMeta('dayNumber');
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
      'day_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().millisecondsSinceEpoch));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, weekId, dayNumber, createdAt, updatedAt];
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('week_id')) {
      context.handle(_weekIdMeta,
          weekId.isAcceptableOrUnknown(data['week_id']!, _weekIdMeta));
    } else if (isInserting) {
      context.missing(_weekIdMeta);
    }
    if (data.containsKey('day_number')) {
      context.handle(_dayNumberMeta,
          dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta));
    } else if (isInserting) {
      context.missing(_dayNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
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
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      weekId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}week_id'])!,
      dayNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_number'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $DaysTable createAlias(String alias) {
    return $DaysTable(attachedDatabase, alias);
  }
}

class Day extends DataClass implements Insertable<Day> {
  final String id;
  final String weekId;
  final int dayNumber;
  final int createdAt;
  final int? updatedAt;
  const Day(
      {required this.id,
      required this.weekId,
      required this.dayNumber,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['week_id'] = Variable<String>(weekId);
    map['day_number'] = Variable<int>(dayNumber);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  DaysCompanion toCompanion(bool nullToAbsent) {
    return DaysCompanion(
      id: Value(id),
      weekId: Value(weekId),
      dayNumber: Value(dayNumber),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Day.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Day(
      id: serializer.fromJson<String>(json['id']),
      weekId: serializer.fromJson<String>(json['weekId']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'weekId': serializer.toJson<String>(weekId),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  Day copyWith(
          {String? id,
          String? weekId,
          int? dayNumber,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      Day(
        id: id ?? this.id,
        weekId: weekId ?? this.weekId,
        dayNumber: dayNumber ?? this.dayNumber,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Day copyWithCompanion(DaysCompanion data) {
    return Day(
      id: data.id.present ? data.id.value : this.id,
      weekId: data.weekId.present ? data.weekId.value : this.weekId,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Day(')
          ..write('id: $id, ')
          ..write('weekId: $weekId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, weekId, dayNumber, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Day &&
          other.id == this.id &&
          other.weekId == this.weekId &&
          other.dayNumber == this.dayNumber &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DaysCompanion extends UpdateCompanion<Day> {
  final Value<String> id;
  final Value<String> weekId;
  final Value<int> dayNumber;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const DaysCompanion({
    this.id = const Value.absent(),
    this.weekId = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DaysCompanion.insert({
    required String id,
    required String weekId,
    required int dayNumber,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        weekId = Value(weekId),
        dayNumber = Value(dayNumber);
  static Insertable<Day> custom({
    Expression<String>? id,
    Expression<String>? weekId,
    Expression<int>? dayNumber,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekId != null) 'week_id': weekId,
      if (dayNumber != null) 'day_number': dayNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DaysCompanion copyWith(
      {Value<String>? id,
      Value<String>? weekId,
      Value<int>? dayNumber,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return DaysCompanion(
      id: id ?? this.id,
      weekId: weekId ?? this.weekId,
      dayNumber: dayNumber ?? this.dayNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (weekId.present) {
      map['week_id'] = Variable<String>(weekId.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DaysCompanion(')
          ..write('id: $id, ')
          ..write('weekId: $weekId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutPlanExerciseTable extends WorkoutPlanExercise
    with TableInfo<$WorkoutPlanExerciseTable, WorkoutPlanExerciseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutPlanExerciseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dayIdMeta = const VerificationMeta('dayId');
  @override
  late final GeneratedColumn<String> dayId = GeneratedColumn<String>(
      'day_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES days (id)'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseOrderMeta =
      const VerificationMeta('exerciseOrder');
  @override
  late final GeneratedColumn<int> exerciseOrder = GeneratedColumn<int>(
      'exercise_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().millisecondsSinceEpoch));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, dayId, code, exerciseOrder, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_plan_exercise';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkoutPlanExerciseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('day_id')) {
      context.handle(
          _dayIdMeta, dayId.isAcceptableOrUnknown(data['day_id']!, _dayIdMeta));
    } else if (isInserting) {
      context.missing(_dayIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('exercise_order')) {
      context.handle(
          _exerciseOrderMeta,
          exerciseOrder.isAcceptableOrUnknown(
              data['exercise_order']!, _exerciseOrderMeta));
    } else if (isInserting) {
      context.missing(_exerciseOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutPlanExerciseData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutPlanExerciseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      dayId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      exerciseOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $WorkoutPlanExerciseTable createAlias(String alias) {
    return $WorkoutPlanExerciseTable(attachedDatabase, alias);
  }
}

class WorkoutPlanExerciseData extends DataClass
    implements Insertable<WorkoutPlanExerciseData> {
  final String id;
  final String dayId;
  final String code;
  final int exerciseOrder;
  final int createdAt;
  final int? updatedAt;
  const WorkoutPlanExerciseData(
      {required this.id,
      required this.dayId,
      required this.code,
      required this.exerciseOrder,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['day_id'] = Variable<String>(dayId);
    map['code'] = Variable<String>(code);
    map['exercise_order'] = Variable<int>(exerciseOrder);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  WorkoutPlanExerciseCompanion toCompanion(bool nullToAbsent) {
    return WorkoutPlanExerciseCompanion(
      id: Value(id),
      dayId: Value(dayId),
      code: Value(code),
      exerciseOrder: Value(exerciseOrder),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory WorkoutPlanExerciseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutPlanExerciseData(
      id: serializer.fromJson<String>(json['id']),
      dayId: serializer.fromJson<String>(json['dayId']),
      code: serializer.fromJson<String>(json['code']),
      exerciseOrder: serializer.fromJson<int>(json['exerciseOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dayId': serializer.toJson<String>(dayId),
      'code': serializer.toJson<String>(code),
      'exerciseOrder': serializer.toJson<int>(exerciseOrder),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  WorkoutPlanExerciseData copyWith(
          {String? id,
          String? dayId,
          String? code,
          int? exerciseOrder,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      WorkoutPlanExerciseData(
        id: id ?? this.id,
        dayId: dayId ?? this.dayId,
        code: code ?? this.code,
        exerciseOrder: exerciseOrder ?? this.exerciseOrder,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  WorkoutPlanExerciseData copyWithCompanion(WorkoutPlanExerciseCompanion data) {
    return WorkoutPlanExerciseData(
      id: data.id.present ? data.id.value : this.id,
      dayId: data.dayId.present ? data.dayId.value : this.dayId,
      code: data.code.present ? data.code.value : this.code,
      exerciseOrder: data.exerciseOrder.present
          ? data.exerciseOrder.value
          : this.exerciseOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlanExerciseData(')
          ..write('id: $id, ')
          ..write('dayId: $dayId, ')
          ..write('code: $code, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dayId, code, exerciseOrder, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutPlanExerciseData &&
          other.id == this.id &&
          other.dayId == this.dayId &&
          other.code == this.code &&
          other.exerciseOrder == this.exerciseOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutPlanExerciseCompanion
    extends UpdateCompanion<WorkoutPlanExerciseData> {
  final Value<String> id;
  final Value<String> dayId;
  final Value<String> code;
  final Value<int> exerciseOrder;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const WorkoutPlanExerciseCompanion({
    this.id = const Value.absent(),
    this.dayId = const Value.absent(),
    this.code = const Value.absent(),
    this.exerciseOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutPlanExerciseCompanion.insert({
    required String id,
    required String dayId,
    required String code,
    required int exerciseOrder,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        dayId = Value(dayId),
        code = Value(code),
        exerciseOrder = Value(exerciseOrder);
  static Insertable<WorkoutPlanExerciseData> custom({
    Expression<String>? id,
    Expression<String>? dayId,
    Expression<String>? code,
    Expression<int>? exerciseOrder,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayId != null) 'day_id': dayId,
      if (code != null) 'code': code,
      if (exerciseOrder != null) 'exercise_order': exerciseOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutPlanExerciseCompanion copyWith(
      {Value<String>? id,
      Value<String>? dayId,
      Value<String>? code,
      Value<int>? exerciseOrder,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return WorkoutPlanExerciseCompanion(
      id: id ?? this.id,
      dayId: dayId ?? this.dayId,
      code: code ?? this.code,
      exerciseOrder: exerciseOrder ?? this.exerciseOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dayId.present) {
      map['day_id'] = Variable<String>(dayId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (exerciseOrder.present) {
      map['exercise_order'] = Variable<int>(exerciseOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlanExerciseCompanion(')
          ..write('id: $id, ')
          ..write('dayId: $dayId, ')
          ..write('code: $code, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_plan_exercise (id)'));
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
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().millisecondsSinceEpoch));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _setNumberMeta =
      const VerificationMeta('setNumber');
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        exerciseId,
        targetReps,
        targetWeight,
        targetDistance,
        targetTime,
        createdAt,
        updatedAt,
        setNumber
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('set_number')) {
      context.handle(_setNumberMeta,
          setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta));
    } else if (isInserting) {
      context.missing(_setNumberMeta);
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
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_id'])!,
      targetReps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_reps']),
      targetWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_weight']),
      targetDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_distance']),
      targetTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_time']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
      setNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_number'])!,
    );
  }

  @override
  $ExerciseSetsTable createAlias(String alias) {
    return $ExerciseSetsTable(attachedDatabase, alias);
  }
}

class ExerciseSet extends DataClass implements Insertable<ExerciseSet> {
  final String id;
  final String exerciseId;
  final int? targetReps;
  final double? targetWeight;
  final double? targetDistance;
  final int? targetTime;
  final int createdAt;
  final int? updatedAt;
  final int setNumber;
  const ExerciseSet(
      {required this.id,
      required this.exerciseId,
      this.targetReps,
      this.targetWeight,
      this.targetDistance,
      this.targetTime,
      required this.createdAt,
      this.updatedAt,
      required this.setNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
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
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    map['set_number'] = Variable<int>(setNumber);
    return map;
  }

  ExerciseSetsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
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
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      setNumber: Value(setNumber),
    );
  }

  factory ExerciseSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSet(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      targetReps: serializer.fromJson<int?>(json['targetReps']),
      targetWeight: serializer.fromJson<double?>(json['targetWeight']),
      targetDistance: serializer.fromJson<double?>(json['targetDistance']),
      targetTime: serializer.fromJson<int?>(json['targetTime']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'targetReps': serializer.toJson<int?>(targetReps),
      'targetWeight': serializer.toJson<double?>(targetWeight),
      'targetDistance': serializer.toJson<double?>(targetDistance),
      'targetTime': serializer.toJson<int?>(targetTime),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
      'setNumber': serializer.toJson<int>(setNumber),
    };
  }

  ExerciseSet copyWith(
          {String? id,
          String? exerciseId,
          Value<int?> targetReps = const Value.absent(),
          Value<double?> targetWeight = const Value.absent(),
          Value<double?> targetDistance = const Value.absent(),
          Value<int?> targetTime = const Value.absent(),
          int? createdAt,
          Value<int?> updatedAt = const Value.absent(),
          int? setNumber}) =>
      ExerciseSet(
        id: id ?? this.id,
        exerciseId: exerciseId ?? this.exerciseId,
        targetReps: targetReps.present ? targetReps.value : this.targetReps,
        targetWeight:
            targetWeight.present ? targetWeight.value : this.targetWeight,
        targetDistance:
            targetDistance.present ? targetDistance.value : this.targetDistance,
        targetTime: targetTime.present ? targetTime.value : this.targetTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        setNumber: setNumber ?? this.setNumber,
      );
  ExerciseSet copyWithCompanion(ExerciseSetsCompanion data) {
    return ExerciseSet(
      id: data.id.present ? data.id.value : this.id,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
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
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSet(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('targetReps: $targetReps, ')
          ..write('targetWeight: $targetWeight, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('targetTime: $targetTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('setNumber: $setNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, targetReps, targetWeight,
      targetDistance, targetTime, createdAt, updatedAt, setNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSet &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.targetReps == this.targetReps &&
          other.targetWeight == this.targetWeight &&
          other.targetDistance == this.targetDistance &&
          other.targetTime == this.targetTime &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.setNumber == this.setNumber);
}

class ExerciseSetsCompanion extends UpdateCompanion<ExerciseSet> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<int?> targetReps;
  final Value<double?> targetWeight;
  final Value<double?> targetDistance;
  final Value<int?> targetTime;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> setNumber;
  final Value<int> rowid;
  const ExerciseSetsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.targetReps = const Value.absent(),
    this.targetWeight = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.targetTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseSetsCompanion.insert({
    required String id,
    required String exerciseId,
    this.targetReps = const Value.absent(),
    this.targetWeight = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.targetTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int setNumber,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        exerciseId = Value(exerciseId),
        setNumber = Value(setNumber);
  static Insertable<ExerciseSet> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<int>? targetReps,
    Expression<double>? targetWeight,
    Expression<double>? targetDistance,
    Expression<int>? targetTime,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? setNumber,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (targetReps != null) 'target_reps': targetReps,
      if (targetWeight != null) 'target_weight': targetWeight,
      if (targetDistance != null) 'target_distance': targetDistance,
      if (targetTime != null) 'target_time': targetTime,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (setNumber != null) 'set_number': setNumber,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseSetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? exerciseId,
      Value<int?>? targetReps,
      Value<double?>? targetWeight,
      Value<double?>? targetDistance,
      Value<int?>? targetTime,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? setNumber,
      Value<int>? rowid}) {
    return ExerciseSetsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      targetReps: targetReps ?? this.targetReps,
      targetWeight: targetWeight ?? this.targetWeight,
      targetDistance: targetDistance ?? this.targetDistance,
      targetTime: targetTime ?? this.targetTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      setNumber: setNumber ?? this.setNumber,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
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
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('targetReps: $targetReps, ')
          ..write('targetWeight: $targetWeight, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('targetTime: $targetTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('setNumber: $setNumber, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BaseExerciseTable extends BaseExercise
    with TableInfo<$BaseExerciseTable, BaseExerciseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BaseExerciseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _muscleGroupMeta =
      const VerificationMeta('muscleGroup');
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
      'muscle_group', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<bool> reps = GeneratedColumn<bool>(
      'reps', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("reps" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<bool> duration = GeneratedColumn<bool>(
      'duration', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("duration" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<bool> weight = GeneratedColumn<bool>(
      'weight', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("weight" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().millisecondsSinceEpoch));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        category,
        muscleGroup,
        name,
        reps,
        duration,
        weight,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'base_exercise';
  @override
  VerificationContext validateIntegrity(Insertable<BaseExerciseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
          _muscleGroupMeta,
          muscleGroup.isAcceptableOrUnknown(
              data['muscle_group']!, _muscleGroupMeta));
    } else if (isInserting) {
      context.missing(_muscleGroupMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BaseExerciseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BaseExerciseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      muscleGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}muscle_group'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}reps'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}duration'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}weight'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $BaseExerciseTable createAlias(String alias) {
    return $BaseExerciseTable(attachedDatabase, alias);
  }
}

class BaseExerciseData extends DataClass
    implements Insertable<BaseExerciseData> {
  final String id;
  final String code;
  final String? category;
  final String muscleGroup;
  final String name;
  final bool reps;
  final bool duration;
  final bool weight;
  final int createdAt;
  final int? updatedAt;
  const BaseExerciseData(
      {required this.id,
      required this.code,
      this.category,
      required this.muscleGroup,
      required this.name,
      required this.reps,
      required this.duration,
      required this.weight,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['muscle_group'] = Variable<String>(muscleGroup);
    map['name'] = Variable<String>(name);
    map['reps'] = Variable<bool>(reps);
    map['duration'] = Variable<bool>(duration);
    map['weight'] = Variable<bool>(weight);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  BaseExerciseCompanion toCompanion(bool nullToAbsent) {
    return BaseExerciseCompanion(
      id: Value(id),
      code: Value(code),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      muscleGroup: Value(muscleGroup),
      name: Value(name),
      reps: Value(reps),
      duration: Value(duration),
      weight: Value(weight),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory BaseExerciseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BaseExerciseData(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      category: serializer.fromJson<String?>(json['category']),
      muscleGroup: serializer.fromJson<String>(json['muscleGroup']),
      name: serializer.fromJson<String>(json['name']),
      reps: serializer.fromJson<bool>(json['reps']),
      duration: serializer.fromJson<bool>(json['duration']),
      weight: serializer.fromJson<bool>(json['weight']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'category': serializer.toJson<String?>(category),
      'muscleGroup': serializer.toJson<String>(muscleGroup),
      'name': serializer.toJson<String>(name),
      'reps': serializer.toJson<bool>(reps),
      'duration': serializer.toJson<bool>(duration),
      'weight': serializer.toJson<bool>(weight),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  BaseExerciseData copyWith(
          {String? id,
          String? code,
          Value<String?> category = const Value.absent(),
          String? muscleGroup,
          String? name,
          bool? reps,
          bool? duration,
          bool? weight,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      BaseExerciseData(
        id: id ?? this.id,
        code: code ?? this.code,
        category: category.present ? category.value : this.category,
        muscleGroup: muscleGroup ?? this.muscleGroup,
        name: name ?? this.name,
        reps: reps ?? this.reps,
        duration: duration ?? this.duration,
        weight: weight ?? this.weight,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  BaseExerciseData copyWithCompanion(BaseExerciseCompanion data) {
    return BaseExerciseData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      category: data.category.present ? data.category.value : this.category,
      muscleGroup:
          data.muscleGroup.present ? data.muscleGroup.value : this.muscleGroup,
      name: data.name.present ? data.name.value : this.name,
      reps: data.reps.present ? data.reps.value : this.reps,
      duration: data.duration.present ? data.duration.value : this.duration,
      weight: data.weight.present ? data.weight.value : this.weight,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BaseExerciseData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('category: $category, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('name: $name, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration, ')
          ..write('weight: $weight, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, category, muscleGroup, name, reps,
      duration, weight, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BaseExerciseData &&
          other.id == this.id &&
          other.code == this.code &&
          other.category == this.category &&
          other.muscleGroup == this.muscleGroup &&
          other.name == this.name &&
          other.reps == this.reps &&
          other.duration == this.duration &&
          other.weight == this.weight &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BaseExerciseCompanion extends UpdateCompanion<BaseExerciseData> {
  final Value<String> id;
  final Value<String> code;
  final Value<String?> category;
  final Value<String> muscleGroup;
  final Value<String> name;
  final Value<bool> reps;
  final Value<bool> duration;
  final Value<bool> weight;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const BaseExerciseCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.category = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.name = const Value.absent(),
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
    this.weight = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BaseExerciseCompanion.insert({
    required String id,
    required String code,
    this.category = const Value.absent(),
    required String muscleGroup,
    required String name,
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
    this.weight = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        code = Value(code),
        muscleGroup = Value(muscleGroup),
        name = Value(name);
  static Insertable<BaseExerciseData> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? category,
    Expression<String>? muscleGroup,
    Expression<String>? name,
    Expression<bool>? reps,
    Expression<bool>? duration,
    Expression<bool>? weight,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (category != null) 'category': category,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (name != null) 'name': name,
      if (reps != null) 'reps': reps,
      if (duration != null) 'duration': duration,
      if (weight != null) 'weight': weight,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BaseExerciseCompanion copyWith(
      {Value<String>? id,
      Value<String>? code,
      Value<String?>? category,
      Value<String>? muscleGroup,
      Value<String>? name,
      Value<bool>? reps,
      Value<bool>? duration,
      Value<bool>? weight,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return BaseExerciseCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      category: category ?? this.category,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      name: name ?? this.name,
      reps: reps ?? this.reps,
      duration: duration ?? this.duration,
      weight: weight ?? this.weight,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (reps.present) {
      map['reps'] = Variable<bool>(reps.value);
    }
    if (duration.present) {
      map['duration'] = Variable<bool>(duration.value);
    }
    if (weight.present) {
      map['weight'] = Variable<bool>(weight.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BaseExerciseCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('category: $category, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('name: $name, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration, ')
          ..write('weight: $weight, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightUnitMeta =
      const VerificationMeta('weightUnit');
  @override
  late final GeneratedColumn<String> weightUnit = GeneratedColumn<String>(
      'weight_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _heightUnitMeta =
      const VerificationMeta('heightUnit');
  @override
  late final GeneratedColumn<String> heightUnit = GeneratedColumn<String>(
      'height_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const VerificationMeta _phoneCountryCodeMeta =
      const VerificationMeta('phoneCountryCode');
  @override
  late final GeneratedColumn<String> phoneCountryCode = GeneratedColumn<String>(
      'phone_country_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currentWorkoutIdMeta =
      const VerificationMeta('currentWorkoutId');
  @override
  late final GeneratedColumn<String> currentWorkoutId = GeneratedColumn<String>(
      'current_workout_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
        phoneCountryCode,
        currentWorkoutId,
        createdAt,
        updatedAt
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
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('weight_unit')) {
      context.handle(
          _weightUnitMeta,
          weightUnit.isAcceptableOrUnknown(
              data['weight_unit']!, _weightUnitMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('height_unit')) {
      context.handle(
          _heightUnitMeta,
          heightUnit.isAcceptableOrUnknown(
              data['height_unit']!, _heightUnitMeta));
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
    if (data.containsKey('phone_country_code')) {
      context.handle(
          _phoneCountryCodeMeta,
          phoneCountryCode.isAcceptableOrUnknown(
              data['phone_country_code']!, _phoneCountryCodeMeta));
    }
    if (data.containsKey('current_workout_id')) {
      context.handle(
          _currentWorkoutIdMeta,
          currentWorkoutId.isAcceptableOrUnknown(
              data['current_workout_id']!, _currentWorkoutIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
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
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight']),
      weightUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weight_unit']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height']),
      heightUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}height_unit']),
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
      phoneCountryCode: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}phone_country_code']),
      currentWorkoutId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_workout_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final String authId;
  final int? age;
  final String? gender;
  final int? weight;
  final String? weightUnit;
  final int? height;
  final String? heightUnit;
  final bool isTrainer;
  final bool isUserActive;
  final String username;
  final String? email;
  final String? phone;
  final String? phoneCountryCode;
  final String? currentWorkoutId;
  final int createdAt;
  final int? updatedAt;
  const Client(
      {required this.authId,
      this.age,
      this.gender,
      this.weight,
      this.weightUnit,
      this.height,
      this.heightUnit,
      required this.isTrainer,
      required this.isUserActive,
      required this.username,
      this.email,
      this.phone,
      this.phoneCountryCode,
      this.currentWorkoutId,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['auth_id'] = Variable<String>(authId);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || weightUnit != null) {
      map['weight_unit'] = Variable<String>(weightUnit);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || heightUnit != null) {
      map['height_unit'] = Variable<String>(heightUnit);
    }
    map['is_trainer'] = Variable<bool>(isTrainer);
    map['is_user_active'] = Variable<bool>(isUserActive);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || phoneCountryCode != null) {
      map['phone_country_code'] = Variable<String>(phoneCountryCode);
    }
    if (!nullToAbsent || currentWorkoutId != null) {
      map['current_workout_id'] = Variable<String>(currentWorkoutId);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      authId: Value(authId),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      weightUnit: weightUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(weightUnit),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      heightUnit: heightUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(heightUnit),
      isTrainer: Value(isTrainer),
      isUserActive: Value(isUserActive),
      username: Value(username),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      phoneCountryCode: phoneCountryCode == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneCountryCode),
      currentWorkoutId: currentWorkoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentWorkoutId),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      authId: serializer.fromJson<String>(json['authId']),
      age: serializer.fromJson<int?>(json['age']),
      gender: serializer.fromJson<String?>(json['gender']),
      weight: serializer.fromJson<int?>(json['weight']),
      weightUnit: serializer.fromJson<String?>(json['weightUnit']),
      height: serializer.fromJson<int?>(json['height']),
      heightUnit: serializer.fromJson<String?>(json['heightUnit']),
      isTrainer: serializer.fromJson<bool>(json['isTrainer']),
      isUserActive: serializer.fromJson<bool>(json['isUserActive']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      phoneCountryCode: serializer.fromJson<String?>(json['phoneCountryCode']),
      currentWorkoutId: serializer.fromJson<String?>(json['currentWorkoutId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'authId': serializer.toJson<String>(authId),
      'age': serializer.toJson<int?>(age),
      'gender': serializer.toJson<String?>(gender),
      'weight': serializer.toJson<int?>(weight),
      'weightUnit': serializer.toJson<String?>(weightUnit),
      'height': serializer.toJson<int?>(height),
      'heightUnit': serializer.toJson<String?>(heightUnit),
      'isTrainer': serializer.toJson<bool>(isTrainer),
      'isUserActive': serializer.toJson<bool>(isUserActive),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'phoneCountryCode': serializer.toJson<String?>(phoneCountryCode),
      'currentWorkoutId': serializer.toJson<String?>(currentWorkoutId),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  Client copyWith(
          {String? authId,
          Value<int?> age = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<int?> weight = const Value.absent(),
          Value<String?> weightUnit = const Value.absent(),
          Value<int?> height = const Value.absent(),
          Value<String?> heightUnit = const Value.absent(),
          bool? isTrainer,
          bool? isUserActive,
          String? username,
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> phoneCountryCode = const Value.absent(),
          Value<String?> currentWorkoutId = const Value.absent(),
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      Client(
        authId: authId ?? this.authId,
        age: age.present ? age.value : this.age,
        gender: gender.present ? gender.value : this.gender,
        weight: weight.present ? weight.value : this.weight,
        weightUnit: weightUnit.present ? weightUnit.value : this.weightUnit,
        height: height.present ? height.value : this.height,
        heightUnit: heightUnit.present ? heightUnit.value : this.heightUnit,
        isTrainer: isTrainer ?? this.isTrainer,
        isUserActive: isUserActive ?? this.isUserActive,
        username: username ?? this.username,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        phoneCountryCode: phoneCountryCode.present
            ? phoneCountryCode.value
            : this.phoneCountryCode,
        currentWorkoutId: currentWorkoutId.present
            ? currentWorkoutId.value
            : this.currentWorkoutId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
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
      phoneCountryCode: data.phoneCountryCode.present
          ? data.phoneCountryCode.value
          : this.phoneCountryCode,
      currentWorkoutId: data.currentWorkoutId.present
          ? data.currentWorkoutId.value
          : this.currentWorkoutId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
          ..write('phoneCountryCode: $phoneCountryCode, ')
          ..write('currentWorkoutId: $currentWorkoutId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
      phoneCountryCode,
      currentWorkoutId,
      createdAt,
      updatedAt);
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
          other.phoneCountryCode == this.phoneCountryCode &&
          other.currentWorkoutId == this.currentWorkoutId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<String> authId;
  final Value<int?> age;
  final Value<String?> gender;
  final Value<int?> weight;
  final Value<String?> weightUnit;
  final Value<int?> height;
  final Value<String?> heightUnit;
  final Value<bool> isTrainer;
  final Value<bool> isUserActive;
  final Value<String> username;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> phoneCountryCode;
  final Value<String?> currentWorkoutId;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
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
    this.phoneCountryCode = const Value.absent(),
    this.currentWorkoutId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsCompanion.insert({
    required String authId,
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.weight = const Value.absent(),
    this.weightUnit = const Value.absent(),
    this.height = const Value.absent(),
    this.heightUnit = const Value.absent(),
    required bool isTrainer,
    required bool isUserActive,
    required String username,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.phoneCountryCode = const Value.absent(),
    this.currentWorkoutId = const Value.absent(),
    required int createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : authId = Value(authId),
        isTrainer = Value(isTrainer),
        isUserActive = Value(isUserActive),
        username = Value(username),
        createdAt = Value(createdAt);
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
    Expression<String>? phoneCountryCode,
    Expression<String>? currentWorkoutId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
      if (phoneCountryCode != null) 'phone_country_code': phoneCountryCode,
      if (currentWorkoutId != null) 'current_workout_id': currentWorkoutId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsCompanion copyWith(
      {Value<String>? authId,
      Value<int?>? age,
      Value<String?>? gender,
      Value<int?>? weight,
      Value<String?>? weightUnit,
      Value<int?>? height,
      Value<String?>? heightUnit,
      Value<bool>? isTrainer,
      Value<bool>? isUserActive,
      Value<String>? username,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? phoneCountryCode,
      Value<String?>? currentWorkoutId,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
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
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      currentWorkoutId: currentWorkoutId ?? this.currentWorkoutId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (phoneCountryCode.present) {
      map['phone_country_code'] = Variable<String>(phoneCountryCode.value);
    }
    if (currentWorkoutId.present) {
      map['current_workout_id'] = Variable<String>(currentWorkoutId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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
          ..write('phoneCountryCode: $phoneCountryCode, ')
          ..write('currentWorkoutId: $currentWorkoutId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientWeightTable extends ClientWeight
    with TableInfo<$ClientWeightTable, ClientWeightData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientWeightTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeStampMeta =
      const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<int> timeStamp = GeneratedColumn<int>(
      'time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightInKgMeta =
      const VerificationMeta('weightInKg');
  @override
  late final GeneratedColumn<double> weightInKg = GeneratedColumn<double>(
      'weight_in_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weightInLbMeta =
      const VerificationMeta('weightInLb');
  @override
  late final GeneratedColumn<double> weightInLb = GeneratedColumn<double>(
      'weight_in_lb', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [clientId, timeStamp, weightInKg, weightInLb];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_weight';
  @override
  VerificationContext validateIntegrity(Insertable<ClientWeightData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    } else if (isInserting) {
      context.missing(_timeStampMeta);
    }
    if (data.containsKey('weight_in_kg')) {
      context.handle(
          _weightInKgMeta,
          weightInKg.isAcceptableOrUnknown(
              data['weight_in_kg']!, _weightInKgMeta));
    } else if (isInserting) {
      context.missing(_weightInKgMeta);
    }
    if (data.containsKey('weight_in_lb')) {
      context.handle(
          _weightInLbMeta,
          weightInLb.isAcceptableOrUnknown(
              data['weight_in_lb']!, _weightInLbMeta));
    } else if (isInserting) {
      context.missing(_weightInLbMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientId, timeStamp};
  @override
  ClientWeightData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientWeightData(
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id']),
      timeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_stamp'])!,
      weightInKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_in_kg'])!,
      weightInLb: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_in_lb'])!,
    );
  }

  @override
  $ClientWeightTable createAlias(String alias) {
    return $ClientWeightTable(attachedDatabase, alias);
  }
}

class ClientWeightData extends DataClass
    implements Insertable<ClientWeightData> {
  final String? clientId;
  final int timeStamp;
  final double weightInKg;
  final double weightInLb;
  const ClientWeightData(
      {this.clientId,
      required this.timeStamp,
      required this.weightInKg,
      required this.weightInLb});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
    map['time_stamp'] = Variable<int>(timeStamp);
    map['weight_in_kg'] = Variable<double>(weightInKg);
    map['weight_in_lb'] = Variable<double>(weightInLb);
    return map;
  }

  ClientWeightCompanion toCompanion(bool nullToAbsent) {
    return ClientWeightCompanion(
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      timeStamp: Value(timeStamp),
      weightInKg: Value(weightInKg),
      weightInLb: Value(weightInLb),
    );
  }

  factory ClientWeightData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientWeightData(
      clientId: serializer.fromJson<String?>(json['clientId']),
      timeStamp: serializer.fromJson<int>(json['timeStamp']),
      weightInKg: serializer.fromJson<double>(json['weightInKg']),
      weightInLb: serializer.fromJson<double>(json['weightInLb']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<String?>(clientId),
      'timeStamp': serializer.toJson<int>(timeStamp),
      'weightInKg': serializer.toJson<double>(weightInKg),
      'weightInLb': serializer.toJson<double>(weightInLb),
    };
  }

  ClientWeightData copyWith(
          {Value<String?> clientId = const Value.absent(),
          int? timeStamp,
          double? weightInKg,
          double? weightInLb}) =>
      ClientWeightData(
        clientId: clientId.present ? clientId.value : this.clientId,
        timeStamp: timeStamp ?? this.timeStamp,
        weightInKg: weightInKg ?? this.weightInKg,
        weightInLb: weightInLb ?? this.weightInLb,
      );
  ClientWeightData copyWithCompanion(ClientWeightCompanion data) {
    return ClientWeightData(
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      timeStamp: data.timeStamp.present ? data.timeStamp.value : this.timeStamp,
      weightInKg:
          data.weightInKg.present ? data.weightInKg.value : this.weightInKg,
      weightInLb:
          data.weightInLb.present ? data.weightInLb.value : this.weightInLb,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientWeightData(')
          ..write('clientId: $clientId, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('weightInKg: $weightInKg, ')
          ..write('weightInLb: $weightInLb')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clientId, timeStamp, weightInKg, weightInLb);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientWeightData &&
          other.clientId == this.clientId &&
          other.timeStamp == this.timeStamp &&
          other.weightInKg == this.weightInKg &&
          other.weightInLb == this.weightInLb);
}

class ClientWeightCompanion extends UpdateCompanion<ClientWeightData> {
  final Value<String?> clientId;
  final Value<int> timeStamp;
  final Value<double> weightInKg;
  final Value<double> weightInLb;
  final Value<int> rowid;
  const ClientWeightCompanion({
    this.clientId = const Value.absent(),
    this.timeStamp = const Value.absent(),
    this.weightInKg = const Value.absent(),
    this.weightInLb = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientWeightCompanion.insert({
    this.clientId = const Value.absent(),
    required int timeStamp,
    required double weightInKg,
    required double weightInLb,
    this.rowid = const Value.absent(),
  })  : timeStamp = Value(timeStamp),
        weightInKg = Value(weightInKg),
        weightInLb = Value(weightInLb);
  static Insertable<ClientWeightData> custom({
    Expression<String>? clientId,
    Expression<int>? timeStamp,
    Expression<double>? weightInKg,
    Expression<double>? weightInLb,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (timeStamp != null) 'time_stamp': timeStamp,
      if (weightInKg != null) 'weight_in_kg': weightInKg,
      if (weightInLb != null) 'weight_in_lb': weightInLb,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientWeightCompanion copyWith(
      {Value<String?>? clientId,
      Value<int>? timeStamp,
      Value<double>? weightInKg,
      Value<double>? weightInLb,
      Value<int>? rowid}) {
    return ClientWeightCompanion(
      clientId: clientId ?? this.clientId,
      timeStamp: timeStamp ?? this.timeStamp,
      weightInKg: weightInKg ?? this.weightInKg,
      weightInLb: weightInLb ?? this.weightInLb,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (timeStamp.present) {
      map['time_stamp'] = Variable<int>(timeStamp.value);
    }
    if (weightInKg.present) {
      map['weight_in_kg'] = Variable<double>(weightInKg.value);
    }
    if (weightInLb.present) {
      map['weight_in_lb'] = Variable<double>(weightInLb.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientWeightCompanion(')
          ..write('clientId: $clientId, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('weightInKg: $weightInKg, ')
          ..write('weightInLb: $weightInLb, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutHistorySetTable extends WorkoutHistorySet
    with TableInfo<$WorkoutHistorySetTable, WorkoutHistorySetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutHistorySetTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_plan_exercise (id)'));
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
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().millisecondsSinceEpoch));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clientId,
        exerciseId,
        actualReps,
        actualWeight,
        actualDistance,
        actualTime,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_history_set';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkoutHistorySetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutHistorySetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutHistorySetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_id'])!,
      actualReps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_reps']),
      actualWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_weight']),
      actualDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_distance']),
      actualTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_time']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WorkoutHistorySetTable createAlias(String alias) {
    return $WorkoutHistorySetTable(attachedDatabase, alias);
  }
}

class WorkoutHistorySetData extends DataClass
    implements Insertable<WorkoutHistorySetData> {
  final int id;
  final String clientId;
  final String exerciseId;
  final int? actualReps;
  final double? actualWeight;
  final double? actualDistance;
  final int? actualTime;
  final int createdAt;
  final int updatedAt;
  const WorkoutHistorySetData(
      {required this.id,
      required this.clientId,
      required this.exerciseId,
      this.actualReps,
      this.actualWeight,
      this.actualDistance,
      this.actualTime,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<String>(clientId);
    map['exercise_id'] = Variable<String>(exerciseId);
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
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  WorkoutHistorySetCompanion toCompanion(bool nullToAbsent) {
    return WorkoutHistorySetCompanion(
      id: Value(id),
      clientId: Value(clientId),
      exerciseId: Value(exerciseId),
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
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkoutHistorySetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutHistorySetData(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      actualReps: serializer.fromJson<int?>(json['actualReps']),
      actualWeight: serializer.fromJson<double?>(json['actualWeight']),
      actualDistance: serializer.fromJson<double?>(json['actualDistance']),
      actualTime: serializer.fromJson<int?>(json['actualTime']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<String>(clientId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'actualReps': serializer.toJson<int?>(actualReps),
      'actualWeight': serializer.toJson<double?>(actualWeight),
      'actualDistance': serializer.toJson<double?>(actualDistance),
      'actualTime': serializer.toJson<int?>(actualTime),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  WorkoutHistorySetData copyWith(
          {int? id,
          String? clientId,
          String? exerciseId,
          Value<int?> actualReps = const Value.absent(),
          Value<double?> actualWeight = const Value.absent(),
          Value<double?> actualDistance = const Value.absent(),
          Value<int?> actualTime = const Value.absent(),
          int? createdAt,
          int? updatedAt}) =>
      WorkoutHistorySetData(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        exerciseId: exerciseId ?? this.exerciseId,
        actualReps: actualReps.present ? actualReps.value : this.actualReps,
        actualWeight:
            actualWeight.present ? actualWeight.value : this.actualWeight,
        actualDistance:
            actualDistance.present ? actualDistance.value : this.actualDistance,
        actualTime: actualTime.present ? actualTime.value : this.actualTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WorkoutHistorySetData copyWithCompanion(WorkoutHistorySetCompanion data) {
    return WorkoutHistorySetData(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
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
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistorySetData(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('actualReps: $actualReps, ')
          ..write('actualWeight: $actualWeight, ')
          ..write('actualDistance: $actualDistance, ')
          ..write('actualTime: $actualTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientId, exerciseId, actualReps,
      actualWeight, actualDistance, actualTime, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutHistorySetData &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.exerciseId == this.exerciseId &&
          other.actualReps == this.actualReps &&
          other.actualWeight == this.actualWeight &&
          other.actualDistance == this.actualDistance &&
          other.actualTime == this.actualTime &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutHistorySetCompanion
    extends UpdateCompanion<WorkoutHistorySetData> {
  final Value<int> id;
  final Value<String> clientId;
  final Value<String> exerciseId;
  final Value<int?> actualReps;
  final Value<double?> actualWeight;
  final Value<double?> actualDistance;
  final Value<int?> actualTime;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const WorkoutHistorySetCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.actualReps = const Value.absent(),
    this.actualWeight = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.actualTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WorkoutHistorySetCompanion.insert({
    this.id = const Value.absent(),
    required String clientId,
    required String exerciseId,
    this.actualReps = const Value.absent(),
    this.actualWeight = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.actualTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    required int updatedAt,
  })  : clientId = Value(clientId),
        exerciseId = Value(exerciseId),
        updatedAt = Value(updatedAt);
  static Insertable<WorkoutHistorySetData> custom({
    Expression<int>? id,
    Expression<String>? clientId,
    Expression<String>? exerciseId,
    Expression<int>? actualReps,
    Expression<double>? actualWeight,
    Expression<double>? actualDistance,
    Expression<int>? actualTime,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (actualReps != null) 'actual_reps': actualReps,
      if (actualWeight != null) 'actual_weight': actualWeight,
      if (actualDistance != null) 'actual_distance': actualDistance,
      if (actualTime != null) 'actual_time': actualTime,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WorkoutHistorySetCompanion copyWith(
      {Value<int>? id,
      Value<String>? clientId,
      Value<String>? exerciseId,
      Value<int?>? actualReps,
      Value<double?>? actualWeight,
      Value<double?>? actualDistance,
      Value<int?>? actualTime,
      Value<int>? createdAt,
      Value<int>? updatedAt}) {
    return WorkoutHistorySetCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      exerciseId: exerciseId ?? this.exerciseId,
      actualReps: actualReps ?? this.actualReps,
      actualWeight: actualWeight ?? this.actualWeight,
      actualDistance: actualDistance ?? this.actualDistance,
      actualTime: actualTime ?? this.actualTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
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
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistorySetCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('actualReps: $actualReps, ')
          ..write('actualWeight: $actualWeight, ')
          ..write('actualDistance: $actualDistance, ')
          ..write('actualTime: $actualTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tableMeta = const VerificationMeta('table');
  @override
  late final GeneratedColumn<String> table = GeneratedColumn<String>(
      'table', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, operation, data, table, timestamp, synced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('table')) {
      context.handle(
          _tableMeta, table.isAcceptableOrUnknown(data['table']!, _tableMeta));
    } else if (isInserting) {
      context.missing(_tableMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      table: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}table'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String operation;
  final String data;
  final String table;
  final int timestamp;
  final bool synced;
  const SyncQueueData(
      {required this.id,
      required this.operation,
      required this.data,
      required this.table,
      required this.timestamp,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation'] = Variable<String>(operation);
    map['data'] = Variable<String>(data);
    map['table'] = Variable<String>(table);
    map['timestamp'] = Variable<int>(timestamp);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      operation: Value(operation),
      data: Value(data),
      table: Value(table),
      timestamp: Value(timestamp),
      synced: Value(synced),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      operation: serializer.fromJson<String>(json['operation']),
      data: serializer.fromJson<String>(json['data']),
      table: serializer.fromJson<String>(json['table']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operation': serializer.toJson<String>(operation),
      'data': serializer.toJson<String>(data),
      'table': serializer.toJson<String>(table),
      'timestamp': serializer.toJson<int>(timestamp),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? operation,
          String? data,
          String? table,
          int? timestamp,
          bool? synced}) =>
      SyncQueueData(
        id: id ?? this.id,
        operation: operation ?? this.operation,
        data: data ?? this.data,
        table: table ?? this.table,
        timestamp: timestamp ?? this.timestamp,
        synced: synced ?? this.synced,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      operation: data.operation.present ? data.operation.value : this.operation,
      data: data.data.present ? data.data.value : this.data,
      table: data.table.present ? data.table.value : this.table,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('operation: $operation, ')
          ..write('data: $data, ')
          ..write('table: $table, ')
          ..write('timestamp: $timestamp, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, operation, data, table, timestamp, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.operation == this.operation &&
          other.data == this.data &&
          other.table == this.table &&
          other.timestamp == this.timestamp &&
          other.synced == this.synced);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> operation;
  final Value<String> data;
  final Value<String> table;
  final Value<int> timestamp;
  final Value<bool> synced;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.operation = const Value.absent(),
    this.data = const Value.absent(),
    this.table = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.synced = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String operation,
    required String data,
    required String table,
    required int timestamp,
    this.synced = const Value.absent(),
  })  : operation = Value(operation),
        data = Value(data),
        table = Value(table),
        timestamp = Value(timestamp);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? operation,
    Expression<String>? data,
    Expression<String>? table,
    Expression<int>? timestamp,
    Expression<bool>? synced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operation != null) 'operation': operation,
      if (data != null) 'data': data,
      if (table != null) 'table': table,
      if (timestamp != null) 'timestamp': timestamp,
      if (synced != null) 'synced': synced,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? operation,
      Value<String>? data,
      Value<String>? table,
      Value<int>? timestamp,
      Value<bool>? synced}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      operation: operation ?? this.operation,
      data: data ?? this.data,
      table: table ?? this.table,
      timestamp: timestamp ?? this.timestamp,
      synced: synced ?? this.synced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (table.present) {
      map['table'] = Variable<String>(table.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('operation: $operation, ')
          ..write('data: $data, ')
          ..write('table: $table, ')
          ..write('timestamp: $timestamp, ')
          ..write('synced: $synced')
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
  late final $WorkoutPlanExerciseTable workoutPlanExercise =
      $WorkoutPlanExerciseTable(this);
  late final $ExerciseSetsTable exerciseSets = $ExerciseSetsTable(this);
  late final $BaseExerciseTable baseExercise = $BaseExerciseTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $ClientWeightTable clientWeight = $ClientWeightTable(this);
  late final $WorkoutHistorySetTable workoutHistorySet =
      $WorkoutHistorySetTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final WorkoutPlanDao workoutPlanDao =
      WorkoutPlanDao(this as AppDatabase);
  late final ClientsDao clientsDao = ClientsDao(this as AppDatabase);
  late final WorkoutHistoryDao workoutHistoryDao =
      WorkoutHistoryDao(this as AppDatabase);
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        workoutPlans,
        weeks,
        days,
        workoutPlanExercise,
        exerciseSets,
        baseExercise,
        clients,
        clientWeight,
        workoutHistorySet,
        syncQueue
      ];
}

typedef $$WorkoutPlansTableCreateCompanionBuilder = WorkoutPlansCompanion
    Function({
  required String uid,
  required String name,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$WorkoutPlansTableUpdateCompanionBuilder = WorkoutPlansCompanion
    Function({
  Value<String> uid,
  Value<String> name,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});

final class $$WorkoutPlansTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutPlansTable, WorkoutPlan> {
  $$WorkoutPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WeeksTable, List<Week>> _weeksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.weeks,
          aliasName: $_aliasNameGenerator(
              db.workoutPlans.uid, db.weeks.workoutPlanId));

  $$WeeksTableProcessedTableManager get weeksRefs {
    final manager = $$WeeksTableTableManager($_db, $_db.weeks)
        .filter((f) => f.workoutPlanId.uid($_item.uid));

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

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> weeksRefs(
      Expression<bool> Function($$WeeksTableFilterComposer f) f) {
    final $$WeeksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.workoutPlanId,
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

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> weeksRefs<T extends Object>(
      Expression<T> Function($$WeeksTableAnnotationComposer a) f) {
    final $$WeeksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.workoutPlanId,
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
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlansCompanion(
            uid: uid,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String name,
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlansCompanion.insert(
            uid: uid,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
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
                                .where((e) => e.workoutPlanId == item.uid),
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
  required String id,
  required String workoutPlanId,
  required int weekNumber,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$WeeksTableUpdateCompanionBuilder = WeeksCompanion Function({
  Value<String> id,
  Value<String> workoutPlanId,
  Value<int> weekNumber,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});

final class $$WeeksTableReferences
    extends BaseReferences<_$AppDatabase, $WeeksTable, Week> {
  $$WeeksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutPlansTable _workoutPlanIdTable(_$AppDatabase db) =>
      db.workoutPlans.createAlias(
          $_aliasNameGenerator(db.weeks.workoutPlanId, db.workoutPlans.uid));

  $$WorkoutPlansTableProcessedTableManager? get workoutPlanId {
    if ($_item.workoutPlanId == null) return null;
    final manager = $$WorkoutPlansTableTableManager($_db, $_db.workoutPlans)
        .filter((f) => f.uid($_item.workoutPlanId!));
    final item = $_typedResult.readTableOrNull(_workoutPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DaysTable, List<Day>> _daysRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.days,
          aliasName: $_aliasNameGenerator(db.weeks.id, db.days.weekId));

  $$DaysTableProcessedTableManager get daysRefs {
    final manager = $$DaysTableTableManager($_db, $_db.days)
        .filter((f) => f.weekId.id($_item.id));

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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$WorkoutPlansTableFilterComposer get workoutPlanId {
    final $$WorkoutPlansTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutPlanId,
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
        getReferencedColumn: (t) => t.weekId,
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$WorkoutPlansTableOrderingComposer get workoutPlanId {
    final $$WorkoutPlansTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutPlanId,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorkoutPlansTableAnnotationComposer get workoutPlanId {
    final $$WorkoutPlansTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutPlanId,
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
        getReferencedColumn: (t) => t.weekId,
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
    PrefetchHooks Function({bool workoutPlanId, bool daysRefs})> {
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
            Value<String> id = const Value.absent(),
            Value<String> workoutPlanId = const Value.absent(),
            Value<int> weekNumber = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeksCompanion(
            id: id,
            workoutPlanId: workoutPlanId,
            weekNumber: weekNumber,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workoutPlanId,
            required int weekNumber,
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeksCompanion.insert(
            id: id,
            workoutPlanId: workoutPlanId,
            weekNumber: weekNumber,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WeeksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({workoutPlanId = false, daysRefs = false}) {
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
                if (workoutPlanId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutPlanId,
                    referencedTable:
                        $$WeeksTableReferences._workoutPlanIdTable(db),
                    referencedColumn:
                        $$WeeksTableReferences._workoutPlanIdTable(db).uid,
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
                            referencedItems.where((e) => e.weekId == item.id),
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
    PrefetchHooks Function({bool workoutPlanId, bool daysRefs})>;
typedef $$DaysTableCreateCompanionBuilder = DaysCompanion Function({
  required String id,
  required String weekId,
  required int dayNumber,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$DaysTableUpdateCompanionBuilder = DaysCompanion Function({
  Value<String> id,
  Value<String> weekId,
  Value<int> dayNumber,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});

final class $$DaysTableReferences
    extends BaseReferences<_$AppDatabase, $DaysTable, Day> {
  $$DaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeeksTable _weekIdTable(_$AppDatabase db) =>
      db.weeks.createAlias($_aliasNameGenerator(db.days.weekId, db.weeks.id));

  $$WeeksTableProcessedTableManager? get weekId {
    if ($_item.weekId == null) return null;
    final manager = $$WeeksTableTableManager($_db, $_db.weeks)
        .filter((f) => f.id($_item.weekId!));
    final item = $_typedResult.readTableOrNull(_weekIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$WorkoutPlanExerciseTable,
      List<WorkoutPlanExerciseData>> _workoutPlanExerciseRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.workoutPlanExercise,
          aliasName:
              $_aliasNameGenerator(db.days.id, db.workoutPlanExercise.dayId));

  $$WorkoutPlanExerciseTableProcessedTableManager get workoutPlanExerciseRefs {
    final manager =
        $$WorkoutPlanExerciseTableTableManager($_db, $_db.workoutPlanExercise)
            .filter((f) => f.dayId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_workoutPlanExerciseRefsTable($_db));
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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayNumber => $composableBuilder(
      column: $table.dayNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$WeeksTableFilterComposer get weekId {
    final $$WeeksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.weekId,
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

  Expression<bool> workoutPlanExerciseRefs(
      Expression<bool> Function($$WorkoutPlanExerciseTableFilterComposer f) f) {
    final $$WorkoutPlanExerciseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutPlanExercise,
        getReferencedColumn: (t) => t.dayId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlanExerciseTableFilterComposer(
              $db: $db,
              $table: $db.workoutPlanExercise,
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayNumber => $composableBuilder(
      column: $table.dayNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$WeeksTableOrderingComposer get weekId {
    final $$WeeksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.weekId,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WeeksTableAnnotationComposer get weekId {
    final $$WeeksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.weekId,
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

  Expression<T> workoutPlanExerciseRefs<T extends Object>(
      Expression<T> Function($$WorkoutPlanExerciseTableAnnotationComposer a)
          f) {
    final $$WorkoutPlanExerciseTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.workoutPlanExercise,
            getReferencedColumn: (t) => t.dayId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkoutPlanExerciseTableAnnotationComposer(
                  $db: $db,
                  $table: $db.workoutPlanExercise,
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
    PrefetchHooks Function({bool weekId, bool workoutPlanExerciseRefs})> {
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
            Value<String> id = const Value.absent(),
            Value<String> weekId = const Value.absent(),
            Value<int> dayNumber = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DaysCompanion(
            id: id,
            weekId: weekId,
            dayNumber: dayNumber,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String weekId,
            required int dayNumber,
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DaysCompanion.insert(
            id: id,
            weekId: weekId,
            dayNumber: dayNumber,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DaysTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {weekId = false, workoutPlanExerciseRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (workoutPlanExerciseRefs) db.workoutPlanExercise
              ],
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
                if (weekId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.weekId,
                    referencedTable: $$DaysTableReferences._weekIdTable(db),
                    referencedColumn: $$DaysTableReferences._weekIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutPlanExerciseRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DaysTableReferences
                            ._workoutPlanExerciseRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DaysTableReferences(db, table, p0)
                                .workoutPlanExerciseRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dayId == item.id),
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
    PrefetchHooks Function({bool weekId, bool workoutPlanExerciseRefs})>;
typedef $$WorkoutPlanExerciseTableCreateCompanionBuilder
    = WorkoutPlanExerciseCompanion Function({
  required String id,
  required String dayId,
  required String code,
  required int exerciseOrder,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$WorkoutPlanExerciseTableUpdateCompanionBuilder
    = WorkoutPlanExerciseCompanion Function({
  Value<String> id,
  Value<String> dayId,
  Value<String> code,
  Value<int> exerciseOrder,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});

final class $$WorkoutPlanExerciseTableReferences extends BaseReferences<
    _$AppDatabase, $WorkoutPlanExerciseTable, WorkoutPlanExerciseData> {
  $$WorkoutPlanExerciseTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DaysTable _dayIdTable(_$AppDatabase db) => db.days.createAlias(
      $_aliasNameGenerator(db.workoutPlanExercise.dayId, db.days.id));

  $$DaysTableProcessedTableManager? get dayId {
    if ($_item.dayId == null) return null;
    final manager = $$DaysTableTableManager($_db, $_db.days)
        .filter((f) => f.id($_item.dayId!));
    final item = $_typedResult.readTableOrNull(_dayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExerciseSetsTable, List<ExerciseSet>>
      _exerciseSetsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exerciseSets,
              aliasName: $_aliasNameGenerator(
                  db.workoutPlanExercise.id, db.exerciseSets.exerciseId));

  $$ExerciseSetsTableProcessedTableManager get exerciseSetsRefs {
    final manager = $$ExerciseSetsTableTableManager($_db, $_db.exerciseSets)
        .filter((f) => f.exerciseId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_exerciseSetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkoutHistorySetTable,
      List<WorkoutHistorySetData>> _workoutHistorySetRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.workoutHistorySet,
          aliasName: $_aliasNameGenerator(
              db.workoutPlanExercise.id, db.workoutHistorySet.exerciseId));

  $$WorkoutHistorySetTableProcessedTableManager get workoutHistorySetRefs {
    final manager =
        $$WorkoutHistorySetTableTableManager($_db, $_db.workoutHistorySet)
            .filter((f) => f.exerciseId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_workoutHistorySetRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutPlanExerciseTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutPlanExerciseTable> {
  $$WorkoutPlanExerciseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$DaysTableFilterComposer get dayId {
    final $$DaysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
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
        getReferencedColumn: (t) => t.exerciseId,
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

  Expression<bool> workoutHistorySetRefs(
      Expression<bool> Function($$WorkoutHistorySetTableFilterComposer f) f) {
    final $$WorkoutHistorySetTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutHistorySet,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutHistorySetTableFilterComposer(
              $db: $db,
              $table: $db.workoutHistorySet,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutPlanExerciseTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutPlanExerciseTable> {
  $$WorkoutPlanExerciseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$DaysTableOrderingComposer get dayId {
    final $$DaysTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
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

class $$WorkoutPlanExerciseTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutPlanExerciseTable> {
  $$WorkoutPlanExerciseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$DaysTableAnnotationComposer get dayId {
    final $$DaysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
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
        getReferencedColumn: (t) => t.exerciseId,
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

  Expression<T> workoutHistorySetRefs<T extends Object>(
      Expression<T> Function($$WorkoutHistorySetTableAnnotationComposer a) f) {
    final $$WorkoutHistorySetTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.workoutHistorySet,
            getReferencedColumn: (t) => t.exerciseId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkoutHistorySetTableAnnotationComposer(
                  $db: $db,
                  $table: $db.workoutHistorySet,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$WorkoutPlanExerciseTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutPlanExerciseTable,
    WorkoutPlanExerciseData,
    $$WorkoutPlanExerciseTableFilterComposer,
    $$WorkoutPlanExerciseTableOrderingComposer,
    $$WorkoutPlanExerciseTableAnnotationComposer,
    $$WorkoutPlanExerciseTableCreateCompanionBuilder,
    $$WorkoutPlanExerciseTableUpdateCompanionBuilder,
    (WorkoutPlanExerciseData, $$WorkoutPlanExerciseTableReferences),
    WorkoutPlanExerciseData,
    PrefetchHooks Function(
        {bool dayId, bool exerciseSetsRefs, bool workoutHistorySetRefs})> {
  $$WorkoutPlanExerciseTableTableManager(
      _$AppDatabase db, $WorkoutPlanExerciseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutPlanExerciseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutPlanExerciseTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutPlanExerciseTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> dayId = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<int> exerciseOrder = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlanExerciseCompanion(
            id: id,
            dayId: dayId,
            code: code,
            exerciseOrder: exerciseOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String dayId,
            required String code,
            required int exerciseOrder,
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlanExerciseCompanion.insert(
            id: id,
            dayId: dayId,
            code: code,
            exerciseOrder: exerciseOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutPlanExerciseTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {dayId = false,
              exerciseSetsRefs = false,
              workoutHistorySetRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (exerciseSetsRefs) db.exerciseSets,
                if (workoutHistorySetRefs) db.workoutHistorySet
              ],
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
                if (dayId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dayId,
                    referencedTable:
                        $$WorkoutPlanExerciseTableReferences._dayIdTable(db),
                    referencedColumn:
                        $$WorkoutPlanExerciseTableReferences._dayIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exerciseSetsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$WorkoutPlanExerciseTableReferences
                            ._exerciseSetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutPlanExerciseTableReferences(db, table, p0)
                                .exerciseSetsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseId == item.id),
                        typedResults: items),
                  if (workoutHistorySetRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$WorkoutPlanExerciseTableReferences
                            ._workoutHistorySetRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutPlanExerciseTableReferences(db, table, p0)
                                .workoutHistorySetRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutPlanExerciseTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutPlanExerciseTable,
    WorkoutPlanExerciseData,
    $$WorkoutPlanExerciseTableFilterComposer,
    $$WorkoutPlanExerciseTableOrderingComposer,
    $$WorkoutPlanExerciseTableAnnotationComposer,
    $$WorkoutPlanExerciseTableCreateCompanionBuilder,
    $$WorkoutPlanExerciseTableUpdateCompanionBuilder,
    (WorkoutPlanExerciseData, $$WorkoutPlanExerciseTableReferences),
    WorkoutPlanExerciseData,
    PrefetchHooks Function(
        {bool dayId, bool exerciseSetsRefs, bool workoutHistorySetRefs})>;
typedef $$ExerciseSetsTableCreateCompanionBuilder = ExerciseSetsCompanion
    Function({
  required String id,
  required String exerciseId,
  Value<int?> targetReps,
  Value<double?> targetWeight,
  Value<double?> targetDistance,
  Value<int?> targetTime,
  Value<int> createdAt,
  Value<int?> updatedAt,
  required int setNumber,
  Value<int> rowid,
});
typedef $$ExerciseSetsTableUpdateCompanionBuilder = ExerciseSetsCompanion
    Function({
  Value<String> id,
  Value<String> exerciseId,
  Value<int?> targetReps,
  Value<double?> targetWeight,
  Value<double?> targetDistance,
  Value<int?> targetTime,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> setNumber,
  Value<int> rowid,
});

final class $$ExerciseSetsTableReferences
    extends BaseReferences<_$AppDatabase, $ExerciseSetsTable, ExerciseSet> {
  $$ExerciseSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutPlanExerciseTable _exerciseIdTable(_$AppDatabase db) =>
      db.workoutPlanExercise.createAlias($_aliasNameGenerator(
          db.exerciseSets.exerciseId, db.workoutPlanExercise.id));

  $$WorkoutPlanExerciseTableProcessedTableManager? get exerciseId {
    if ($_item.exerciseId == null) return null;
    final manager =
        $$WorkoutPlanExerciseTableTableManager($_db, $_db.workoutPlanExercise)
            .filter((f) => f.id($_item.exerciseId!));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
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
  ColumnFilters<String> get id => $composableBuilder(
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

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnFilters(column));

  $$WorkoutPlanExerciseTableFilterComposer get exerciseId {
    final $$WorkoutPlanExerciseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.workoutPlanExercise,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlanExerciseTableFilterComposer(
              $db: $db,
              $table: $db.workoutPlanExercise,
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
  ColumnOrderings<String> get id => $composableBuilder(
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

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnOrderings(column));

  $$WorkoutPlanExerciseTableOrderingComposer get exerciseId {
    final $$WorkoutPlanExerciseTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.exerciseId,
            referencedTable: $db.workoutPlanExercise,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkoutPlanExerciseTableOrderingComposer(
                  $db: $db,
                  $table: $db.workoutPlanExercise,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => column);

  GeneratedColumn<double> get targetWeight => $composableBuilder(
      column: $table.targetWeight, builder: (column) => column);

  GeneratedColumn<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance, builder: (column) => column);

  GeneratedColumn<int> get targetTime => $composableBuilder(
      column: $table.targetTime, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  $$WorkoutPlanExerciseTableAnnotationComposer get exerciseId {
    final $$WorkoutPlanExerciseTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.exerciseId,
            referencedTable: $db.workoutPlanExercise,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkoutPlanExerciseTableAnnotationComposer(
                  $db: $db,
                  $table: $db.workoutPlanExercise,
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
    PrefetchHooks Function({bool exerciseId})> {
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
            Value<String> id = const Value.absent(),
            Value<String> exerciseId = const Value.absent(),
            Value<int?> targetReps = const Value.absent(),
            Value<double?> targetWeight = const Value.absent(),
            Value<double?> targetDistance = const Value.absent(),
            Value<int?> targetTime = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> setNumber = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExerciseSetsCompanion(
            id: id,
            exerciseId: exerciseId,
            targetReps: targetReps,
            targetWeight: targetWeight,
            targetDistance: targetDistance,
            targetTime: targetTime,
            createdAt: createdAt,
            updatedAt: updatedAt,
            setNumber: setNumber,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String exerciseId,
            Value<int?> targetReps = const Value.absent(),
            Value<double?> targetWeight = const Value.absent(),
            Value<double?> targetDistance = const Value.absent(),
            Value<int?> targetTime = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            required int setNumber,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExerciseSetsCompanion.insert(
            id: id,
            exerciseId: exerciseId,
            targetReps: targetReps,
            targetWeight: targetWeight,
            targetDistance: targetDistance,
            targetTime: targetTime,
            createdAt: createdAt,
            updatedAt: updatedAt,
            setNumber: setNumber,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExerciseSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
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
                if (exerciseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseId,
                    referencedTable:
                        $$ExerciseSetsTableReferences._exerciseIdTable(db),
                    referencedColumn:
                        $$ExerciseSetsTableReferences._exerciseIdTable(db).id,
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
    PrefetchHooks Function({bool exerciseId})>;
typedef $$BaseExerciseTableCreateCompanionBuilder = BaseExerciseCompanion
    Function({
  required String id,
  required String code,
  Value<String?> category,
  required String muscleGroup,
  required String name,
  Value<bool> reps,
  Value<bool> duration,
  Value<bool> weight,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$BaseExerciseTableUpdateCompanionBuilder = BaseExerciseCompanion
    Function({
  Value<String> id,
  Value<String> code,
  Value<String?> category,
  Value<String> muscleGroup,
  Value<String> name,
  Value<bool> reps,
  Value<bool> duration,
  Value<bool> weight,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});

class $$BaseExerciseTableFilterComposer
    extends Composer<_$AppDatabase, $BaseExerciseTable> {
  $$BaseExerciseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$BaseExerciseTableOrderingComposer
    extends Composer<_$AppDatabase, $BaseExerciseTable> {
  $$BaseExerciseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BaseExerciseTableAnnotationComposer
    extends Composer<_$AppDatabase, $BaseExerciseTable> {
  $$BaseExerciseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<bool> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<bool> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BaseExerciseTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BaseExerciseTable,
    BaseExerciseData,
    $$BaseExerciseTableFilterComposer,
    $$BaseExerciseTableOrderingComposer,
    $$BaseExerciseTableAnnotationComposer,
    $$BaseExerciseTableCreateCompanionBuilder,
    $$BaseExerciseTableUpdateCompanionBuilder,
    (
      BaseExerciseData,
      BaseReferences<_$AppDatabase, $BaseExerciseTable, BaseExerciseData>
    ),
    BaseExerciseData,
    PrefetchHooks Function()> {
  $$BaseExerciseTableTableManager(_$AppDatabase db, $BaseExerciseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BaseExerciseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BaseExerciseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BaseExerciseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String> muscleGroup = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> reps = const Value.absent(),
            Value<bool> duration = const Value.absent(),
            Value<bool> weight = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BaseExerciseCompanion(
            id: id,
            code: code,
            category: category,
            muscleGroup: muscleGroup,
            name: name,
            reps: reps,
            duration: duration,
            weight: weight,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String code,
            Value<String?> category = const Value.absent(),
            required String muscleGroup,
            required String name,
            Value<bool> reps = const Value.absent(),
            Value<bool> duration = const Value.absent(),
            Value<bool> weight = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BaseExerciseCompanion.insert(
            id: id,
            code: code,
            category: category,
            muscleGroup: muscleGroup,
            name: name,
            reps: reps,
            duration: duration,
            weight: weight,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BaseExerciseTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BaseExerciseTable,
    BaseExerciseData,
    $$BaseExerciseTableFilterComposer,
    $$BaseExerciseTableOrderingComposer,
    $$BaseExerciseTableAnnotationComposer,
    $$BaseExerciseTableCreateCompanionBuilder,
    $$BaseExerciseTableUpdateCompanionBuilder,
    (
      BaseExerciseData,
      BaseReferences<_$AppDatabase, $BaseExerciseTable, BaseExerciseData>
    ),
    BaseExerciseData,
    PrefetchHooks Function()>;
typedef $$ClientsTableCreateCompanionBuilder = ClientsCompanion Function({
  required String authId,
  Value<int?> age,
  Value<String?> gender,
  Value<int?> weight,
  Value<String?> weightUnit,
  Value<int?> height,
  Value<String?> heightUnit,
  required bool isTrainer,
  required bool isUserActive,
  required String username,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> phoneCountryCode,
  Value<String?> currentWorkoutId,
  required int createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$ClientsTableUpdateCompanionBuilder = ClientsCompanion Function({
  Value<String> authId,
  Value<int?> age,
  Value<String?> gender,
  Value<int?> weight,
  Value<String?> weightUnit,
  Value<int?> height,
  Value<String?> heightUnit,
  Value<bool> isTrainer,
  Value<bool> isUserActive,
  Value<String> username,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> phoneCountryCode,
  Value<String?> currentWorkoutId,
  Value<int> createdAt,
  Value<int?> updatedAt,
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

  ColumnFilters<String> get phoneCountryCode => $composableBuilder(
      column: $table.phoneCountryCode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentWorkoutId => $composableBuilder(
      column: $table.currentWorkoutId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get phoneCountryCode => $composableBuilder(
      column: $table.phoneCountryCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentWorkoutId => $composableBuilder(
      column: $table.currentWorkoutId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get phoneCountryCode => $composableBuilder(
      column: $table.phoneCountryCode, builder: (column) => column);

  GeneratedColumn<String> get currentWorkoutId => $composableBuilder(
      column: $table.currentWorkoutId, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
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
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<int?> weight = const Value.absent(),
            Value<String?> weightUnit = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<String?> heightUnit = const Value.absent(),
            Value<bool> isTrainer = const Value.absent(),
            Value<bool> isUserActive = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> phoneCountryCode = const Value.absent(),
            Value<String?> currentWorkoutId = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
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
            phoneCountryCode: phoneCountryCode,
            currentWorkoutId: currentWorkoutId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String authId,
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<int?> weight = const Value.absent(),
            Value<String?> weightUnit = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<String?> heightUnit = const Value.absent(),
            required bool isTrainer,
            required bool isUserActive,
            required String username,
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> phoneCountryCode = const Value.absent(),
            Value<String?> currentWorkoutId = const Value.absent(),
            required int createdAt,
            Value<int?> updatedAt = const Value.absent(),
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
            phoneCountryCode: phoneCountryCode,
            currentWorkoutId: currentWorkoutId,
            createdAt: createdAt,
            updatedAt: updatedAt,
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
typedef $$ClientWeightTableCreateCompanionBuilder = ClientWeightCompanion
    Function({
  Value<String?> clientId,
  required int timeStamp,
  required double weightInKg,
  required double weightInLb,
  Value<int> rowid,
});
typedef $$ClientWeightTableUpdateCompanionBuilder = ClientWeightCompanion
    Function({
  Value<String?> clientId,
  Value<int> timeStamp,
  Value<double> weightInKg,
  Value<double> weightInLb,
  Value<int> rowid,
});

class $$ClientWeightTableFilterComposer
    extends Composer<_$AppDatabase, $ClientWeightTable> {
  $$ClientWeightTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightInKg => $composableBuilder(
      column: $table.weightInKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightInLb => $composableBuilder(
      column: $table.weightInLb, builder: (column) => ColumnFilters(column));
}

class $$ClientWeightTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientWeightTable> {
  $$ClientWeightTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightInKg => $composableBuilder(
      column: $table.weightInKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightInLb => $composableBuilder(
      column: $table.weightInLb, builder: (column) => ColumnOrderings(column));
}

class $$ClientWeightTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientWeightTable> {
  $$ClientWeightTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<int> get timeStamp =>
      $composableBuilder(column: $table.timeStamp, builder: (column) => column);

  GeneratedColumn<double> get weightInKg => $composableBuilder(
      column: $table.weightInKg, builder: (column) => column);

  GeneratedColumn<double> get weightInLb => $composableBuilder(
      column: $table.weightInLb, builder: (column) => column);
}

class $$ClientWeightTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientWeightTable,
    ClientWeightData,
    $$ClientWeightTableFilterComposer,
    $$ClientWeightTableOrderingComposer,
    $$ClientWeightTableAnnotationComposer,
    $$ClientWeightTableCreateCompanionBuilder,
    $$ClientWeightTableUpdateCompanionBuilder,
    (
      ClientWeightData,
      BaseReferences<_$AppDatabase, $ClientWeightTable, ClientWeightData>
    ),
    ClientWeightData,
    PrefetchHooks Function()> {
  $$ClientWeightTableTableManager(_$AppDatabase db, $ClientWeightTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientWeightTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientWeightTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientWeightTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String?> clientId = const Value.absent(),
            Value<int> timeStamp = const Value.absent(),
            Value<double> weightInKg = const Value.absent(),
            Value<double> weightInLb = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientWeightCompanion(
            clientId: clientId,
            timeStamp: timeStamp,
            weightInKg: weightInKg,
            weightInLb: weightInLb,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> clientId = const Value.absent(),
            required int timeStamp,
            required double weightInKg,
            required double weightInLb,
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientWeightCompanion.insert(
            clientId: clientId,
            timeStamp: timeStamp,
            weightInKg: weightInKg,
            weightInLb: weightInLb,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClientWeightTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientWeightTable,
    ClientWeightData,
    $$ClientWeightTableFilterComposer,
    $$ClientWeightTableOrderingComposer,
    $$ClientWeightTableAnnotationComposer,
    $$ClientWeightTableCreateCompanionBuilder,
    $$ClientWeightTableUpdateCompanionBuilder,
    (
      ClientWeightData,
      BaseReferences<_$AppDatabase, $ClientWeightTable, ClientWeightData>
    ),
    ClientWeightData,
    PrefetchHooks Function()>;
typedef $$WorkoutHistorySetTableCreateCompanionBuilder
    = WorkoutHistorySetCompanion Function({
  Value<int> id,
  required String clientId,
  required String exerciseId,
  Value<int?> actualReps,
  Value<double?> actualWeight,
  Value<double?> actualDistance,
  Value<int?> actualTime,
  Value<int> createdAt,
  required int updatedAt,
});
typedef $$WorkoutHistorySetTableUpdateCompanionBuilder
    = WorkoutHistorySetCompanion Function({
  Value<int> id,
  Value<String> clientId,
  Value<String> exerciseId,
  Value<int?> actualReps,
  Value<double?> actualWeight,
  Value<double?> actualDistance,
  Value<int?> actualTime,
  Value<int> createdAt,
  Value<int> updatedAt,
});

final class $$WorkoutHistorySetTableReferences extends BaseReferences<
    _$AppDatabase, $WorkoutHistorySetTable, WorkoutHistorySetData> {
  $$WorkoutHistorySetTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutPlanExerciseTable _exerciseIdTable(_$AppDatabase db) =>
      db.workoutPlanExercise.createAlias($_aliasNameGenerator(
          db.workoutHistorySet.exerciseId, db.workoutPlanExercise.id));

  $$WorkoutPlanExerciseTableProcessedTableManager? get exerciseId {
    if ($_item.exerciseId == null) return null;
    final manager =
        $$WorkoutPlanExerciseTableTableManager($_db, $_db.workoutPlanExercise)
            .filter((f) => f.id($_item.exerciseId!));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WorkoutHistorySetTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutHistorySetTable> {
  $$WorkoutHistorySetTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualReps => $composableBuilder(
      column: $table.actualReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualWeight => $composableBuilder(
      column: $table.actualWeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualDistance => $composableBuilder(
      column: $table.actualDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualTime => $composableBuilder(
      column: $table.actualTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$WorkoutPlanExerciseTableFilterComposer get exerciseId {
    final $$WorkoutPlanExerciseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.workoutPlanExercise,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlanExerciseTableFilterComposer(
              $db: $db,
              $table: $db.workoutPlanExercise,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutHistorySetTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutHistorySetTable> {
  $$WorkoutHistorySetTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$WorkoutPlanExerciseTableOrderingComposer get exerciseId {
    final $$WorkoutPlanExerciseTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.exerciseId,
            referencedTable: $db.workoutPlanExercise,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkoutPlanExerciseTableOrderingComposer(
                  $db: $db,
                  $table: $db.workoutPlanExercise,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$WorkoutHistorySetTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutHistorySetTable> {
  $$WorkoutHistorySetTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<int> get actualReps => $composableBuilder(
      column: $table.actualReps, builder: (column) => column);

  GeneratedColumn<double> get actualWeight => $composableBuilder(
      column: $table.actualWeight, builder: (column) => column);

  GeneratedColumn<double> get actualDistance => $composableBuilder(
      column: $table.actualDistance, builder: (column) => column);

  GeneratedColumn<int> get actualTime => $composableBuilder(
      column: $table.actualTime, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorkoutPlanExerciseTableAnnotationComposer get exerciseId {
    final $$WorkoutPlanExerciseTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.exerciseId,
            referencedTable: $db.workoutPlanExercise,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkoutPlanExerciseTableAnnotationComposer(
                  $db: $db,
                  $table: $db.workoutPlanExercise,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$WorkoutHistorySetTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutHistorySetTable,
    WorkoutHistorySetData,
    $$WorkoutHistorySetTableFilterComposer,
    $$WorkoutHistorySetTableOrderingComposer,
    $$WorkoutHistorySetTableAnnotationComposer,
    $$WorkoutHistorySetTableCreateCompanionBuilder,
    $$WorkoutHistorySetTableUpdateCompanionBuilder,
    (WorkoutHistorySetData, $$WorkoutHistorySetTableReferences),
    WorkoutHistorySetData,
    PrefetchHooks Function({bool exerciseId})> {
  $$WorkoutHistorySetTableTableManager(
      _$AppDatabase db, $WorkoutHistorySetTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutHistorySetTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutHistorySetTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutHistorySetTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> clientId = const Value.absent(),
            Value<String> exerciseId = const Value.absent(),
            Value<int?> actualReps = const Value.absent(),
            Value<double?> actualWeight = const Value.absent(),
            Value<double?> actualDistance = const Value.absent(),
            Value<int?> actualTime = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
          }) =>
              WorkoutHistorySetCompanion(
            id: id,
            clientId: clientId,
            exerciseId: exerciseId,
            actualReps: actualReps,
            actualWeight: actualWeight,
            actualDistance: actualDistance,
            actualTime: actualTime,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String clientId,
            required String exerciseId,
            Value<int?> actualReps = const Value.absent(),
            Value<double?> actualWeight = const Value.absent(),
            Value<double?> actualDistance = const Value.absent(),
            Value<int?> actualTime = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            required int updatedAt,
          }) =>
              WorkoutHistorySetCompanion.insert(
            id: id,
            clientId: clientId,
            exerciseId: exerciseId,
            actualReps: actualReps,
            actualWeight: actualWeight,
            actualDistance: actualDistance,
            actualTime: actualTime,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutHistorySetTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
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
                if (exerciseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseId,
                    referencedTable:
                        $$WorkoutHistorySetTableReferences._exerciseIdTable(db),
                    referencedColumn: $$WorkoutHistorySetTableReferences
                        ._exerciseIdTable(db)
                        .id,
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

typedef $$WorkoutHistorySetTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutHistorySetTable,
    WorkoutHistorySetData,
    $$WorkoutHistorySetTableFilterComposer,
    $$WorkoutHistorySetTableOrderingComposer,
    $$WorkoutHistorySetTableAnnotationComposer,
    $$WorkoutHistorySetTableCreateCompanionBuilder,
    $$WorkoutHistorySetTableUpdateCompanionBuilder,
    (WorkoutHistorySetData, $$WorkoutHistorySetTableReferences),
    WorkoutHistorySetData,
    PrefetchHooks Function({bool exerciseId})>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String operation,
  required String data,
  required String table,
  required int timestamp,
  Value<bool> synced,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> operation,
  Value<String> data,
  Value<String> table,
  Value<int> timestamp,
  Value<bool> synced,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get table => $composableBuilder(
      column: $table.table, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get table => $composableBuilder(
      column: $table.table, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get table =>
      $composableBuilder(column: $table.table, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> data = const Value.absent(),
            Value<String> table = const Value.absent(),
            Value<int> timestamp = const Value.absent(),
            Value<bool> synced = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            operation: operation,
            data: data,
            table: table,
            timestamp: timestamp,
            synced: synced,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String operation,
            required String data,
            required String table,
            required int timestamp,
            Value<bool> synced = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            operation: operation,
            data: data,
            table: table,
            timestamp: timestamp,
            synced: synced,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorkoutPlansTableTableManager get workoutPlans =>
      $$WorkoutPlansTableTableManager(_db, _db.workoutPlans);
  $$WeeksTableTableManager get weeks =>
      $$WeeksTableTableManager(_db, _db.weeks);
  $$DaysTableTableManager get days => $$DaysTableTableManager(_db, _db.days);
  $$WorkoutPlanExerciseTableTableManager get workoutPlanExercise =>
      $$WorkoutPlanExerciseTableTableManager(_db, _db.workoutPlanExercise);
  $$ExerciseSetsTableTableManager get exerciseSets =>
      $$ExerciseSetsTableTableManager(_db, _db.exerciseSets);
  $$BaseExerciseTableTableManager get baseExercise =>
      $$BaseExerciseTableTableManager(_db, _db.baseExercise);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$ClientWeightTableTableManager get clientWeight =>
      $$ClientWeightTableTableManager(_db, _db.clientWeight);
  $$WorkoutHistorySetTableTableManager get workoutHistorySet =>
      $$WorkoutHistorySetTableTableManager(_db, _db.workoutHistorySet);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
}
