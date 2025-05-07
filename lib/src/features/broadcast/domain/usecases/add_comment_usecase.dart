import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/broadcast_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class AddCommentUsecase extends BroadcastUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final Comment comment;
  final String announcementId;
  const Params({
    required this.comment,
    required this.announcementId,
  });
  @override
  List<Object?> get props => [
        comment,
        announcementId
      ];
}

@Singleton(as: AddCommentUsecase)
class AddCommentUsecaseImpl extends AddCommentUsecase {
  final BroadcastRepository broadcastRepository;
  AddCommentUsecaseImpl({required this.broadcastRepository});
  @override
  Future<Either<Failures, void>>? call(Params params) {
    return broadcastRepository.addComment(
      announcementId: params.announcementId,
      comment: params.comment
    );
  }
}