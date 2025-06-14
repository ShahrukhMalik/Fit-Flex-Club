// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String? id;
  final String? email;
  final Map<String, dynamic>? phone;
  final int? age;
  final String? fcmToken;
  final String? trainerImageUrl;
  final String? gender;
  final double? heightInFt;
  final double? heightInCm;
  final bool? isTrainer;
  final bool? isUserActive;
  final String? username;
  final double? weightInKg;
  final double? weightInLb;
  final String? currentWorkoutPlanName;

  const ClientEntity({
    this.id,
    this.email,
    this.phone,
    this.age,
    this.fcmToken,
    this.gender,
    this.heightInFt,
    this.heightInCm,
    this.isTrainer,
    this.isUserActive,
    this.trainerImageUrl,
    this.username,
    this.weightInKg,
    this.weightInLb,
    this.currentWorkoutPlanName,
  });
  @override
  List<Object?> get props {
    return [
      phone,
      id,
      age,
      gender,
      heightInFt,
      heightInCm,
      isTrainer,
      isUserActive,
      username,
      weightInKg,
      weightInLb,
      email,
      currentWorkoutPlanName,
      fcmToken,
      trainerImageUrl
    ];
  }
}
