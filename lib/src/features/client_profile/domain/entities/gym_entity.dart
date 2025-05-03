import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/trainer_entity.dart';

class Gym extends Equatable {
  final String gymId;
  final String gymName;
  final List<Trainer> trainers;

  const Gym({
    required this.gymId,
    required this.gymName,
    required this.trainers,
  });

  @override
  List<Object?> get props => [gymId, gymName, trainers];
}
