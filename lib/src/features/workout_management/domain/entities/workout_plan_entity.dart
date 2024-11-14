import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';

class WorkoutPlan extends Equatable {
  final String name;
  final String uid;
  final List<Week> weeks;

  const WorkoutPlan({
    required this.name,
    required this.weeks,
    required this.uid,
  });

  @override
  List<Object?> get props => [name, weeks];
}

class Week extends Equatable {
  final int weekNumber;
  final List<Day> days;

  const Week({
    required this.weekNumber,
    required this.days,
  });

  @override
  List<Object?> get props => [weekNumber, days];
}

class Day extends Equatable {
  final int dayNumber;
  final List<Exercise> exercises;

  const Day({
    required this.dayNumber,
    required this.exercises,
  });

  @override
  List<Object?> get props => [dayNumber, exercises];
}

class Exercise extends ExerciseEntity {
  final List<Set> sets;
  const Exercise(
    this.sets, {
    required super.code,
    super.equipment,
    super.muscleGroup,
    required super.name,
    super.parameters,
  });

  @override
  List<Object?> get props => [
        name,
        muscleGroup,
        sets,
        parameters,
        code,
        equipment,
      ];
}

class Set extends Equatable {
  final int? reps;
  final double? weight;
  final double? distance;
  final Duration? time;

  const Set({
    this.reps,
    this.weight,
    this.distance,
    this.time,
  });

  @override
  List<Object?> get props => [reps, weight, distance, time];
}
