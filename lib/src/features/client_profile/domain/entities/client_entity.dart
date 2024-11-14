// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String? authId;
  final String? email;
  final Map<String, dynamic>? phone;
  final int? age;
  final String? gender;
  final int? height;
  final String? heightUnit;
  final bool? isTrainer;
  final bool? isUserActive;
  final String? username;
  final int? weight;
  final String? weightUnit;

  const ClientEntity({
    this.phone,
    this.email,
    this.authId,
    this.age,
    this.gender,
    this.height,
    this.heightUnit,
    this.isTrainer,
    this.isUserActive,
    this.username,
    this.weight,
    this.weightUnit,
  });
  @override
  List<Object?> get props {
    return [
      phone,
      authId,
      age,
      gender,
      height,
      heightUnit,
      isTrainer,
      isUserActive,
      username,
      weight,
      weightUnit,
      email,
    ];
  }
}
