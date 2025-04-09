part of 'broadcast_cubit.dart';

abstract class BroadcastState extends Equatable {
  const BroadcastState();

  @override
  List<Object> get props => [];
}

class BroadcastInitial extends BroadcastState {}
