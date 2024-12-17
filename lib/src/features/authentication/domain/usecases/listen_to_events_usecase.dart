import 'package:dartz/dartz.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fit_flex_club/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to let user login with email and password
abstract class ListenToEventsUsecase extends AuthUsecase
    implements UseCase<Stream<Map<String,dynamic>?>?, NoParams> {}

@Singleton(as: ListenToEventsUsecase)
class LogInUsecaseImpl extends ListenToEventsUsecase {
  final AuthRepository authRepository;

  LogInUsecaseImpl({required this.authRepository});

  @override
  Future<Either<Failures, Stream<Map<String,dynamic>?>?>> call(NoParams params) {
    return authRepository.listenToEvents();
  }
}
