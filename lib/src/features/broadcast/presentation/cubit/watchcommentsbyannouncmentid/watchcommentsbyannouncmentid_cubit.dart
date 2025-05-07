// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/features/broadcast/domain/usecases/watch_comments_by_announcement_id_usecase.dart';

part 'watchcommentsbyannouncmentid_state.dart';

@injectable
class WatchCommentsByAnnouncmentIdCubit
    extends Cubit<WatchCommentsByAnnouncmentIdState> {
  WatchCommentsByAnnouncmentIdCubit(
    this.watchCommentsByAnnouncementIdUsecase,
  ) : super(WatchCommentsByAnnouncmentIdInitial());

  StreamSubscription<List<Comment>>? _commentSubscription;

  final WatchCommentsByAnnouncementIdUsecase
      watchCommentsByAnnouncementIdUsecase;

  Future<void> getCommentsByAnnouncement(String announcementId) async {
    emit(WatchCommentsByAnnouncmentIdLoading());

    final result = await watchCommentsByAnnouncementIdUsecase(
        Params(announcementId: announcementId));

    result?.fold(
      (l) {
        emit(WatchCommentsByAnnouncmentIdError(failure: l));
      },
      // (comments) {
      //   emit(
      //     WatchCommentsByAnnouncmentIdComplete(comments),
      //   );
      // },
      (commentsStream) {
        _commentSubscription = commentsStream.listen(
          (comments) {
            emit(
              WatchCommentsByAnnouncmentIdComplete(comments),
            );
          },
          onError: (error) {
            emit(
              WatchCommentsByAnnouncmentIdError(
                failure: CacheFailure(
                  message: error.toString(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _commentSubscription?.cancel();
    return super.close();
  }
}
