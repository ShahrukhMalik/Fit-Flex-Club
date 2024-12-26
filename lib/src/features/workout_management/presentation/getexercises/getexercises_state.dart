part of 'getexercises_cubit.dart';

abstract class GetexercisesState extends Equatable {
  const GetexercisesState();

  @override
  List<Object> get props => [];
}

class GetexercisesInitial extends GetexercisesState {}

class GetexercisesLoading extends GetexercisesState {}

class GetexercisesError extends GetexercisesState {
  final Failures failures;
  const GetexercisesError({required this.failures});
}

class GetExercisesComplete extends GetexercisesState {
  final List<ExerciseEntity> exercises;
  const GetExercisesComplete({required this.exercises});
}
