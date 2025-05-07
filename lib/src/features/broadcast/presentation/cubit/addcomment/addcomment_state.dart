part of 'addcomment_cubit.dart';

abstract class AddcommentState extends Equatable {
  const AddcommentState();

  @override
  List<Object> get props => [];
}

class AddcommentInitial extends AddcommentState {}

class AddcommentLoading extends AddcommentState {}

class AddcommentComplete extends AddcommentState {}

class AddcommentError extends AddcommentState {
  final Failures failure;
  const AddcommentError({required this.failure});
}
