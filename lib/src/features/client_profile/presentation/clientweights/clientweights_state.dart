part of 'clientweights_cubit.dart';

abstract class ClientweightsState extends Equatable {
  const ClientweightsState();

  @override
  List<Object> get props => [];
}

class ClientweightsInitial extends ClientweightsState {}

class ClientweightsLoading extends ClientweightsState {}

class ClientweightsComplete extends ClientweightsState {}

class ClientweightsError extends ClientweightsState {
  final Failures failures;
  const ClientweightsError({required this.failures});
}
