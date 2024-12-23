// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class ClientWeightEntity extends Equatable {
  final String? clientId;
  final int timeStamp;
  final double weightInKg;
  final double weightInLb;

  const ClientWeightEntity({
    this.clientId,
    required this.timeStamp,
    required this.weightInKg,
    required this.weightInLb,
  });

  @override
  List<Object?> get props => [timeStamp, weightInKg, weightInLb, clientId];
}
