import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
    required super.authId,
    required super.age,
    required super.gender,
    required super.weight,
    required super.weightUnit,
    required super.height,
    required super.heightUnit,
    required super.isTrainer,
    required super.isUserActive,
    required super.username,
  });
  @override
  List<Object?> get props {
    return [
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
    ];
  }

  ClientModel copyWith({
    String? authId,
    int? age,
    String? gender,
    int? weight,
    String? weightUnit,
    int? height,
    String? heightUnit,
    bool? isTrainer,
    bool? isUserActive,
    String? username,
  }) {
    return ClientModel(
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authId': authId,
      'age': age,
      'gender': gender,
      'weight': weight,
      'weightUnit': weightUnit,
      'height': height,
      'heightUnit': heightUnit,
      'isTrainer': isTrainer,
      'isUserActive': isUserActive,
      'username': username,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      authId: map['authId'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      weight: map['weight'] as int,
      weightUnit: map['weightUnit'] as String,
      height: map['height'] as int,
      heightUnit: map['heightUnit'] as String,
      isTrainer: map['isTrainer'] as bool,
      isUserActive: map['isUserActive'] as bool,
      username: map['username'] as String,
    );
  }

  factory ClientModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ClientModel(
      authId: data?['authId'],
      age: data?['age'] as int,
      gender: data?['gender'] as String,
      weight: data?['weight'] as int,
      weightUnit: data?['weightUnit'] as String,
      height: data?['height'] as int,
      heightUnit: data?['heightUnit'] as String,
      isTrainer: data?['isTrainer'] as bool,
      isUserActive: data?['isUserActive'] as bool,
      username: data?['username'] as String,
    );
  }

  factory ClientModel.fromClientEntity(ClientEntity clientEntity) {
    return ClientModel(
      authId: clientEntity.authId,
      age: clientEntity.age,
      gender: clientEntity.gender,
      weight: clientEntity.weight,
      weightUnit: clientEntity.weightUnit,
      height: clientEntity.height,
      heightUnit: clientEntity.heightUnit,
      isTrainer: clientEntity.isTrainer,
      isUserActive: clientEntity.isUserActive,
      username: clientEntity.username,
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{};

    if (authId != null) data['authId'] = authId;
    if (age != null) data['age'] = age;
    if (gender != null) data['gender'] = gender;
    if (weightUnit != null && weightUnit == 'kg') data['weightInKg'] = weight;
    if (weightUnit != null && weightUnit == 'lb') data['weightInLb'] = weight;
    if (weightUnit != null) {
      if (weightUnit == 'kg') {
        data['weightInLb'] = _convertKgToLb(weight!);
      }
      if (weightUnit == 'lb') {
        data['weightInKg'] = _convertLbToKg(weight!);
      }
    }
    if (heightUnit != null && heightUnit == 'cm') data['heightInCm'] = height;
    if (heightUnit != null && heightUnit == 'ft') data['heightInFt'] = height;
    if (heightUnit != null) {
      if (heightUnit == 'cm') {
        data['heightInFt'] = _convertCmToFt(height!);
      }
      if (heightUnit == 'ft') {
        data['heightInCm'] = _convertFtToCm(height!);
      }
    }
    if (isTrainer != null) data['isTrainer'] = isTrainer;
    if (isUserActive != null) data['isUserActive'] = isUserActive;
    if (username != null) data['username'] = username;

    return data;
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// Helper conversion methods
 int _convertKgToLb(int? kg) => kg != null ? (kg * 2.205).round() : 0;
 int _convertLbToKg(int? lb) => lb != null ? (lb / 2.205).round() : 0;
 int _convertFtToCm(int? ft) => ft != null ? (ft * 30.48).round() : 0;
 int _convertCmToFt(int? cm) => cm != null ? (cm / 30.48).round() : 0;
