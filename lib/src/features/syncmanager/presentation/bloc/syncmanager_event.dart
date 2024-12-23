part of 'syncmanager_bloc.dart';

abstract class SyncmanagerEvent extends Equatable {
  const SyncmanagerEvent();

  @override
  List<Object> get props => [];
}

class CheckConnectivityEvent extends SyncmanagerEvent {}

class SyncDataEvent extends SyncmanagerEvent {}

