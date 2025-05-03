part of 'postannouncement_cubit.dart';

enum MediaType { image, video }

abstract class PostAnnouncementState extends Equatable {
  const PostAnnouncementState();

  @override
  List<Object> get props => [];
}

class PostAnnouncementInitial extends PostAnnouncementState {}

class PostAnnouncementLoading extends PostAnnouncementState {}

class PostAnnouncementComplete extends PostAnnouncementState {}

class PostAnnouncementError extends PostAnnouncementState {
  final Failures failure;
  const PostAnnouncementError(this.failure);
}

class MediaPickerInitial extends PostAnnouncementState {}

class MediaPicked extends PostAnnouncementState {
  final Uint8List bytes;
  final MediaType type;

  const MediaPicked(this.bytes, this.type);
}
