// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';

import 'package:fit_flex_club/src/features/chat/domain/usecases/watch_messages_by_chat_id_usecase.dart';
import 'package:injectable/injectable.dart';

part 'watchmessagesbychatid_state.dart';

// @injectable
// class WatchMessagesbyChatIdCubit extends Cubit<WatchMessagesbyChatIdState> {
//   final WatchMessagesByChatIdUsecase watchMessagesByChatIdUsecase;
//   WatchMessagesbyChatIdCubit(
//     this.watchMessagesByChatIdUsecase,
//   ) : super(WatchMessagesbyChatIdInitial());

//   Future<void> getMessagesByChatId(String chatId) async {
//     if (state is! WatchMessagesbyChatIdInitial) {
//       emit(WatchMessagesbyChatIdInitial());
//     }
//     final result = await watchMessagesByChatIdUsecase(Params(chatId: chatId));

//     result?.fold(
//       (l) {
//         emit(WatchMessagesbyChatIdError(failure: l));
//       },
//       (messagesStream) async {
//         await for (final messages in messagesStream) {
//           emit(WatchMessagesbyChatIdComplete(messages));
//         }
//       },
//     );
//   }
// }
@injectable
class WatchMessagesbyChatIdCubit extends Cubit<WatchMessagesbyChatIdState> {
  final WatchMessagesByChatIdUsecase watchMessagesByChatIdUsecase;

  StreamSubscription<List<MessageEntity>>? _messageSubscription;

  WatchMessagesbyChatIdCubit(this.watchMessagesByChatIdUsecase)
      : super(WatchMessagesbyChatIdInitial());

  Future<void> getMessagesByChatId(String chatId) async {
    emit(WatchMessagesbyChatIdInitial());

    // Cancel previous subscription
    await _messageSubscription?.cancel();

    final result = await watchMessagesByChatIdUsecase(Params(chatId: chatId));

    result?.fold(
      (l) {
        emit(WatchMessagesbyChatIdError(failure: l));
      },
      (messagesStream) {
        _messageSubscription = messagesStream.listen(
          (messages) {
            emit(WatchMessagesbyChatIdComplete(messages));
          },
          onError: (error) {
            emit(WatchMessagesbyChatIdError(
              failure: CacheFailure(message: error.toString()),
            ));
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
