// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/start_chat_usecase.dart';
import 'package:injectable/injectable.dart';

part 'startchat_state.dart';

@injectable
class StartChatCubit extends Cubit<StartChatState> {
  final StartChatUsecase startChatUsecase;
  StartChatCubit(
    this.startChatUsecase,
  ) : super(StartChatInitial());

  Future<void> startChat(ChatEntity chat) async {
    emit(StartChatLoading());
    final result = await startChatUsecase(Params(chat: chat));

    result?.fold(
      (l) {
        emit(StartChatError(failure: l));
      },
      (r) {
        emit(StartChatComplete());
      },
    );
  }
}
