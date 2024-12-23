part of 'syncmanager_bloc.dart';

abstract class SyncmanagerState extends Equatable {
  const SyncmanagerState();  

  @override
  List<Object> get props => [];
}
class SyncmanagerInitial extends SyncmanagerState {}
