import 'package:equatable/equatable.dart';

class ClientWeightEntity extends Equatable {
  final DateTime date;
  final double weight;

  const ClientWeightEntity({required this.date, required this.weight});

  @override
  List<Object?> get props => [date, weight];
}
