// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/send_notification_usecase.dart';
import 'package:injectable/injectable.dart';

part 'sendnotification_state.dart';

@injectable
class SendNotificationCubit extends Cubit<SendNotificationState> {
  final SendNotificationUsecase sendNotificationUsecase;
  SendNotificationCubit(
    this.sendNotificationUsecase,
  ) : super(SendNotificationInitial());

  Future<void> sendNotification(NotificationEntity notification) async {
    emit(SendNotificationLoading());
    final sendResult = await sendNotificationUsecase(
      Params(
        notification: notification,
      ),
    );
    sendResult?.fold(
      (l) {
        emit(SendNotificationError(failures: l));
      },
      (r) {
        emit(SendNotificationComplete());
      },
    );
  }
}
