import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
    super.id,
    super.age,
    super.gender,
    super.weightInKg,
    super.weightInLb,
    super.heightInCm,
    super.heightInFt,
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
      weightInKg,
      weightInLb,
      heightInCm,
      heightInFt,
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
    double? weightInKg,
    double? weightInLb,
    double? heightInCm,
    double? heightInFt,
    bool? isTrainer,
    bool? isUserActive,
    String? username,
    String? email,
    String? currentWorkoutPlanName,
    Map<String, dynamic>? phone,
  }) {
    return ClientModel(
      currentWorkoutPlanName:
          currentWorkoutPlanName ?? this.currentWorkoutPlanName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      id: id ?? this.id,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weightInKg: weightInKg ?? this.weightInKg,
      weightInLb: weightInLb ?? this.weightInLb,
      heightInCm: heightInCm ?? this.heightInCm,
      heightInFt: heightInFt ?? this.heightInFt,
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
      'weightInKg': weightInKg,
      'weightInLb': weightInLb,
      'heightInCm': heightInCm,
      'heightInFt': heightInFt,
      'isTrainer': isTrainer,
      'isUserActive': isUserActive,
      'username': username,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      currentWorkoutPlanName: map['currentWorkoutPlanName'],
      phone: {
        'countryCode': map['countryCode'],
        'phoneNumber': map['phoneNumber'],
      },
      email: map['email'],
      id: map['id'],
      age: map['age'],
      gender: map['gender'],
      weightInKg: map['weightInKg'],
      weightInLb: map['weightInLb'],
      heightInCm: map['heightInCm'],
      heightInFt: map['heightInFt'],
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
      weightInKg: (data?['weightInKg']).toDouble(),
      weightInLb: (data?['weightInLb']).toDouble(),
      heightInCm: data?['heightInCm'].toDouble(),
      heightInFt: data?['heightInFt'].toDouble(),
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
      weightInKg: clientEntity.weightInKg,
      weightInLb: clientEntity.weightInLb,
      heightInCm: clientEntity.heightInCm,
      heightInFt: clientEntity.heightInFt,
      isTrainer: clientEntity.isTrainer,
      isUserActive: clientEntity.isUserActive,
      username: clientEntity.username,
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{};

    if (id != null) data['id'] = id;
    if (currentWorkoutPlanName != null) {
      data['currentWorkoutPlanName'] = currentWorkoutPlanName;
    }
    if (age != null) data['age'] = age;
    if (gender != null) data['gender'] = gender;
    if (weightInKg != null) {
      data['weightInKg'] =
          double.tryParse(weightInKg?.toStringAsFixed(2) ?? "0");
    }
    if (weightInLb != null) {
      data['weightInLb'] =
          double.tryParse(weightInLb?.toStringAsFixed(2) ?? "0");
    }

    if (heightInCm != null) {
      data['heightInCm'] =
          double.tryParse(heightInCm?.toStringAsFixed(2) ?? "0");
    }

    if (heightInFt != null) {
      data['heightInFt'] =
          double.tryParse(heightInFt?.toStringAsFixed(2) ?? "0");
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
double convertLbToKgDouble(double? lb) => lb != null ? (lb / 2.205) : 0;
double convertKgToLbDouble(double? kg) => kg != null ? (kg * 2.205) : 0;
int convertFtToCm(int? ft) => ft != null ? (ft * 30.48).floor() : 0;
int convertCmToFt(int? cm) => cm != null ? (cm / 30.48).floor() : 0;
double convertFtToCmD(double? ft) => ft != null ? (ft * 30.48) : 0;
double convertCmToFtD(double? cm) => cm != null ? (cm / 30.48) : 0;
