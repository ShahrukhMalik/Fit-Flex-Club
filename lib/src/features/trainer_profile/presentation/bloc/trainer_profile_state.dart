part of 'trainer_profile_bloc.dart';

abstract class TrainerProfileState extends Equatable {
  const TrainerProfileState();

  @override
  List<Object> get props => [];
}

class TrainerProfileInitial extends TrainerProfileState {}

class TrainerProfileLoading extends TrainerProfileState {}

class TrainerProfileComplete extends TrainerProfileState {
  final List<ClientEntity> entities;

  const TrainerProfileComplete({required this.entities});

  @override
  List<Object> get props => [entities];
}

class TrainerProfileError extends TrainerProfileState {
  final Failures failures;

  const TrainerProfileError({required this.failures});

  @override
  List<Object> get props => [failures];
}
