// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/usecases/post_announcement_usecase.dart';

part 'postannouncement_state.dart';

@injectable
class PostAnnouncementCubit extends Cubit<PostAnnouncementState> {
  final PostAnnouncementUsecase postAnnouncementUsecase;
  final ImagePicker _picker = ImagePicker();
  PostAnnouncementCubit(
    this.postAnnouncementUsecase,
  ) : super(PostAnnouncementInitial());

  XFile? file;

  void removeMedia() => emit(PostAnnouncementInitial());

  Future<void> postAnnouncement(Announcement announcement) async {
    emit(PostAnnouncementLoading());
    final result = await postAnnouncementUsecase(
      Params(
        announcement: announcement,
      ),
    );
    result?.fold(
      (l) {
        emit(PostAnnouncementError(l));
      },
      (r) {
        emit(PostAnnouncementComplete());
      },
    );
  }

  Future<void> pickImage() async {
    file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      emit(MediaPicked(await file!.readAsBytes(), MediaType.image));
    } else {
      emit(MediaPickerInitial());
    }
  }

  Future<void> pickVideo() async {
    file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      emit(MediaPicked(await file!.readAsBytes(), MediaType.video));
    } else {
      emit(MediaPickerInitial());
    }
  }
}
