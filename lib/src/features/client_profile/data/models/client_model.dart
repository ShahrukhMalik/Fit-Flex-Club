import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
     super.id,
     super.age,
     super.gender,
     super.weight,
     super.weightUnit,
     super.height,
     super.heightUnit,
     super.isTrainer,
     super.isUserActive,
     super.username,
     super.email,
     super.phone,
     super.currentWorkoutPlanName,
  });
  @override
  List<Object?> get props {
    return [
      id,
      age,
      gender,
      weight,
      weightUnit,
      height,
      heightUnit,
      isTrainer,
      isUserActive,
      username,
      phone,
      currentWorkoutPlanName
    ];
  }

  ClientModel copyWith({
    String? id,
    int? age,
    String? gender,
    int? weight,
    String? weightUnit,
    int? height,
    String? heightUnit,
    bool? isTrainer,
    bool? isUserActive,
    String? username,
    String? email,
    String? currentWorkoutPlanName,
    Map<String, dynamic>? phone,
  }) {
    return ClientModel(
      currentWorkoutPlanName: currentWorkoutPlanName ?? this.currentWorkoutPlanName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      id: id ?? this.id,
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
      'id': id,
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
      currentWorkoutPlanName: map['currentWorkoutPlanName'],
      phone: {
        'countryCode': map['phoneCountryCode'],
        'phone': map['phone'],
      },
      email: map['email'],
      id: map['id'],
      age: map['age'],
      gender: map['gender'],
      weight: map['weight'],
      weightUnit: map['weightUnit'],
      height: map['height'],
      heightUnit: map['heightUnit'],
      isTrainer: map['isTrainer'],
      isUserActive: map['isUserActive'],
      username: map['username'],
    );
  }

  factory ClientModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ClientModel(
      currentWorkoutPlanName: data?['currentWorkoutPlanName'],
      phone: data?['phone'],
      email: data?['email'],
      id: snapshot.id,
      age: data?['age'],
      gender: data?['gender'],
      weight: data?['weight'],
      weightUnit: data?['weightUnit'],
      height: data?['height'],
      heightUnit: data?['heightUnit'],
      isTrainer: data?['isTrainer'],
      isUserActive: data?['isUserActive'],
      username: data?['username'],
    );
  }

  factory ClientModel.fromClientEntity(ClientEntity clientEntity) {
    return ClientModel(
      currentWorkoutPlanName: clientEntity.currentWorkoutPlanName,
      phone: clientEntity.phone,
      email: clientEntity.email,
      id: clientEntity.id,
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

    if (id != null) data['id'] = id;
    if (currentWorkoutPlanName != null) data['currentWorkoutPlanName'] = currentWorkoutPlanName;
    if (age != null) data['age'] = age;
    if (gender != null) data['gender'] = gender;
    if (weightUnit != null && weightUnit == 'kg') data['weightInKg'] = weight;
    if (weightUnit != null && weightUnit == 'lb') data['weightInLb'] = weight;
    if (weightUnit != null) {
      if (weightUnit == 'kg') {
        data['weightInLb'] = convertKgToLb(weight!);
      }
      if (weightUnit == 'lb') {
        data['weightInKg'] = convertLbToKg(weight!);
      }
    }
    if (heightUnit != null && heightUnit == 'cm') data['heightInCm'] = height;
    if (heightUnit != null && heightUnit == 'ft') data['heightInFt'] = height;
    if (heightUnit != null) {
      if (heightUnit == 'cm') {
        data['heightInFt'] = convertCmToFt(height!);
      }
      if (heightUnit == 'ft') {
        data['heightInCm'] = convertFtToCm(height!);
      }
    }
    if (isTrainer != null) data['isTrainer'] = isTrainer;
    if (isUserActive != null) data['isUserActive'] = isUserActive;
    if (username != null) data['username'] = username;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;

    return data;
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// Helper conversion methods
int convertKgToLb(int? kg) => kg != null ? (kg * 2.205).floor() : 0;
int convertLbToKg(int? lb) => lb != null ? (lb / 2.205).floor() : 0;
int convertFtToCm(int? ft) => ft != null ? (ft * 30.48).floor() : 0;
int convertCmToFt(int? cm) => cm != null ? (cm / 30.48).floor() : 0;
