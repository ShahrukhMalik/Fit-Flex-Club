part of 'getworkoutplan_cubit.dart';

abstract class GetworkoutplanState extends Equatable {
  const GetworkoutplanState();

  @override
  List<Object> get props => [];
}

class GetworkoutplanInitial extends GetworkoutplanState {}

class GetworkoutplanLoading extends GetworkoutplanState {}

class GetworkoutplanComplete extends GetworkoutplanState {
  final WorkoutPlanModel? workoutPlan;
  const GetworkoutplanComplete({required this.workoutPlan});
}

class GetworkoutplanError extends GetworkoutplanState {
  final Failures failures;
  const GetworkoutplanError({required this.failures});
}
