// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String? id;
  final String? email;
  final Map<String, dynamic>? phone;
  final int? age;
  final String? gender;
  final int? heightInFt;
  final int? heightInCm;
  final bool? isTrainer;
  final bool? isUserActive;
  final String? username;
  final int? weightInKg;
  final int? weightInLb;
  final String? currentWorkoutPlanName;

  const ClientEntity({
    this.phone,
    this.email,
     this.id,
    this.age,
    this.gender,
    this.heightInFt,
    this.heightInCm,
    this.isTrainer,
    this.isUserActive,
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
      currentWorkoutPlanName
    ];
  }
}
