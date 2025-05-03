import 'package:equatable/equatable.dart';

class Trainer extends Equatable {
  final String trainerName;
  final String trainerId;
  final String email;
  final String trainerImageUrl;

  const Trainer({
    required this.trainerName,
    required this.trainerImageUrl,
    required this.trainerId,
    required this.email,
  });

  @override
  List<Object?> get props => [
        trainerName,
        trainerImageUrl,
        trainerId,
        email,
      ];
}
