part of 'getgyms_cubit.dart';

abstract class GetGymsState extends Equatable {
  const GetGymsState();

  @override
  List<Object> get props => [];
}

class GetGymsInitial extends GetGymsState {}

class GetGymsLoading extends GetGymsState {
  final DateTime timestamp = DateTime.now(); // or use a uuid

  @override
  List<Object> get props => [timestamp];
}

class GetGymsError extends GetGymsState {
  final Failures failure;

  const GetGymsError({required this.failure});
}

class GetGymsComplete extends GetGymsState {
  final List<Gym> gyms;

  const GetGymsComplete({required this.gyms});
}
