import 'package:fit_flex_club/src/features/workout_management/domain/entities/set_entity.dart';

class SetModel extends SetEntity {
  final String? clientId;
  const SetModel({
    super.targetReps,
    super.targetWeight,
    super.targetDistance,
    super.targetTime,
    super.actualReps,
    super.actualWeight,
    super.actualDistance,
    super.actualTime,
    required super.id,
    required super.exerciseId,
    this.clientId,
  });

  // Convert a Map to a Set instance
  factory SetModel.fromMap(Map<String, dynamic> map) {
    return SetModel(
      exerciseId: map['exerciseId'],
      id: map['id'],
      clientId: map['clientId'],
      targetReps: map['targetReps'] as int?,
      targetWeight: (map['targetWeight'] as num?)?.toDouble(),
      targetDistance: (map['targetDistance'] as num?)?.toDouble(),
      targetTime: map['targetTime'] != null
          ? Duration(seconds: map['targetTime'] as int)
          : null,
      actualReps: map['actualReps'] as int?,
      actualWeight: (map['actualWeight'] as num?)?.toDouble(),
      actualDistance: (map['actualDistance'] as num?)?.toDouble(),
      actualTime: map['actualTime'] != null
          ? Duration(minutes: map['actualTime'] as int)
          : null,
    );
  }

  // Convert a SetModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'exerciseId': exerciseId,
      if (targetReps != null) 'targetReps': targetReps,
      if (targetWeight != null) 'targetWeight': targetWeight,
      if (targetDistance != null) 'targetDistance': targetDistance,
      if (targetTime != null) 'targetTime': targetTime?.inSeconds,
      if (actualReps != null) 'actualReps': actualReps,
      if (actualWeight != null) 'actualWeight': actualWeight,
      if (actualDistance != null) 'actualDistance': actualDistance,
      if (actualTime != null) 'actualTime': actualTime?.inMinutes,
    };
  }

  // CopyWith method
  SetModel copyWith({
    int? targetReps,
    double? targetWeight,
    double? targetDistance,
    Duration? targetTime,
    int? actualReps,
    double? actualWeight,
    double? actualDistance,
    Duration? actualTime,
    String? id,
    String? clientId,
    String? exeriseId,
  }) {
    return SetModel(
      clientId: clientId ?? this.clientId,
      exerciseId: exerciseId,
      targetReps: targetReps ?? this.targetReps,
      targetWeight: targetWeight ?? this.targetWeight,
      targetDistance: targetDistance ?? this.targetDistance,
      targetTime: targetTime ?? this.targetTime,
      actualReps: actualReps ?? this.actualReps,
      actualWeight: actualWeight ?? this.actualWeight,
      actualDistance: actualDistance ?? this.actualDistance,
      actualTime: actualTime ?? this.actualTime,
      id: id ?? this.id,
    );
  }
}
