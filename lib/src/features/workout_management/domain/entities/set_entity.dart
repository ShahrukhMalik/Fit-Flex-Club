import 'package:equatable/equatable.dart';

class SetEntity extends Equatable {
  // Target fields
  final int? targetReps;
  final double? targetWeight;
  final double? targetDistance;
  final Duration? targetTime;

  // Actual fields
  final int? actualReps;
  final double? actualWeight;
  final double? actualDistance;
  final Duration? actualTime;

  const SetEntity({
    this.targetReps,
    this.targetWeight,
    this.targetDistance,
    this.targetTime,
    this.actualReps,
    this.actualWeight,
    this.actualDistance,
    this.actualTime,
  });

  @override
  List<Object?> get props => [
        targetReps,
        targetWeight,
        targetDistance,
        targetTime,
        actualReps,
        actualWeight,
        actualDistance,
        actualTime,
      ];

  // A helper method to calculate progress for each field (if applicable)
  double? calculateProgress(
      {required double? target, required double? actual}) {
    if (target == null || actual == null || target == 0) {
      return null;
    }
    return (actual / target) * 100;
  }

  // Progress getters for each field
  double? get repsProgress => calculateProgress(
      target: targetReps?.toDouble(), actual: actualReps?.toDouble());
  double? get weightProgress =>
      calculateProgress(target: targetWeight, actual: actualWeight);
  double? get distanceProgress =>
      calculateProgress(target: targetDistance, actual: actualDistance);
  double? get timeProgress => calculateProgress(
      target: targetTime?.inSeconds.toDouble(),
      actual: actualTime?.inSeconds.toDouble());
}
