// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:fit_flex_club/src/features/chat/domain/usecases/update_message_usecase.dart';
part 'updatemessage_state.dart';

@injectable
class UpdateMessageCubit extends Cubit<UpdateMessageState> {
  final UpdateMessageUsecase updateMessageUsecase;

  UpdateMessageCubit(
    this.updateMessageUsecase,
  ) : super(UpdateMessageInitial());

  Future<void> updateMessageStatus({
    required MessageEntity message,
    required ChatEntity chat,
  }) async {
    if (state is! UpdateMessageInitial) {
      emit(UpdateMessageInitial());
    }
    final result = await updateMessageUsecase(
      Params(
        chat: chat,
        message: message,
      ),
    );

    result?.fold(
      (l) {
        emit(UpdateMessageError(failure: l));
      },
      (r) {
        emit(UpdateMessageComplete());
      },
    );
  }
}
