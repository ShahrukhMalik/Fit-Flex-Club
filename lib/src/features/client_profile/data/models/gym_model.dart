import 'package:fit_flex_club/src/features/client_profile/data/models/trainer_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/gym_entity.dart';

class GymModel extends Gym {
  const GymModel({
    required super.gymId,
    required super.gymName,
    required super.trainers,
  });

  factory GymModel.fromJson(Map<String, dynamic> json, String gymId) {
    return GymModel(
      gymId: gymId,
      gymName: json['name'] as String,
      trainers: (json['trainers'] as List<dynamic>? ?? [])
          .map((trainerJson) => TrainerModel.fromJson(trainerJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': gymName,
      'trainers': trainers
          .map((trainer) =>
              trainer is TrainerModel ? trainer.toJson() : {}) // fallback
          .toList(),
    };
  }

  factory GymModel.fromEntity(Gym gym) {
    return GymModel(
      gymId: gym.gymId,
      gymName: gym.gymName,
      trainers: gym.trainers
          .map((trainer) => trainer is TrainerModel
              ? trainer
              : TrainerModel.fromEntity(trainer))
          .toList(),
    );
  }

  Gym toEntity() => Gym(
        gymId: gymId,
        gymName: gymName,
        trainers: trainers,
      );

  GymModel copyWith({
    String? gymId,
    String? gymName,
    List<TrainerModel>? trainers,
  }) {
    return GymModel(
      gymId: gymId ?? this.gymId,
      gymName: gymName ?? this.gymName,
      trainers: trainers ?? this.trainers,
    );
  }
}
