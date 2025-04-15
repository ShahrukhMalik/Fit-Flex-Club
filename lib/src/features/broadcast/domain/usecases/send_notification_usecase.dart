import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/broadcast_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class SendNotificationUsecase extends BroadcastUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final NotificationEntity notification;

  const Params({required this.notification});

  @override
  List<Object?> get props => [
        notification,
      ];
}

@Singleton(as: SendNotificationUsecase)
class SendNotificationUsecaseImpl extends SendNotificationUsecase {
  final BroadcastRepository broadcastRepository;

  SendNotificationUsecaseImpl({required this.broadcastRepository});

  @override
  Future<Either<Failures, void>>? call(Params params) {
    return broadcastRepository.sendNotification(
      params.notification,
    );
  }
}
