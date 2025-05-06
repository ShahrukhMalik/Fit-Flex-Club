part of 'getemojis_cubit.dart';

abstract class GetEmojisState extends Equatable {
  const GetEmojisState();

  @override
  List<Object> get props => [];
}

class GetEmojisInitial extends GetEmojisState {}

class GetEmojisLoading extends GetEmojisState {}

class GetEmojisComplete extends GetEmojisState {
  final List<EmojiEntity> emojis;
  const GetEmojisComplete({required this.emojis});
}

class GetEmojisError extends GetEmojisState {
  final Failures failure;
  const GetEmojisError({required this.failure});
}
