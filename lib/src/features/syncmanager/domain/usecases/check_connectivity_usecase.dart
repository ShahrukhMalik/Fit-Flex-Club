import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/sync_manager_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user CheckConnectivity
abstract class CheckConnectivityUsecase extends SyncManagerUsecase
    implements UseCase<Stream<bool>, NoParams> {}

@Singleton(as: CheckConnectivityUsecase)
class CheckConnectivityUsecaseImpl extends CheckConnectivityUsecase {
  final SyncManagerRepository syncManagerRepository;

  CheckConnectivityUsecaseImpl({required this.syncManagerRepository});

  @override
  Future<Either<Failures, Stream<bool>>>? call(NoParams noParams) {
    return syncManagerRepository.isOnline();
  }
}
