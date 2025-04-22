// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/get_chat_usecase.dart';

part 'getchat_state.dart';

@injectable
class GetChatCubit extends Cubit<GetChatState> {
  final GetChatUsecase getChatUsecase;
  GetChatCubit(
    this.getChatUsecase,
  ) : super(GetChatInitial());

  StreamSubscription<ChatEntity?>? _chatSubscription;
  Future<void> getChat() async {
    emit(GetChatLoading());
    final result = await getChatUsecase(NoParams());
    result?.fold(
      (l) {
        emit(GetChatError(l));
      },
      (chatStream) {
        _chatSubscription = chatStream.listen(
          (chat) {
            // if (chat != null) {
            emit(
              GetChatComplete(
                chat,
              ),
            );
            // }
          },
          onError: (error) {
            emit(
              GetChatError(
                CacheFailure(
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
    _chatSubscription?.cancel();
    return super.close();
  }
}
