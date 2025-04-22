// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

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

  StreamSubscription<List<ChatEntity>>? _chatSubscription;
  WatchChatStreamCubit(
    this.watchChatStreamUsecase,
  ) : super(WatchChatStreamInitial());

  Future<void> getChats() async {
    final result = await watchChatStreamUsecase(NoParams());
    result?.fold(
      (l) {
        emit(WatchChatStreamError(failure: l));
      },
      (chatsStream) {
        _chatSubscription = chatsStream.listen(
          (messages) {
            emit(WatchChatStreamComplete(messages));
          },
          onError: (error) {
            emit(
              WatchChatStreamError(
                failure: CacheFailure(message: error.toString()),
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
