import 'dart:convert';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
    required super.authId,
    required super.age,
    required super.gender,
    required super.heightInCm,
    required super.heightInFt,
    required super.heightInFtInches,
    required super.isTrainer,
    required super.isUserActive,
    required super.username,
    required super.weightInKg,
    required super.weightInLb,
  });
  @override
  List<Object?> get props {
    return [
      authId,
      age,
      gender,
      heightInCm,
      heightInFt,
      heightInFtInches,
      isTrainer,
      isUserActive,
      username,
      weightInKg,
      weightInLb,
    ];
  }

  ClientModel copyWith({
    int? age,
    String? email,
    String? gender,
    int? heightInCm,
    int? heightInFt,
    int? heightInFtInches,
    bool? isTrainer,
    bool? isUserActive,
    String? username,
    int? weightInKg,
    int? weightInLb,
    String? authId,
  }) {
    return ClientModel(
      authId: authId ?? this.authId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      heightInCm: heightInCm ?? this.heightInCm,
      heightInFt: heightInFt ?? this.heightInFt,
      heightInFtInches: heightInFtInches ?? this.heightInFtInches,
      isTrainer: isTrainer ?? this.isTrainer,
      isUserActive: isUserActive ?? this.isUserActive,
      username: username ?? this.username,
      weightInKg: weightInKg ?? this.weightInKg,
      weightInLb: weightInLb ?? this.weightInLb,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authId': authId,
      'age': age,
      'gender': gender,
      'heightInCm': heightInCm,
      'heightInFt': heightInFt,
      'heightInFtInches': heightInFtInches,
      'isTrainer': isTrainer,
      'isUserActive': isUserActive,
      'username': username,
      'weightInKg': weightInKg,
      'weightInLb': weightInLb,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      authId: map["authId"],
      age: map['age'] as int,
      gender: map['gender'] as String,
      heightInCm: map['heightInCm'] as int,
      heightInFt: map['heightInFt'] as int,
      heightInFtInches: map['heightInFtInches'] as int,
      isTrainer: map['isTrainer'] as bool,
      isUserActive: map['isUserActive'] as bool,
      username: map['username'] as String,
      weightInKg: map['weightInKg'] as int,
      weightInLb: map['weightInLb'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
