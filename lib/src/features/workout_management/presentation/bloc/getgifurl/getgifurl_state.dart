part of 'getgifurl_cubit.dart';

abstract class GetgifurlState extends Equatable {
  const GetgifurlState();

  @override
  List<Object> get props => [];
}

class GetgifurlInitial extends GetgifurlState {}

class GetgifurlLoading extends GetgifurlState {}

class GetgifurlComplete extends GetgifurlState {
  final ExerciseGifModel exerciseGifModel;
  const GetgifurlComplete({
    required this.exerciseGifModel,
  });
}

class GetgifurlError extends GetgifurlState {
  final Failures failures;
  const GetgifurlError({required this.failures});
}
