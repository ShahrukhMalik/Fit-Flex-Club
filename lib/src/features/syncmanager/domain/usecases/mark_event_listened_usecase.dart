import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/sync_manager_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user MarkEventListened
abstract class MarkEventListenedUsecase extends SyncManagerUsecase
    implements UseCase<void, Params> {}

class Params extends Equatable {
  final String docId;
  const Params({required this.docId});
  @override
  List<Object?> get props => [docId];
}

@Singleton(as: MarkEventListenedUsecase)
class MarkEventListenedUsecaseImpl extends MarkEventListenedUsecase {
  final SyncManagerRepository syncManagerRepository;

  MarkEventListenedUsecaseImpl({required this.syncManagerRepository});

  @override
  Future<Either<Failures, void>?>? call(Params params) {
    return syncManagerRepository.markEventListened(params.docId);
  }
}
