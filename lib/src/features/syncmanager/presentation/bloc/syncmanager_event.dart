part of 'syncmanager_bloc.dart';

abstract class SyncmanagerEvent extends Equatable {
  const SyncmanagerEvent();

  @override
  List<Object> get props => [];
}

class CheckConnectivityEvent extends SyncmanagerEvent {}

class SyncOfflineDataEvent extends SyncmanagerEvent {}

class SyncOnlineDataEvent extends SyncmanagerEvent {}

class MarkEventListened extends SyncmanagerEvent {
  final String docId;

  const MarkEventListened({required this.docId});

}
