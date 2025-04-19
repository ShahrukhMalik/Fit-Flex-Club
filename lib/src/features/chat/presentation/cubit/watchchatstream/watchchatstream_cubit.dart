// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/watch_chat_stream_usecase.dart';

part 'watchchatstream_state.dart';

@injectable
class WatchChatStreamCubit extends Cubit<WatchChatStreamState> {
  final WatchChatStreamUsecase watchChatStreamUsecase;
  WatchChatStreamCubit(
    this.watchChatStreamUsecase,
  ) : super(WatchChatStreamInitial());

  Future<void> getChats() async {
    final result = await watchChatStreamUsecase(NoParams());
    result?.fold(
      (l) {
        emit(WatchChatStreamError(failure: l));
      },
      (chatsStream) async {
        await for (final chats in chatsStream) {
          emit(
            WatchChatStreamComplete(
              chats,
            ),
          );
        }
      },
    );
  }
}
