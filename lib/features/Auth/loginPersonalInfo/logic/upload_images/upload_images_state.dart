part of 'upload_images_cubit.dart';

@immutable
sealed class UploadImagesState {}

final class UploadImagesInitial extends UploadImagesState {}

// This state is used when the image is picked
final class PickedImagesLoading extends UploadImagesState {}

final class PickedImagesSuccess extends UploadImagesState {}

// This state is used when the image is being uploaded
final class UploadImagesLoading extends UploadImagesState {}

final class UploadImagesSuccess extends UploadImagesState {
  final String image;

  UploadImagesSuccess({required this.image});
}

final class UploadImagesFailure extends UploadImagesState {
  final String error;

  UploadImagesFailure({required this.error});
}
