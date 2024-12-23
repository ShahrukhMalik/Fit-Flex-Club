part of 'getclientweights_cubit.dart';

abstract class GetclientweightsState extends Equatable {
  const GetclientweightsState();

  @override
  List<Object> get props => [];
}

class GetclientweightsInitial extends GetclientweightsState {}

class GetclientweightsLoading extends GetclientweightsState {}

class GetclientweightsComplete extends GetclientweightsState {
  final List<ClientWeightEntity> weights;

  const GetclientweightsComplete({required this.weights});
}

class GetclientweightsError extends GetclientweightsState {
  final Failures failures;

 const  GetclientweightsError({required this.failures});
}
