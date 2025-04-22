// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:injectable/injectable.dart';

part 'sendmessage_state.dart';

@injectable
class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageUsecase sendMessageUsecase;
  SendMessageCubit(
    this.sendMessageUsecase,
  ) : super(SendMessageInitial());

  Future<void> sendMessage({
    required MessageEntity message,
    required ChatEntity chat,
  }) async {
    final result =
        await sendMessageUsecase(Params(chat: chat, message: message));
    result?.fold(
      (l) {
        emit(SendMessageError(failure: l));
      },
      (r) {
        emit(SendMessageComplete());
      },
    );
  }
}
