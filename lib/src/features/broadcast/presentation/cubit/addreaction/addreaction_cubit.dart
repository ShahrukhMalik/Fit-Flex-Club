// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/add_reaction_usecase.dart';

part 'addreaction_state.dart';

@injectable
class AddReactionCubit extends Cubit<AddReactionState> {
  final AddReactionUsecase addReactionUsecase;
  AddReactionCubit(
    this.addReactionUsecase,
  ) : super(AddReactionInitial());

  Future<void> addReaction({
    required Reaction reaction,
    required String announcementId,
  }) async {
    emit(AddReactionLoading());

    final result = await addReactionUsecase(
      Params(
        reaction: reaction,
        announcementId: announcementId,
      ),
    );
    result?.fold(
      (l) {
        emit(AddReactionError(failure: l));
      },
      (r) {
        emit(AddReactionComplete());
      },
    );
  }
}
