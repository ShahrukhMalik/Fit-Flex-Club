import 'package:fit_flex_club/src/features/client_profile/domain/entities/trainer_entity.dart';

class TrainerModel extends Trainer {
  const TrainerModel({
    required super.trainerName,
    required super.trainerId,
    required super.email,
    required super.trainerImageUrl,
  });

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      trainerName: json['username'] ?? '',
      trainerId: json['uid'] ?? '',
      email: json['email'] ?? '',
      trainerImageUrl: json['trainerImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': trainerName,
      'uid': trainerId,
      'email': email,
      'trainerImageUrl': trainerImageUrl,
    };
  }

  factory TrainerModel.fromEntity(Trainer trainer) {
    return TrainerModel(
      trainerName: trainer.trainerName,
      trainerId: trainer.trainerId,
      email: trainer.email,
      trainerImageUrl: trainer.trainerImageUrl,
    );
  }

  Trainer toEntity() => Trainer(
        trainerName: trainerName,
        trainerId: trainerId,
        email: email,
        trainerImageUrl: trainerImageUrl,
      );

  TrainerModel copyWith({
    String? trainerName,
    String? trainerId,
    String? email,
    String? trainerImageUrl,
  }) {
    return TrainerModel(
      trainerName: trainerName ?? this.trainerName,
      trainerId: trainerId ?? this.trainerId,
      email: email ?? this.email,
      trainerImageUrl: trainerImageUrl ?? this.trainerImageUrl,
    );
  }
}
