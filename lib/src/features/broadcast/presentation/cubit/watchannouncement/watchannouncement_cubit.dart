// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart'
    show CacheFailure, Failures;
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/features/broadcast/domain/usecases/watch_announcement_usecase.dart';

part 'watchannouncement_state.dart';

@injectable
class WatchAnnouncementCubit extends Cubit<WatchAnnouncementState> {
  final WatchAnnouncementUsecase watchAnnouncementUsecase;

  StreamSubscription<List<Announcement>>? _announcementSubscription;
  WatchAnnouncementCubit(
    this.watchAnnouncementUsecase,
  ) : super(WatchAnnouncementInitial());

  Future<void> getAnnouncements() async {
    final result = await watchAnnouncementUsecase(NoParams());

    result?.fold(
      (l) {
        emit(
          WatchAnnouncementError(
            failure: l,
          ),
        );
      },
      (announcementsStream) {
        _announcementSubscription = announcementsStream.listen(
          (announcements) {
            emit(
              WatchAnnouncementComplete(
                announcements: announcements,
              ),
            );
          },
          onError: (error) {
            emit(
              WatchAnnouncementError(
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
    _announcementSubscription?.cancel();
    return super.close();
  }
}
