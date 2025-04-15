import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';

abstract class BroadcastRepository {
  ///
  Future<Either<Failures, void>> sendNotification(
    NotificationEntity notification,
  );
}
