// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/features/broadcast/domain/usecases/add_comment_usecase.dart';

part 'addcomment_state.dart';

@injectable
class AddcommentCubit extends Cubit<AddcommentState> {
  final AddCommentUsecase addCommentUsecase;

  AddcommentCubit(
    this.addCommentUsecase,
  ) : super(AddcommentInitial());

  Future<void> addComment({
    required Comment comment,
    required String announcementId,
  }) async {
    emit(AddcommentLoading());
    final result = await addCommentUsecase(
      Params(
        comment: comment,
        announcementId: announcementId,
      ),
    );
    result?.fold(
      (l) {
        emit(AddcommentError(failure: l));
      },
      (r) {
        emit(AddcommentComplete());
      },
    );
  }
}
