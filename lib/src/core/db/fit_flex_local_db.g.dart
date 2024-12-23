// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fit_flex_local_db.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
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
  static const VerificationMeta _weightInKgMeta =
      const VerificationMeta('weightInKg');
  @override
  late final GeneratedColumn<double> weightInKg = GeneratedColumn<double>(
      'weight_in_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _weightInLbMeta =
      const VerificationMeta('weightInLb');
  @override
  late final GeneratedColumn<double> weightInLb = GeneratedColumn<double>(
      'weight_in_lb', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _heightInFtMeta =
      const VerificationMeta('heightInFt');
  @override
  late final GeneratedColumn<double> heightInFt = GeneratedColumn<double>(
      'height_in_ft', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _heightInCmMeta =
      const VerificationMeta('heightInCm');
  @override
  late final GeneratedColumn<double> heightInCm = GeneratedColumn<double>(
      'height_in_cm', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
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
  static const VerificationMeta _currentWorkoutPlanNameMeta =
      const VerificationMeta('currentWorkoutPlanName');
  @override
  late final GeneratedColumn<String> currentWorkoutPlanName =
      GeneratedColumn<String>('current_workout_plan_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        age,
        gender,
        weightInKg,
        weightInLb,
        heightInFt,
        heightInCm,
        isTrainer,
        isUserActive,
        username,
        email,
        phone,
        phoneCountryCode,
        currentWorkoutPlanName,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('weight_in_kg')) {
      context.handle(
          _weightInKgMeta,
          weightInKg.isAcceptableOrUnknown(
              data['weight_in_kg']!, _weightInKgMeta));
    }
    if (data.containsKey('weight_in_lb')) {
      context.handle(
          _weightInLbMeta,
          weightInLb.isAcceptableOrUnknown(
              data['weight_in_lb']!, _weightInLbMeta));
    }
    if (data.containsKey('height_in_ft')) {
      context.handle(
          _heightInFtMeta,
          heightInFt.isAcceptableOrUnknown(
              data['height_in_ft']!, _heightInFtMeta));
    }
    if (data.containsKey('height_in_cm')) {
      context.handle(
          _heightInCmMeta,
          heightInCm.isAcceptableOrUnknown(
              data['height_in_cm']!, _heightInCmMeta));
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
    if (data.containsKey('current_workout_plan_name')) {
      context.handle(
          _currentWorkoutPlanNameMeta,
          currentWorkoutPlanName.isAcceptableOrUnknown(
              data['current_workout_plan_name']!, _currentWorkoutPlanNameMeta));
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
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      weightInKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_in_kg']),
      weightInLb: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_in_lb']),
      heightInFt: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height_in_ft']),
      heightInCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height_in_cm']),
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
      currentWorkoutPlanName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}current_workout_plan_name']),
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
  final String id;
  final int? age;
  final String? gender;
  final double? weightInKg;
  final double? weightInLb;
  final double? heightInFt;
  final double? heightInCm;
  final bool isTrainer;
  final bool isUserActive;
  final String username;
  final String? email;
  final String? phone;
  final String? phoneCountryCode;
  final String? currentWorkoutPlanName;
  final int createdAt;
  final int? updatedAt;
  const Client(
      {required this.id,
      this.age,
      this.gender,
      this.weightInKg,
      this.weightInLb,
      this.heightInFt,
      this.heightInCm,
      required this.isTrainer,
      required this.isUserActive,
      required this.username,
      this.email,
      this.phone,
      this.phoneCountryCode,
      this.currentWorkoutPlanName,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || weightInKg != null) {
      map['weight_in_kg'] = Variable<double>(weightInKg);
    }
    if (!nullToAbsent || weightInLb != null) {
      map['weight_in_lb'] = Variable<double>(weightInLb);
    }
    if (!nullToAbsent || heightInFt != null) {
      map['height_in_ft'] = Variable<double>(heightInFt);
    }
    if (!nullToAbsent || heightInCm != null) {
      map['height_in_cm'] = Variable<double>(heightInCm);
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
    if (!nullToAbsent || currentWorkoutPlanName != null) {
      map['current_workout_plan_name'] =
          Variable<String>(currentWorkoutPlanName);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      weightInKg: weightInKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightInKg),
      weightInLb: weightInLb == null && nullToAbsent
          ? const Value.absent()
          : Value(weightInLb),
      heightInFt: heightInFt == null && nullToAbsent
          ? const Value.absent()
          : Value(heightInFt),
      heightInCm: heightInCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightInCm),
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
      currentWorkoutPlanName: currentWorkoutPlanName == null && nullToAbsent
          ? const Value.absent()
          : Value(currentWorkoutPlanName),
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
      id: serializer.fromJson<String>(json['id']),
      age: serializer.fromJson<int?>(json['age']),
      gender: serializer.fromJson<String?>(json['gender']),
      weightInKg: serializer.fromJson<double?>(json['weightInKg']),
      weightInLb: serializer.fromJson<double?>(json['weightInLb']),
      heightInFt: serializer.fromJson<double?>(json['heightInFt']),
      heightInCm: serializer.fromJson<double?>(json['heightInCm']),
      isTrainer: serializer.fromJson<bool>(json['isTrainer']),
      isUserActive: serializer.fromJson<bool>(json['isUserActive']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      phoneCountryCode: serializer.fromJson<String?>(json['phoneCountryCode']),
      currentWorkoutPlanName:
          serializer.fromJson<String?>(json['currentWorkoutPlanName']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'age': serializer.toJson<int?>(age),
      'gender': serializer.toJson<String?>(gender),
      'weightInKg': serializer.toJson<double?>(weightInKg),
      'weightInLb': serializer.toJson<double?>(weightInLb),
      'heightInFt': serializer.toJson<double?>(heightInFt),
      'heightInCm': serializer.toJson<double?>(heightInCm),
      'isTrainer': serializer.toJson<bool>(isTrainer),
      'isUserActive': serializer.toJson<bool>(isUserActive),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'phoneCountryCode': serializer.toJson<String?>(phoneCountryCode),
      'currentWorkoutPlanName':
          serializer.toJson<String?>(currentWorkoutPlanName),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  Client copyWith(
          {String? id,
          Value<int?> age = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<double?> weightInKg = const Value.absent(),
          Value<double?> weightInLb = const Value.absent(),
          Value<double?> heightInFt = const Value.absent(),
          Value<double?> heightInCm = const Value.absent(),
          bool? isTrainer,
          bool? isUserActive,
          String? username,
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> phoneCountryCode = const Value.absent(),
          Value<String?> currentWorkoutPlanName = const Value.absent(),
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      Client(
        id: id ?? this.id,
        age: age.present ? age.value : this.age,
        gender: gender.present ? gender.value : this.gender,
        weightInKg: weightInKg.present ? weightInKg.value : this.weightInKg,
        weightInLb: weightInLb.present ? weightInLb.value : this.weightInLb,
        heightInFt: heightInFt.present ? heightInFt.value : this.heightInFt,
        heightInCm: heightInCm.present ? heightInCm.value : this.heightInCm,
        isTrainer: isTrainer ?? this.isTrainer,
        isUserActive: isUserActive ?? this.isUserActive,
        username: username ?? this.username,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        phoneCountryCode: phoneCountryCode.present
            ? phoneCountryCode.value
            : this.phoneCountryCode,
        currentWorkoutPlanName: currentWorkoutPlanName.present
            ? currentWorkoutPlanName.value
            : this.currentWorkoutPlanName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      age: data.age.present ? data.age.value : this.age,
      gender: data.gender.present ? data.gender.value : this.gender,
      weightInKg:
          data.weightInKg.present ? data.weightInKg.value : this.weightInKg,
      weightInLb:
          data.weightInLb.present ? data.weightInLb.value : this.weightInLb,
      heightInFt:
          data.heightInFt.present ? data.heightInFt.value : this.heightInFt,
      heightInCm:
          data.heightInCm.present ? data.heightInCm.value : this.heightInCm,
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
      currentWorkoutPlanName: data.currentWorkoutPlanName.present
          ? data.currentWorkoutPlanName.value
          : this.currentWorkoutPlanName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('weightInKg: $weightInKg, ')
          ..write('weightInLb: $weightInLb, ')
          ..write('heightInFt: $heightInFt, ')
          ..write('heightInCm: $heightInCm, ')
          ..write('isTrainer: $isTrainer, ')
          ..write('isUserActive: $isUserActive, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('phoneCountryCode: $phoneCountryCode, ')
          ..write('currentWorkoutPlanName: $currentWorkoutPlanName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      age,
      gender,
      weightInKg,
      weightInLb,
      heightInFt,
      heightInCm,
      isTrainer,
      isUserActive,
      username,
      email,
      phone,
      phoneCountryCode,
      currentWorkoutPlanName,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.age == this.age &&
          other.gender == this.gender &&
          other.weightInKg == this.weightInKg &&
          other.weightInLb == this.weightInLb &&
          other.heightInFt == this.heightInFt &&
          other.heightInCm == this.heightInCm &&
          other.isTrainer == this.isTrainer &&
          other.isUserActive == this.isUserActive &&
          other.username == this.username &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.phoneCountryCode == this.phoneCountryCode &&
          other.currentWorkoutPlanName == this.currentWorkoutPlanName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<String> id;
  final Value<int?> age;
  final Value<String?> gender;
  final Value<double?> weightInKg;
  final Value<double?> weightInLb;
  final Value<double?> heightInFt;
  final Value<double?> heightInCm;
  final Value<bool> isTrainer;
  final Value<bool> isUserActive;
  final Value<String> username;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> phoneCountryCode;
  final Value<String?> currentWorkoutPlanName;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.weightInKg = const Value.absent(),
    this.weightInLb = const Value.absent(),
    this.heightInFt = const Value.absent(),
    this.heightInCm = const Value.absent(),
    this.isTrainer = const Value.absent(),
    this.isUserActive = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.phoneCountryCode = const Value.absent(),
    this.currentWorkoutPlanName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsCompanion.insert({
    required String id,
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.weightInKg = const Value.absent(),
    this.weightInLb = const Value.absent(),
    this.heightInFt = const Value.absent(),
    this.heightInCm = const Value.absent(),
    required bool isTrainer,
    required bool isUserActive,
    required String username,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.phoneCountryCode = const Value.absent(),
    this.currentWorkoutPlanName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        isTrainer = Value(isTrainer),
        isUserActive = Value(isUserActive),
        username = Value(username);
  static Insertable<Client> custom({
    Expression<String>? id,
    Expression<int>? age,
    Expression<String>? gender,
    Expression<double>? weightInKg,
    Expression<double>? weightInLb,
    Expression<double>? heightInFt,
    Expression<double>? heightInCm,
    Expression<bool>? isTrainer,
    Expression<bool>? isUserActive,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? phoneCountryCode,
    Expression<String>? currentWorkoutPlanName,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (weightInKg != null) 'weight_in_kg': weightInKg,
      if (weightInLb != null) 'weight_in_lb': weightInLb,
      if (heightInFt != null) 'height_in_ft': heightInFt,
      if (heightInCm != null) 'height_in_cm': heightInCm,
      if (isTrainer != null) 'is_trainer': isTrainer,
      if (isUserActive != null) 'is_user_active': isUserActive,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (phoneCountryCode != null) 'phone_country_code': phoneCountryCode,
      if (currentWorkoutPlanName != null)
        'current_workout_plan_name': currentWorkoutPlanName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsCompanion copyWith(
      {Value<String>? id,
      Value<int?>? age,
      Value<String?>? gender,
      Value<double?>? weightInKg,
      Value<double?>? weightInLb,
      Value<double?>? heightInFt,
      Value<double?>? heightInCm,
      Value<bool>? isTrainer,
      Value<bool>? isUserActive,
      Value<String>? username,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? phoneCountryCode,
      Value<String?>? currentWorkoutPlanName,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return ClientsCompanion(
      id: id ?? this.id,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weightInKg: weightInKg ?? this.weightInKg,
      weightInLb: weightInLb ?? this.weightInLb,
      heightInFt: heightInFt ?? this.heightInFt,
      heightInCm: heightInCm ?? this.heightInCm,
      isTrainer: isTrainer ?? this.isTrainer,
      isUserActive: isUserActive ?? this.isUserActive,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      currentWorkoutPlanName:
          currentWorkoutPlanName ?? this.currentWorkoutPlanName,
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
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (weightInKg.present) {
      map['weight_in_kg'] = Variable<double>(weightInKg.value);
    }
    if (weightInLb.present) {
      map['weight_in_lb'] = Variable<double>(weightInLb.value);
    }
    if (heightInFt.present) {
      map['height_in_ft'] = Variable<double>(heightInFt.value);
    }
    if (heightInCm.present) {
      map['height_in_cm'] = Variable<double>(heightInCm.value);
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
    if (currentWorkoutPlanName.present) {
      map['current_workout_plan_name'] =
          Variable<String>(currentWorkoutPlanName.value);
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
          ..write('id: $id, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('weightInKg: $weightInKg, ')
          ..write('weightInLb: $weightInLb, ')
          ..write('heightInFt: $heightInFt, ')
          ..write('heightInCm: $heightInCm, ')
          ..write('isTrainer: $isTrainer, ')
          ..write('isUserActive: $isUserActive, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('phoneCountryCode: $phoneCountryCode, ')
          ..write('currentWorkoutPlanName: $currentWorkoutPlanName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

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
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [uid, name, createdAt, updatedAt, clientId];
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
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
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
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id']),
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
  final String? clientId;
  const WorkoutPlan(
      {required this.uid,
      required this.name,
      required this.createdAt,
      this.updatedAt,
      this.clientId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
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
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
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
      clientId: serializer.fromJson<String?>(json['clientId']),
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
      'clientId': serializer.toJson<String?>(clientId),
    };
  }

  WorkoutPlan copyWith(
          {String? uid,
          String? name,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent(),
          Value<String?> clientId = const Value.absent()}) =>
      WorkoutPlan(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        clientId: clientId.present ? clientId.value : this.clientId,
      );
  WorkoutPlan copyWithCompanion(WorkoutPlansCompanion data) {
    return WorkoutPlan(
      uid: data.uid.present ? data.uid.value : this.uid,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlan(')
          ..write('uid: $uid, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('clientId: $clientId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, name, createdAt, updatedAt, clientId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutPlan &&
          other.uid == this.uid &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.clientId == this.clientId);
}

class WorkoutPlansCompanion extends UpdateCompanion<WorkoutPlan> {
  final Value<String> uid;
  final Value<String> name;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<String?> clientId;
  final Value<int> rowid;
  const WorkoutPlansCompanion({
    this.uid = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.clientId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutPlansCompanion.insert({
    required String uid,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.clientId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        name = Value(name);
  static Insertable<WorkoutPlan> custom({
    Expression<String>? uid,
    Expression<String>? name,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? clientId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (clientId != null) 'client_id': clientId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutPlansCompanion copyWith(
      {Value<String>? uid,
      Value<String>? name,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<String?>? clientId,
      Value<int>? rowid}) {
    return WorkoutPlansCompanion(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      clientId: clientId ?? this.clientId,
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
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
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
          ..write('clientId: $clientId, ')
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
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
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
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workoutPlanId, clientId, weekNumber, createdAt, updatedAt];
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
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
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
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id']),
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
  final String? clientId;
  final int weekNumber;
  final int createdAt;
  final int? updatedAt;
  const Week(
      {required this.id,
      required this.workoutPlanId,
      this.clientId,
      required this.weekNumber,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_plan_id'] = Variable<String>(workoutPlanId);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
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
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
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
      clientId: serializer.fromJson<String?>(json['clientId']),
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
      'clientId': serializer.toJson<String?>(clientId),
      'weekNumber': serializer.toJson<int>(weekNumber),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  Week copyWith(
          {String? id,
          String? workoutPlanId,
          Value<String?> clientId = const Value.absent(),
          int? weekNumber,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      Week(
        id: id ?? this.id,
        workoutPlanId: workoutPlanId ?? this.workoutPlanId,
        clientId: clientId.present ? clientId.value : this.clientId,
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
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
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
          ..write('clientId: $clientId, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, workoutPlanId, clientId, weekNumber, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Week &&
          other.id == this.id &&
          other.workoutPlanId == this.workoutPlanId &&
          other.clientId == this.clientId &&
          other.weekNumber == this.weekNumber &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WeeksCompanion extends UpdateCompanion<Week> {
  final Value<String> id;
  final Value<String> workoutPlanId;
  final Value<String?> clientId;
  final Value<int> weekNumber;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const WeeksCompanion({
    this.id = const Value.absent(),
    this.workoutPlanId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.weekNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeksCompanion.insert({
    required String id,
    required String workoutPlanId,
    this.clientId = const Value.absent(),
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
    Expression<String>? clientId,
    Expression<int>? weekNumber,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutPlanId != null) 'workout_plan_id': workoutPlanId,
      if (clientId != null) 'client_id': clientId,
      if (weekNumber != null) 'week_number': weekNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeksCompanion copyWith(
      {Value<String>? id,
      Value<String>? workoutPlanId,
      Value<String?>? clientId,
      Value<int>? weekNumber,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return WeeksCompanion(
      id: id ?? this.id,
      workoutPlanId: workoutPlanId ?? this.workoutPlanId,
      clientId: clientId ?? this.clientId,
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
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
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
          ..write('clientId: $clientId, ')
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
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
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
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, weekId, clientId, dayNumber, createdAt, updatedAt];
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
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
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
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id']),
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
  final String? clientId;
  final int dayNumber;
  final int createdAt;
  final int? updatedAt;
  const Day(
      {required this.id,
      required this.weekId,
      this.clientId,
      required this.dayNumber,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['week_id'] = Variable<String>(weekId);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
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
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
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
      clientId: serializer.fromJson<String?>(json['clientId']),
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
      'clientId': serializer.toJson<String?>(clientId),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  Day copyWith(
          {String? id,
          String? weekId,
          Value<String?> clientId = const Value.absent(),
          int? dayNumber,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      Day(
        id: id ?? this.id,
        weekId: weekId ?? this.weekId,
        clientId: clientId.present ? clientId.value : this.clientId,
        dayNumber: dayNumber ?? this.dayNumber,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Day copyWithCompanion(DaysCompanion data) {
    return Day(
      id: data.id.present ? data.id.value : this.id,
      weekId: data.weekId.present ? data.weekId.value : this.weekId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
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
          ..write('clientId: $clientId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, weekId, clientId, dayNumber, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Day &&
          other.id == this.id &&
          other.weekId == this.weekId &&
          other.clientId == this.clientId &&
          other.dayNumber == this.dayNumber &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DaysCompanion extends UpdateCompanion<Day> {
  final Value<String> id;
  final Value<String> weekId;
  final Value<String?> clientId;
  final Value<int> dayNumber;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const DaysCompanion({
    this.id = const Value.absent(),
    this.weekId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DaysCompanion.insert({
    required String id,
    required String weekId,
    this.clientId = const Value.absent(),
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
    Expression<String>? clientId,
    Expression<int>? dayNumber,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekId != null) 'week_id': weekId,
      if (clientId != null) 'client_id': clientId,
      if (dayNumber != null) 'day_number': dayNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DaysCompanion copyWith(
      {Value<String>? id,
      Value<String>? weekId,
      Value<String?>? clientId,
      Value<int>? dayNumber,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return DaysCompanion(
      id: id ?? this.id,
      weekId: weekId ?? this.weekId,
      clientId: clientId ?? this.clientId,
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
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
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
          ..write('clientId: $clientId, ')
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
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
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
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clientId,
        dayId,
        code,
        exerciseOrder,
        completed,
        createdAt,
        updatedAt
      ];
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
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
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
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
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
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id']),
      dayId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      exerciseOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_order'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
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
  final String? clientId;
  final String dayId;
  final String code;
  final int exerciseOrder;
  final bool completed;
  final int createdAt;
  final int? updatedAt;
  const WorkoutPlanExerciseData(
      {required this.id,
      this.clientId,
      required this.dayId,
      required this.code,
      required this.exerciseOrder,
      required this.completed,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
    map['day_id'] = Variable<String>(dayId);
    map['code'] = Variable<String>(code);
    map['exercise_order'] = Variable<int>(exerciseOrder);
    map['completed'] = Variable<bool>(completed);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  WorkoutPlanExerciseCompanion toCompanion(bool nullToAbsent) {
    return WorkoutPlanExerciseCompanion(
      id: Value(id),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      dayId: Value(dayId),
      code: Value(code),
      exerciseOrder: Value(exerciseOrder),
      completed: Value(completed),
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
      clientId: serializer.fromJson<String?>(json['clientId']),
      dayId: serializer.fromJson<String>(json['dayId']),
      code: serializer.fromJson<String>(json['code']),
      exerciseOrder: serializer.fromJson<int>(json['exerciseOrder']),
      completed: serializer.fromJson<bool>(json['completed']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String?>(clientId),
      'dayId': serializer.toJson<String>(dayId),
      'code': serializer.toJson<String>(code),
      'exerciseOrder': serializer.toJson<int>(exerciseOrder),
      'completed': serializer.toJson<bool>(completed),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  WorkoutPlanExerciseData copyWith(
          {String? id,
          Value<String?> clientId = const Value.absent(),
          String? dayId,
          String? code,
          int? exerciseOrder,
          bool? completed,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      WorkoutPlanExerciseData(
        id: id ?? this.id,
        clientId: clientId.present ? clientId.value : this.clientId,
        dayId: dayId ?? this.dayId,
        code: code ?? this.code,
        exerciseOrder: exerciseOrder ?? this.exerciseOrder,
        completed: completed ?? this.completed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  WorkoutPlanExerciseData copyWithCompanion(WorkoutPlanExerciseCompanion data) {
    return WorkoutPlanExerciseData(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      dayId: data.dayId.present ? data.dayId.value : this.dayId,
      code: data.code.present ? data.code.value : this.code,
      exerciseOrder: data.exerciseOrder.present
          ? data.exerciseOrder.value
          : this.exerciseOrder,
      completed: data.completed.present ? data.completed.value : this.completed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlanExerciseData(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('dayId: $dayId, ')
          ..write('code: $code, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('completed: $completed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientId, dayId, code, exerciseOrder,
      completed, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutPlanExerciseData &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.dayId == this.dayId &&
          other.code == this.code &&
          other.exerciseOrder == this.exerciseOrder &&
          other.completed == this.completed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutPlanExerciseCompanion
    extends UpdateCompanion<WorkoutPlanExerciseData> {
  final Value<String> id;
  final Value<String?> clientId;
  final Value<String> dayId;
  final Value<String> code;
  final Value<int> exerciseOrder;
  final Value<bool> completed;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const WorkoutPlanExerciseCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.dayId = const Value.absent(),
    this.code = const Value.absent(),
    this.exerciseOrder = const Value.absent(),
    this.completed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutPlanExerciseCompanion.insert({
    required String id,
    this.clientId = const Value.absent(),
    required String dayId,
    required String code,
    required int exerciseOrder,
    this.completed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        dayId = Value(dayId),
        code = Value(code),
        exerciseOrder = Value(exerciseOrder);
  static Insertable<WorkoutPlanExerciseData> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? dayId,
    Expression<String>? code,
    Expression<int>? exerciseOrder,
    Expression<bool>? completed,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (dayId != null) 'day_id': dayId,
      if (code != null) 'code': code,
      if (exerciseOrder != null) 'exercise_order': exerciseOrder,
      if (completed != null) 'completed': completed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutPlanExerciseCompanion copyWith(
      {Value<String>? id,
      Value<String?>? clientId,
      Value<String>? dayId,
      Value<String>? code,
      Value<int>? exerciseOrder,
      Value<bool>? completed,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return WorkoutPlanExerciseCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      dayId: dayId ?? this.dayId,
      code: code ?? this.code,
      exerciseOrder: exerciseOrder ?? this.exerciseOrder,
      completed: completed ?? this.completed,
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
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
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
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
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
          ..write('clientId: $clientId, ')
          ..write('dayId: $dayId, ')
          ..write('code: $code, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('completed: $completed, ')
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
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
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
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
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
        clientId,
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
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
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
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id']),
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
  final String? clientId;
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
      this.clientId,
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
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
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
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
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
      clientId: serializer.fromJson<String?>(json['clientId']),
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
      'clientId': serializer.toJson<String?>(clientId),
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
          Value<String?> clientId = const Value.absent(),
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
        clientId: clientId.present ? clientId.value : this.clientId,
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
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
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
          ..write('clientId: $clientId, ')
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
  int get hashCode => Object.hash(
      id,
      exerciseId,
      clientId,
      targetReps,
      targetWeight,
      targetDistance,
      targetTime,
      createdAt,
      updatedAt,
      setNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSet &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.clientId == this.clientId &&
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
  final Value<String?> clientId;
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
    this.clientId = const Value.absent(),
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
    this.clientId = const Value.absent(),
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
    Expression<String>? clientId,
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
      if (clientId != null) 'client_id': clientId,
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
      Value<String?>? clientId,
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
      clientId: clientId ?? this.clientId,
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
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
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
          ..write('clientId: $clientId, ')
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
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
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
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clientId,
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
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
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
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id']),
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
  final String? clientId;
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
      this.clientId,
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
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
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
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
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
      clientId: serializer.fromJson<String?>(json['clientId']),
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
      'clientId': serializer.toJson<String?>(clientId),
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
          Value<String?> clientId = const Value.absent(),
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
        clientId: clientId.present ? clientId.value : this.clientId,
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
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
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
          ..write('clientId: $clientId, ')
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
  int get hashCode => Object.hash(id, clientId, code, category, muscleGroup,
      name, reps, duration, weight, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BaseExerciseData &&
          other.id == this.id &&
          other.clientId == this.clientId &&
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
  final Value<String?> clientId;
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
    this.clientId = const Value.absent(),
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
    this.clientId = const Value.absent(),
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
    Expression<String>? clientId,
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
      if (clientId != null) 'client_id': clientId,
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
      Value<String?>? clientId,
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
      clientId: clientId ?? this.clientId,
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
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
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
          ..write('clientId: $clientId, ')
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
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [clientId, timeStamp, weightInKg, weightInLb, createdAt, updatedAt];
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
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
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
  final int createdAt;
  final int? updatedAt;
  const ClientWeightData(
      {this.clientId,
      required this.timeStamp,
      required this.weightInKg,
      required this.weightInLb,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
    map['time_stamp'] = Variable<int>(timeStamp);
    map['weight_in_kg'] = Variable<double>(weightInKg);
    map['weight_in_lb'] = Variable<double>(weightInLb);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
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
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
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
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
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
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  ClientWeightData copyWith(
          {Value<String?> clientId = const Value.absent(),
          int? timeStamp,
          double? weightInKg,
          double? weightInLb,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
      ClientWeightData(
        clientId: clientId.present ? clientId.value : this.clientId,
        timeStamp: timeStamp ?? this.timeStamp,
        weightInKg: weightInKg ?? this.weightInKg,
        weightInLb: weightInLb ?? this.weightInLb,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ClientWeightData copyWithCompanion(ClientWeightCompanion data) {
    return ClientWeightData(
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      timeStamp: data.timeStamp.present ? data.timeStamp.value : this.timeStamp,
      weightInKg:
          data.weightInKg.present ? data.weightInKg.value : this.weightInKg,
      weightInLb:
          data.weightInLb.present ? data.weightInLb.value : this.weightInLb,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientWeightData(')
          ..write('clientId: $clientId, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('weightInKg: $weightInKg, ')
          ..write('weightInLb: $weightInLb, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      clientId, timeStamp, weightInKg, weightInLb, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientWeightData &&
          other.clientId == this.clientId &&
          other.timeStamp == this.timeStamp &&
          other.weightInKg == this.weightInKg &&
          other.weightInLb == this.weightInLb &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClientWeightCompanion extends UpdateCompanion<ClientWeightData> {
  final Value<String?> clientId;
  final Value<int> timeStamp;
  final Value<double> weightInKg;
  final Value<double> weightInLb;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const ClientWeightCompanion({
    this.clientId = const Value.absent(),
    this.timeStamp = const Value.absent(),
    this.weightInKg = const Value.absent(),
    this.weightInLb = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientWeightCompanion.insert({
    this.clientId = const Value.absent(),
    required int timeStamp,
    required double weightInKg,
    required double weightInLb,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : timeStamp = Value(timeStamp),
        weightInKg = Value(weightInKg),
        weightInLb = Value(weightInLb);
  static Insertable<ClientWeightData> custom({
    Expression<String>? clientId,
    Expression<int>? timeStamp,
    Expression<double>? weightInKg,
    Expression<double>? weightInLb,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (timeStamp != null) 'time_stamp': timeStamp,
      if (weightInKg != null) 'weight_in_kg': weightInKg,
      if (weightInLb != null) 'weight_in_lb': weightInLb,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientWeightCompanion copyWith(
      {Value<String?>? clientId,
      Value<int>? timeStamp,
      Value<double>? weightInKg,
      Value<double>? weightInLb,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return ClientWeightCompanion(
      clientId: clientId ?? this.clientId,
      timeStamp: timeStamp ?? this.timeStamp,
      weightInKg: weightInKg ?? this.weightInKg,
      weightInLb: weightInLb ?? this.weightInLb,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    return (StringBuffer('ClientWeightCompanion(')
          ..write('clientId: $clientId, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('weightInKg: $weightInKg, ')
          ..write('weightInLb: $weightInLb, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      clientDefault: () => DateTime.now().millisecondsSinceEpoch);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
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
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $WorkoutHistorySetTable createAlias(String alias) {
    return $WorkoutHistorySetTable(attachedDatabase, alias);
  }
}

class WorkoutHistorySetData extends DataClass
    implements Insertable<WorkoutHistorySetData> {
  final String id;
  final String clientId;
  final String exerciseId;
  final int? actualReps;
  final double? actualWeight;
  final double? actualDistance;
  final int? actualTime;
  final int createdAt;
  final int? updatedAt;
  const WorkoutHistorySetData(
      {required this.id,
      required this.clientId,
      required this.exerciseId,
      this.actualReps,
      this.actualWeight,
      this.actualDistance,
      this.actualTime,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
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
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
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
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory WorkoutHistorySetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutHistorySetData(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      actualReps: serializer.fromJson<int?>(json['actualReps']),
      actualWeight: serializer.fromJson<double?>(json['actualWeight']),
      actualDistance: serializer.fromJson<double?>(json['actualDistance']),
      actualTime: serializer.fromJson<int?>(json['actualTime']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'actualReps': serializer.toJson<int?>(actualReps),
      'actualWeight': serializer.toJson<double?>(actualWeight),
      'actualDistance': serializer.toJson<double?>(actualDistance),
      'actualTime': serializer.toJson<int?>(actualTime),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  WorkoutHistorySetData copyWith(
          {String? id,
          String? clientId,
          String? exerciseId,
          Value<int?> actualReps = const Value.absent(),
          Value<double?> actualWeight = const Value.absent(),
          Value<double?> actualDistance = const Value.absent(),
          Value<int?> actualTime = const Value.absent(),
          int? createdAt,
          Value<int?> updatedAt = const Value.absent()}) =>
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
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
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
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> exerciseId;
  final Value<int?> actualReps;
  final Value<double?> actualWeight;
  final Value<double?> actualDistance;
  final Value<int?> actualTime;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
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
    this.rowid = const Value.absent(),
  });
  WorkoutHistorySetCompanion.insert({
    required String id,
    required String clientId,
    required String exerciseId,
    this.actualReps = const Value.absent(),
    this.actualWeight = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.actualTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        clientId = Value(clientId),
        exerciseId = Value(exerciseId);
  static Insertable<WorkoutHistorySetData> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? exerciseId,
    Expression<int>? actualReps,
    Expression<double>? actualWeight,
    Expression<double>? actualDistance,
    Expression<int>? actualTime,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
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
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutHistorySetCompanion copyWith(
      {Value<String>? id,
      Value<String>? clientId,
      Value<String>? exerciseId,
      Value<int?>? actualReps,
      Value<double?>? actualWeight,
      Value<double?>? actualDistance,
      Value<int?>? actualTime,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
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
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
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
  late final $ClientsTable clients = $ClientsTable(this);
  late final $WorkoutPlansTable workoutPlans = $WorkoutPlansTable(this);
  late final $WeeksTable weeks = $WeeksTable(this);
  late final $DaysTable days = $DaysTable(this);
  late final $WorkoutPlanExerciseTable workoutPlanExercise =
      $WorkoutPlanExerciseTable(this);
  late final $ExerciseSetsTable exerciseSets = $ExerciseSetsTable(this);
  late final $BaseExerciseTable baseExercise = $BaseExerciseTable(this);
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
        clients,
        workoutPlans,
        weeks,
        days,
        workoutPlanExercise,
        exerciseSets,
        baseExercise,
        clientWeight,
        workoutHistorySet,
        syncQueue
      ];
}

typedef $$ClientsTableCreateCompanionBuilder = ClientsCompanion Function({
  required String id,
  Value<int?> age,
  Value<String?> gender,
  Value<double?> weightInKg,
  Value<double?> weightInLb,
  Value<double?> heightInFt,
  Value<double?> heightInCm,
  required bool isTrainer,
  required bool isUserActive,
  required String username,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> phoneCountryCode,
  Value<String?> currentWorkoutPlanName,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$ClientsTableUpdateCompanionBuilder = ClientsCompanion Function({
  Value<String> id,
  Value<int?> age,
  Value<String?> gender,
  Value<double?> weightInKg,
  Value<double?> weightInLb,
  Value<double?> heightInFt,
  Value<double?> heightInCm,
  Value<bool> isTrainer,
  Value<bool> isUserActive,
  Value<String> username,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> phoneCountryCode,
  Value<String?> currentWorkoutPlanName,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkoutPlansTable, List<WorkoutPlan>>
      _workoutPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.workoutPlans,
          aliasName:
              $_aliasNameGenerator(db.clients.id, db.workoutPlans.clientId));

  $$WorkoutPlansTableProcessedTableManager get workoutPlansRefs {
    final manager = $$WorkoutPlansTableTableManager($_db, $_db.workoutPlans)
        .filter((f) => f.clientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_workoutPlansRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WeeksTable, List<Week>> _weeksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.weeks,
          aliasName: $_aliasNameGenerator(db.clients.id, db.weeks.clientId));

  $$WeeksTableProcessedTableManager get weeksRefs {
    final manager = $$WeeksTableTableManager($_db, $_db.weeks)
        .filter((f) => f.clientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_weeksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DaysTable, List<Day>> _daysRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.days,
          aliasName: $_aliasNameGenerator(db.clients.id, db.days.clientId));

  $$DaysTableProcessedTableManager get daysRefs {
    final manager = $$DaysTableTableManager($_db, $_db.days)
        .filter((f) => f.clientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_daysRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkoutPlanExerciseTable,
      List<WorkoutPlanExerciseData>> _workoutPlanExerciseRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.workoutPlanExercise,
          aliasName: $_aliasNameGenerator(
              db.clients.id, db.workoutPlanExercise.clientId));

  $$WorkoutPlanExerciseTableProcessedTableManager get workoutPlanExerciseRefs {
    final manager =
        $$WorkoutPlanExerciseTableTableManager($_db, $_db.workoutPlanExercise)
            .filter((f) => f.clientId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_workoutPlanExerciseRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExerciseSetsTable, List<ExerciseSet>>
      _exerciseSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.exerciseSets,
          aliasName:
              $_aliasNameGenerator(db.clients.id, db.exerciseSets.clientId));

  $$ExerciseSetsTableProcessedTableManager get exerciseSetsRefs {
    final manager = $$ExerciseSetsTableTableManager($_db, $_db.exerciseSets)
        .filter((f) => f.clientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_exerciseSetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BaseExerciseTable, List<BaseExerciseData>>
      _baseExerciseRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.baseExercise,
          aliasName:
              $_aliasNameGenerator(db.clients.id, db.baseExercise.clientId));

  $$BaseExerciseTableProcessedTableManager get baseExerciseRefs {
    final manager = $$BaseExerciseTableTableManager($_db, $_db.baseExercise)
        .filter((f) => f.clientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_baseExerciseRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightInKg => $composableBuilder(
      column: $table.weightInKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightInLb => $composableBuilder(
      column: $table.weightInLb, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get heightInFt => $composableBuilder(
      column: $table.heightInFt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get heightInCm => $composableBuilder(
      column: $table.heightInCm, builder: (column) => ColumnFilters(column));

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

  ColumnFilters<String> get currentWorkoutPlanName => $composableBuilder(
      column: $table.currentWorkoutPlanName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> workoutPlansRefs(
      Expression<bool> Function($$WorkoutPlansTableFilterComposer f) f) {
    final $$WorkoutPlansTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutPlans,
        getReferencedColumn: (t) => t.clientId,
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
    return f(composer);
  }

  Expression<bool> weeksRefs(
      Expression<bool> Function($$WeeksTableFilterComposer f) f) {
    final $$WeeksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.clientId,
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

  Expression<bool> daysRefs(
      Expression<bool> Function($$DaysTableFilterComposer f) f) {
    final $$DaysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.days,
        getReferencedColumn: (t) => t.clientId,
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

  Expression<bool> workoutPlanExerciseRefs(
      Expression<bool> Function($$WorkoutPlanExerciseTableFilterComposer f) f) {
    final $$WorkoutPlanExerciseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutPlanExercise,
        getReferencedColumn: (t) => t.clientId,
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

  Expression<bool> exerciseSetsRefs(
      Expression<bool> Function($$ExerciseSetsTableFilterComposer f) f) {
    final $$ExerciseSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseSets,
        getReferencedColumn: (t) => t.clientId,
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

  Expression<bool> baseExerciseRefs(
      Expression<bool> Function($$BaseExerciseTableFilterComposer f) f) {
    final $$BaseExerciseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.baseExercise,
        getReferencedColumn: (t) => t.clientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BaseExerciseTableFilterComposer(
              $db: $db,
              $table: $db.baseExercise,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightInKg => $composableBuilder(
      column: $table.weightInKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightInLb => $composableBuilder(
      column: $table.weightInLb, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get heightInFt => $composableBuilder(
      column: $table.heightInFt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get heightInCm => $composableBuilder(
      column: $table.heightInCm, builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<String> get currentWorkoutPlanName => $composableBuilder(
      column: $table.currentWorkoutPlanName,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<double> get weightInKg => $composableBuilder(
      column: $table.weightInKg, builder: (column) => column);

  GeneratedColumn<double> get weightInLb => $composableBuilder(
      column: $table.weightInLb, builder: (column) => column);

  GeneratedColumn<double> get heightInFt => $composableBuilder(
      column: $table.heightInFt, builder: (column) => column);

  GeneratedColumn<double> get heightInCm => $composableBuilder(
      column: $table.heightInCm, builder: (column) => column);

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

  GeneratedColumn<String> get currentWorkoutPlanName => $composableBuilder(
      column: $table.currentWorkoutPlanName, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> workoutPlansRefs<T extends Object>(
      Expression<T> Function($$WorkoutPlansTableAnnotationComposer a) f) {
    final $$WorkoutPlansTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutPlans,
        getReferencedColumn: (t) => t.clientId,
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
    return f(composer);
  }

  Expression<T> weeksRefs<T extends Object>(
      Expression<T> Function($$WeeksTableAnnotationComposer a) f) {
    final $$WeeksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weeks,
        getReferencedColumn: (t) => t.clientId,
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

  Expression<T> daysRefs<T extends Object>(
      Expression<T> Function($$DaysTableAnnotationComposer a) f) {
    final $$DaysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.days,
        getReferencedColumn: (t) => t.clientId,
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

  Expression<T> workoutPlanExerciseRefs<T extends Object>(
      Expression<T> Function($$WorkoutPlanExerciseTableAnnotationComposer a)
          f) {
    final $$WorkoutPlanExerciseTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.workoutPlanExercise,
            getReferencedColumn: (t) => t.clientId,
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

  Expression<T> exerciseSetsRefs<T extends Object>(
      Expression<T> Function($$ExerciseSetsTableAnnotationComposer a) f) {
    final $$ExerciseSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseSets,
        getReferencedColumn: (t) => t.clientId,
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

  Expression<T> baseExerciseRefs<T extends Object>(
      Expression<T> Function($$BaseExerciseTableAnnotationComposer a) f) {
    final $$BaseExerciseTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.baseExercise,
        getReferencedColumn: (t) => t.clientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BaseExerciseTableAnnotationComposer(
              $db: $db,
              $table: $db.baseExercise,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
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
    (Client, $$ClientsTableReferences),
    Client,
    PrefetchHooks Function(
        {bool workoutPlansRefs,
        bool weeksRefs,
        bool daysRefs,
        bool workoutPlanExerciseRefs,
        bool exerciseSetsRefs,
        bool baseExerciseRefs})> {
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
            Value<String> id = const Value.absent(),
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> weightInKg = const Value.absent(),
            Value<double?> weightInLb = const Value.absent(),
            Value<double?> heightInFt = const Value.absent(),
            Value<double?> heightInCm = const Value.absent(),
            Value<bool> isTrainer = const Value.absent(),
            Value<bool> isUserActive = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> phoneCountryCode = const Value.absent(),
            Value<String?> currentWorkoutPlanName = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientsCompanion(
            id: id,
            age: age,
            gender: gender,
            weightInKg: weightInKg,
            weightInLb: weightInLb,
            heightInFt: heightInFt,
            heightInCm: heightInCm,
            isTrainer: isTrainer,
            isUserActive: isUserActive,
            username: username,
            email: email,
            phone: phone,
            phoneCountryCode: phoneCountryCode,
            currentWorkoutPlanName: currentWorkoutPlanName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> weightInKg = const Value.absent(),
            Value<double?> weightInLb = const Value.absent(),
            Value<double?> heightInFt = const Value.absent(),
            Value<double?> heightInCm = const Value.absent(),
            required bool isTrainer,
            required bool isUserActive,
            required String username,
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> phoneCountryCode = const Value.absent(),
            Value<String?> currentWorkoutPlanName = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientsCompanion.insert(
            id: id,
            age: age,
            gender: gender,
            weightInKg: weightInKg,
            weightInLb: weightInLb,
            heightInFt: heightInFt,
            heightInCm: heightInCm,
            isTrainer: isTrainer,
            isUserActive: isUserActive,
            username: username,
            email: email,
            phone: phone,
            phoneCountryCode: phoneCountryCode,
            currentWorkoutPlanName: currentWorkoutPlanName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ClientsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {workoutPlansRefs = false,
              weeksRefs = false,
              daysRefs = false,
              workoutPlanExerciseRefs = false,
              exerciseSetsRefs = false,
              baseExerciseRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (workoutPlansRefs) db.workoutPlans,
                if (weeksRefs) db.weeks,
                if (daysRefs) db.days,
                if (workoutPlanExerciseRefs) db.workoutPlanExercise,
                if (exerciseSetsRefs) db.exerciseSets,
                if (baseExerciseRefs) db.baseExercise
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutPlansRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._workoutPlansRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0)
                                .workoutPlansRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.clientId == item.id),
                        typedResults: items),
                  if (weeksRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._weeksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0).weeksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.clientId == item.id),
                        typedResults: items),
                  if (daysRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._daysRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0).daysRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.clientId == item.id),
                        typedResults: items),
                  if (workoutPlanExerciseRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ClientsTableReferences
                            ._workoutPlanExerciseRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0)
                                .workoutPlanExerciseRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.clientId == item.id),
                        typedResults: items),
                  if (exerciseSetsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._exerciseSetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0)
                                .exerciseSetsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.clientId == item.id),
                        typedResults: items),
                  if (baseExerciseRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._baseExerciseRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0)
                                .baseExerciseRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.clientId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
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
    (Client, $$ClientsTableReferences),
    Client,
    PrefetchHooks Function(
        {bool workoutPlansRefs,
        bool weeksRefs,
        bool daysRefs,
        bool workoutPlanExerciseRefs,
        bool exerciseSetsRefs,
        bool baseExerciseRefs})>;
typedef $$WorkoutPlansTableCreateCompanionBuilder = WorkoutPlansCompanion
    Function({
  required String uid,
  required String name,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<String?> clientId,
  Value<int> rowid,
});
typedef $$WorkoutPlansTableUpdateCompanionBuilder = WorkoutPlansCompanion
    Function({
  Value<String> uid,
  Value<String> name,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<String?> clientId,
  Value<int> rowid,
});

final class $$WorkoutPlansTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutPlansTable, WorkoutPlan> {
  $$WorkoutPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
          $_aliasNameGenerator(db.workoutPlans.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager? get clientId {
    if ($_item.clientId == null) return null;
    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id($_item.clientId!));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

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

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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
    PrefetchHooks Function({bool clientId, bool weeksRefs})> {
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
            Value<String?> clientId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlansCompanion(
            uid: uid,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            clientId: clientId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String name,
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<String?> clientId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlansCompanion.insert(
            uid: uid,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            clientId: clientId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutPlansTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({clientId = false, weeksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (weeksRefs) db.weeks],
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
                if (clientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientId,
                    referencedTable:
                        $$WorkoutPlansTableReferences._clientIdTable(db),
                    referencedColumn:
                        $$WorkoutPlansTableReferences._clientIdTable(db).id,
                  ) as T;
                }

                return state;
              },
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
    PrefetchHooks Function({bool clientId, bool weeksRefs})>;
typedef $$WeeksTableCreateCompanionBuilder = WeeksCompanion Function({
  required String id,
  required String workoutPlanId,
  Value<String?> clientId,
  required int weekNumber,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$WeeksTableUpdateCompanionBuilder = WeeksCompanion Function({
  Value<String> id,
  Value<String> workoutPlanId,
  Value<String?> clientId,
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

  static $ClientsTable _clientIdTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.weeks.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager? get clientId {
    if ($_item.clientId == null) return null;
    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id($_item.clientId!));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
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

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
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

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
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

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
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
    PrefetchHooks Function(
        {bool workoutPlanId, bool clientId, bool daysRefs})> {
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
            Value<String?> clientId = const Value.absent(),
            Value<int> weekNumber = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeksCompanion(
            id: id,
            workoutPlanId: workoutPlanId,
            clientId: clientId,
            weekNumber: weekNumber,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workoutPlanId,
            Value<String?> clientId = const Value.absent(),
            required int weekNumber,
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeksCompanion.insert(
            id: id,
            workoutPlanId: workoutPlanId,
            clientId: clientId,
            weekNumber: weekNumber,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WeeksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {workoutPlanId = false, clientId = false, daysRefs = false}) {
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
                if (clientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientId,
                    referencedTable: $$WeeksTableReferences._clientIdTable(db),
                    referencedColumn:
                        $$WeeksTableReferences._clientIdTable(db).id,
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
    PrefetchHooks Function({bool workoutPlanId, bool clientId, bool daysRefs})>;
typedef $$DaysTableCreateCompanionBuilder = DaysCompanion Function({
  required String id,
  required String weekId,
  Value<String?> clientId,
  required int dayNumber,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$DaysTableUpdateCompanionBuilder = DaysCompanion Function({
  Value<String> id,
  Value<String> weekId,
  Value<String?> clientId,
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

  static $ClientsTable _clientIdTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.days.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager? get clientId {
    if ($_item.clientId == null) return null;
    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id($_item.clientId!));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
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

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
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

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
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

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
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
    PrefetchHooks Function(
        {bool weekId, bool clientId, bool workoutPlanExerciseRefs})> {
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
            Value<String?> clientId = const Value.absent(),
            Value<int> dayNumber = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DaysCompanion(
            id: id,
            weekId: weekId,
            clientId: clientId,
            dayNumber: dayNumber,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String weekId,
            Value<String?> clientId = const Value.absent(),
            required int dayNumber,
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DaysCompanion.insert(
            id: id,
            weekId: weekId,
            clientId: clientId,
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
              {weekId = false,
              clientId = false,
              workoutPlanExerciseRefs = false}) {
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
                if (clientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientId,
                    referencedTable: $$DaysTableReferences._clientIdTable(db),
                    referencedColumn:
                        $$DaysTableReferences._clientIdTable(db).id,
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
    PrefetchHooks Function(
        {bool weekId, bool clientId, bool workoutPlanExerciseRefs})>;
typedef $$WorkoutPlanExerciseTableCreateCompanionBuilder
    = WorkoutPlanExerciseCompanion Function({
  required String id,
  Value<String?> clientId,
  required String dayId,
  required String code,
  required int exerciseOrder,
  Value<bool> completed,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$WorkoutPlanExerciseTableUpdateCompanionBuilder
    = WorkoutPlanExerciseCompanion Function({
  Value<String> id,
  Value<String?> clientId,
  Value<String> dayId,
  Value<String> code,
  Value<int> exerciseOrder,
  Value<bool> completed,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});

final class $$WorkoutPlanExerciseTableReferences extends BaseReferences<
    _$AppDatabase, $WorkoutPlanExerciseTable, WorkoutPlanExerciseData> {
  $$WorkoutPlanExerciseTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
          $_aliasNameGenerator(db.workoutPlanExercise.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager? get clientId {
    if ($_item.clientId == null) return null;
    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id($_item.clientId!));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

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

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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
        {bool clientId,
        bool dayId,
        bool exerciseSetsRefs,
        bool workoutHistorySetRefs})> {
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
            Value<String?> clientId = const Value.absent(),
            Value<String> dayId = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<int> exerciseOrder = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlanExerciseCompanion(
            id: id,
            clientId: clientId,
            dayId: dayId,
            code: code,
            exerciseOrder: exerciseOrder,
            completed: completed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> clientId = const Value.absent(),
            required String dayId,
            required String code,
            required int exerciseOrder,
            Value<bool> completed = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutPlanExerciseCompanion.insert(
            id: id,
            clientId: clientId,
            dayId: dayId,
            code: code,
            exerciseOrder: exerciseOrder,
            completed: completed,
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
              {clientId = false,
              dayId = false,
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
                if (clientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientId,
                    referencedTable:
                        $$WorkoutPlanExerciseTableReferences._clientIdTable(db),
                    referencedColumn: $$WorkoutPlanExerciseTableReferences
                        ._clientIdTable(db)
                        .id,
                  ) as T;
                }
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
        {bool clientId,
        bool dayId,
        bool exerciseSetsRefs,
        bool workoutHistorySetRefs})>;
typedef $$ExerciseSetsTableCreateCompanionBuilder = ExerciseSetsCompanion
    Function({
  required String id,
  required String exerciseId,
  Value<String?> clientId,
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
  Value<String?> clientId,
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

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
          $_aliasNameGenerator(db.exerciseSets.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager? get clientId {
    if ($_item.clientId == null) return null;
    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id($_item.clientId!));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
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

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
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

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
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

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
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
    PrefetchHooks Function({bool exerciseId, bool clientId})> {
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
            Value<String?> clientId = const Value.absent(),
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
            clientId: clientId,
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
            Value<String?> clientId = const Value.absent(),
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
            clientId: clientId,
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
          prefetchHooksCallback: ({exerciseId = false, clientId = false}) {
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
                if (clientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientId,
                    referencedTable:
                        $$ExerciseSetsTableReferences._clientIdTable(db),
                    referencedColumn:
                        $$ExerciseSetsTableReferences._clientIdTable(db).id,
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
    PrefetchHooks Function({bool exerciseId, bool clientId})>;
typedef $$BaseExerciseTableCreateCompanionBuilder = BaseExerciseCompanion
    Function({
  required String id,
  Value<String?> clientId,
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
  Value<String?> clientId,
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

final class $$BaseExerciseTableReferences extends BaseReferences<_$AppDatabase,
    $BaseExerciseTable, BaseExerciseData> {
  $$BaseExerciseTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
          $_aliasNameGenerator(db.baseExercise.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager? get clientId {
    if ($_item.clientId == null) return null;
    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id($_item.clientId!));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

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

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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
    (BaseExerciseData, $$BaseExerciseTableReferences),
    BaseExerciseData,
    PrefetchHooks Function({bool clientId})> {
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
            Value<String?> clientId = const Value.absent(),
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
            clientId: clientId,
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
            Value<String?> clientId = const Value.absent(),
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
            clientId: clientId,
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
              .map((e) => (
                    e.readTable(table),
                    $$BaseExerciseTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
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
                if (clientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientId,
                    referencedTable:
                        $$BaseExerciseTableReferences._clientIdTable(db),
                    referencedColumn:
                        $$BaseExerciseTableReferences._clientIdTable(db).id,
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

typedef $$BaseExerciseTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BaseExerciseTable,
    BaseExerciseData,
    $$BaseExerciseTableFilterComposer,
    $$BaseExerciseTableOrderingComposer,
    $$BaseExerciseTableAnnotationComposer,
    $$BaseExerciseTableCreateCompanionBuilder,
    $$BaseExerciseTableUpdateCompanionBuilder,
    (BaseExerciseData, $$BaseExerciseTableReferences),
    BaseExerciseData,
    PrefetchHooks Function({bool clientId})>;
typedef $$ClientWeightTableCreateCompanionBuilder = ClientWeightCompanion
    Function({
  Value<String?> clientId,
  required int timeStamp,
  required double weightInKg,
  required double weightInLb,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$ClientWeightTableUpdateCompanionBuilder = ClientWeightCompanion
    Function({
  Value<String?> clientId,
  Value<int> timeStamp,
  Value<double> weightInKg,
  Value<double> weightInLb,
  Value<int> createdAt,
  Value<int?> updatedAt,
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

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
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
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientWeightCompanion(
            clientId: clientId,
            timeStamp: timeStamp,
            weightInKg: weightInKg,
            weightInLb: weightInLb,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> clientId = const Value.absent(),
            required int timeStamp,
            required double weightInKg,
            required double weightInLb,
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientWeightCompanion.insert(
            clientId: clientId,
            timeStamp: timeStamp,
            weightInKg: weightInKg,
            weightInLb: weightInLb,
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
  required String id,
  required String clientId,
  required String exerciseId,
  Value<int?> actualReps,
  Value<double?> actualWeight,
  Value<double?> actualDistance,
  Value<int?> actualTime,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$WorkoutHistorySetTableUpdateCompanionBuilder
    = WorkoutHistorySetCompanion Function({
  Value<String> id,
  Value<String> clientId,
  Value<String> exerciseId,
  Value<int?> actualReps,
  Value<double?> actualWeight,
  Value<double?> actualDistance,
  Value<int?> actualTime,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
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
  ColumnOrderings<String> get id => $composableBuilder(
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
  GeneratedColumn<String> get id =>
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
            Value<String> id = const Value.absent(),
            Value<String> clientId = const Value.absent(),
            Value<String> exerciseId = const Value.absent(),
            Value<int?> actualReps = const Value.absent(),
            Value<double?> actualWeight = const Value.absent(),
            Value<double?> actualDistance = const Value.absent(),
            Value<int?> actualTime = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
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
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String clientId,
            required String exerciseId,
            Value<int?> actualReps = const Value.absent(),
            Value<double?> actualWeight = const Value.absent(),
            Value<double?> actualDistance = const Value.absent(),
            Value<int?> actualTime = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
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
            rowid: rowid,
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
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
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
  $$ClientWeightTableTableManager get clientWeight =>
      $$ClientWeightTableTableManager(_db, _db.clientWeight);
  $$WorkoutHistorySetTableTableManager get workoutHistorySet =>
      $$WorkoutHistorySetTableTableManager(_db, _db.workoutHistorySet);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
}
