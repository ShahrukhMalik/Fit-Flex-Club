// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/emoji_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/get_emojis_usecase.dart';

part 'getemojis_state.dart';

@injectable
class GetEmojisCubit extends Cubit<GetEmojisState> {
  final GetEmojisUsecase getEmojisUsecase;
  GetEmojisCubit(
    this.getEmojisUsecase,
  ) : super(GetEmojisInitial());

  Future<void> getEmojis() async {
    emit(GetEmojisLoading());
    final result = await getEmojisUsecase(NoParams());
    result?.fold(
      (l) {
        emit(GetEmojisError(failure: l));
      },
      (r) {
        emit(GetEmojisComplete(emojis: r));
      },
    );
  }
}
