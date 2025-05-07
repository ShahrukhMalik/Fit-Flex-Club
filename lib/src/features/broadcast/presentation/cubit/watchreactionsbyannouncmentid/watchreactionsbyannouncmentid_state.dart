part of 'watchreactionsbyannouncmentid_cubit.dart';

abstract class WatchReactionsbyAnnouncmentIdState extends Equatable {
  const WatchReactionsbyAnnouncmentIdState();

  @override
  List<Object> get props => [];
}

class WatchReactionsbyAnnouncmentIdInitial
    extends WatchReactionsbyAnnouncmentIdState {}

class WatchReactionsbyAnnouncmentIdLoading
    extends WatchReactionsbyAnnouncmentIdState {}

class WatchReactionsbyAnnouncmentIdComplete
    extends WatchReactionsbyAnnouncmentIdState {
  final List<Reaction> reactions;
  const WatchReactionsbyAnnouncmentIdComplete({
    required this.reactions,
  });

  @override
  List<Object> get props => [reactions];
}

class WatchReactionsbyAnnouncmentIdError
    extends WatchReactionsbyAnnouncmentIdState {
  final Failures failure;
  const WatchReactionsbyAnnouncmentIdError({required this.failure});
}
