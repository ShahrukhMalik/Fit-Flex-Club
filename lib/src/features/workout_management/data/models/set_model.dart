import 'package:fit_flex_club/src/features/workout_management/domain/entities/set_entity.dart';

class SetModel extends SetEntity {
  const SetModel({
    super.targetReps,
    super.targetWeight,
    super.targetDistance,
    super.targetTime,
    super.actualReps,
    super.actualWeight,
    super.actualDistance,
    super.actualTime,
  });

  // Convert a Map to a Set instance
  factory SetModel.fromMap(Map<String, dynamic> map) {
    return SetModel(
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
          ? Duration(seconds: map['actualTime'] as int)
          : null,
    );
  }

  // Convert a SetModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      if (targetReps != null) 'targetReps': targetReps,
      if (targetWeight != null) 'targetWeight': targetWeight,
      if (targetDistance != null) 'targetDistance': targetDistance,
      if (targetTime != null) 'targetTime': targetTime?.inSeconds,
      if (actualReps != null) 'actualReps': actualReps,
      if (actualWeight != null) 'actualWeight': actualWeight,
      if (actualDistance != null) 'actualDistance': actualDistance,
      if (actualTime != null) 'actualTime': actualTime?.inSeconds,
    };
  }
}
