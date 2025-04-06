part of 'upload_images_cubit.dart';

@immutable
sealed class UploadImagesState {}

final class UploadImagesInitial extends UploadImagesState {}

final class UploadImagesLoading extends UploadImagesState {}

final class UploadImagesSuccess extends UploadImagesState {
  final String image;

  UploadImagesSuccess({required this.image});
}

final class UploadImagesFailure extends UploadImagesState {
  final String error;

  UploadImagesFailure({required this.error});
}
