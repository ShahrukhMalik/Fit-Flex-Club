import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/watch_reactions_by_announcment_id_usecase.dart';
import 'package:injectable/injectable.dart';

part 'watchreactionsbyannouncmentid_state.dart';

@injectable
class WatchReactionsbyAnnouncmentIdCubit
    extends Cubit<WatchReactionsbyAnnouncmentIdState> {
  final WatchReactionsByAnnouncementIdUsecase
      watchReactionsByAnnouncementIdUsecase;
  WatchReactionsbyAnnouncmentIdCubit(this.watchReactionsByAnnouncementIdUsecase)
      : super(WatchReactionsbyAnnouncmentIdInitial());
  StreamSubscription<List<Reaction>>? _reactionSubscription;
  Future<void> getReactionsByAnnouncementId(String announcementId) async {
    emit(WatchReactionsbyAnnouncmentIdLoading());
    final result = await watchReactionsByAnnouncementIdUsecase(
        Params(announcementId: announcementId));

    result?.fold(
      (l) {
        emit(
          WatchReactionsbyAnnouncmentIdError(
            failure: l,
          ),
        );
      },
      (reactions) {
        emit(WatchReactionsbyAnnouncmentIdComplete(reactions: reactions));
      },
      // (reactionsStream) {
      //   _reactionSubscription = reactionsStream.listen(
      //     (reactions) {
      //       emit(
      //         WatchReactionsbyAnnouncmentIdComplete(
      //           reactions: reactions,
      //         ),
      //       );
      //     },
      //     onError: (error) {
      //       emit(
      //         WatchReactionsbyAnnouncmentIdError(
      //           failure: CacheFailure(
      //             message: error.toString(),
      //           ),
      //         ),
      //       );
      //     },
      //   );
      // },
    );
  }

  @override
  Future<void> close() {
    _reactionSubscription?.cancel();
    return super.close();
  }
}
