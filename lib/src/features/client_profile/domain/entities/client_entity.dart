// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String? authId;
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
     this.authId,
     this.age,
     this.gender,
     this.heightInCm,
     this.heightInFt,
     this.heightInFtInches,
     this.isTrainer,
     this.isUserActive,
     this.username,
     this.weightInKg,
     this.weightInLb,
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
}
