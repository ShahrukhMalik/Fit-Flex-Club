// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/reaction_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/repositories/broadcast_repository.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/broadcast_usecase.dart';

abstract class AddReactionUsecase extends BroadcastUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  final Reaction reaction;
  final String announcementId;
  const Params({
    required this.reaction,
    required this.announcementId,
  });
  @override
  List<Object?> get props => [
        reaction,
        announcementId
      ];
}

@Singleton(as: AddReactionUsecase)
class AddReactionUsecaseImpl extends AddReactionUsecase {
  final BroadcastRepository broadcastRepository;
  AddReactionUsecaseImpl({required this.broadcastRepository});
  @override
  Future<Either<Failures, void>>? call(Params params) {
    return broadcastRepository.addReaction(
      announcementId: params.announcementId,
      reaction: params.reaction
    );
  }
}