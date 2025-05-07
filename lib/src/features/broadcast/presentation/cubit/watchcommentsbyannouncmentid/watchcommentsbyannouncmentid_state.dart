part of 'watchcommentsbyannouncmentid_cubit.dart';

abstract class WatchCommentsByAnnouncmentIdState extends Equatable {
  const WatchCommentsByAnnouncmentIdState();

  @override
  List<Object> get props => [];
}

class WatchCommentsByAnnouncmentIdInitial
    extends WatchCommentsByAnnouncmentIdState {}

class WatchCommentsByAnnouncmentIdLoading
    extends WatchCommentsByAnnouncmentIdState {}

class WatchCommentsByAnnouncmentIdComplete
    extends WatchCommentsByAnnouncmentIdState {
  final List<Comment> comments;
  const WatchCommentsByAnnouncmentIdComplete(this.comments);
  @override
  List<Object> get props => [comments];
}

class WatchCommentsByAnnouncmentIdError
    extends WatchCommentsByAnnouncmentIdState {
  final Failures failure;
  const WatchCommentsByAnnouncmentIdError({required this.failure});
}
