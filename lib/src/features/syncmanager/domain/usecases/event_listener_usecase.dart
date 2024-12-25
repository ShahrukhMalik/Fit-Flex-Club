import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/sync_manager_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user EventListener
abstract class EventListenerUsecase extends SyncManagerUsecase
    implements UseCase<Stream<Map<String, dynamic>?>?, NoParams> {}

@Singleton(as: EventListenerUsecase)
class EventListenerUsecaseImpl extends EventListenerUsecase {
  final SyncManagerRepository syncManagerRepository;

  EventListenerUsecaseImpl({required this.syncManagerRepository});

  @override
  Future<Either<Failures, Stream<Map<String, dynamic>?>?>> call(
      NoParams noParams) {
    return syncManagerRepository.eventListener();
  }
}
