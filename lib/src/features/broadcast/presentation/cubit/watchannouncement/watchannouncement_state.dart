part of 'watchannouncement_cubit.dart';

abstract class WatchAnnouncementState extends Equatable {
  const WatchAnnouncementState();

  @override
  List<Object> get props => [];
}

class WatchAnnouncementInitial extends WatchAnnouncementState {}

class WatchAnnouncementLoading extends WatchAnnouncementState {}

class WatchAnnouncementError extends WatchAnnouncementState {
  final Failures failure;

  const WatchAnnouncementError({required this.failure});
}

class WatchAnnouncementComplete extends WatchAnnouncementState {
  final List<Announcement> announcements;
  final bool firstLoad;
  const WatchAnnouncementComplete({
    required this.announcements,
    this.firstLoad = false,
  });
  @override
  List<Object> get props => [announcements];
}
