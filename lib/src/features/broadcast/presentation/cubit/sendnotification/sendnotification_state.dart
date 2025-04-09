// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sendnotification_cubit.dart';

abstract class SendNotificationState extends Equatable {
  const SendNotificationState();

  @override
  List<Object> get props => [];
}

class SendNotificationInitial extends SendNotificationState {}

class SendNotificationLoading extends SendNotificationState {}

class SendNotificationComplete extends SendNotificationState {}

class SendNotificationError extends SendNotificationState {
  final Failures failures;
  const SendNotificationError({
    required this.failures,
  });
}
