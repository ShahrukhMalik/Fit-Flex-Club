// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final int? age;
  final String? gender;
  final int? heightInCm;
  final int? heightInFt;
  final int? heightInFtInches;
  final bool? isTrainer;
  final bool? isUserActive;
  final String? username;
  final int? weightInKg;
  final int? weightInLb;

  const ClientEntity({
    required this.age,
    required this.gender,
    required this.heightInCm,
    required this.heightInFt,
    required this.heightInFtInches,
    required this.isTrainer,
    required this.isUserActive,
    required this.username,
    required this.weightInKg,
    required this.weightInLb,
  });
  @override
  List<Object?> get props {
    return [
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
}
