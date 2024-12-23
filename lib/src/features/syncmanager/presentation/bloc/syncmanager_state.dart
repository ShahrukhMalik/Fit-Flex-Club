part of 'syncmanager_bloc.dart';

abstract class SyncmanagerState extends Equatable {
  const SyncmanagerState();
}

class SyncmanagerInitial extends SyncmanagerState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SyncmanagerLoading extends SyncmanagerState {
  final bool? isCheckingConnectivity;
  final bool? syncingData;

  const SyncmanagerLoading(
      {required this.isCheckingConnectivity, required this.syncingData});

  @override
  List<Object?> get props => [isCheckingConnectivity, syncingData];
}

class SyncmanagerComplete extends SyncmanagerState {
  final bool? isOnline;
  final bool? isDataSynced;

  const SyncmanagerComplete({
    required this.isOnline,
    required this.isDataSynced,
  });
  @override
  List<Object?> get props => [isOnline,isDataSynced];
}

class SyncmanagerError extends SyncmanagerState {
  final Failures failures;

  const SyncmanagerError({required this.failures});
  
  @override
  List<Object?> get props => [failures];
}
