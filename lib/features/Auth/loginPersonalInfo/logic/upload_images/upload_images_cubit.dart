import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chateo/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'upload_images_state.dart';

class UploadImagesCubit extends Cubit<UploadImagesState> {
  UploadImagesCubit() : super(UploadImagesInitial());

  final supabase = Supabase.instance.client;

  XFile? _image;

  pickedImage() async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: DarkColorManager.bgDark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    emit(PickedImagesLoading());
    final pickedImage = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      emit(UploadImagesFailure(error: 'No image selected'));
      return;
    }

    log('Picked image path: ${pickedImage.path}');

    // Crop the image
    final cropperImg = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      maxHeight: 200,
      maxWidth: 200,
      compressQuality: 70,
      //TODO: check if this is needed
      // compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: DarkColorManager.bgDark,
          statusBarColor: DarkColorManager.bgDark,
          toolbarWidgetColor: Colors.white,
          backgroundColor: Colors.white,
          dimmedLayerColor: Colors.black54,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
      ],
    );

    if (cropperImg == null) {
      emit(UploadImagesFailure(error: 'No image selected'));
      return;
    }

    _image = XFile(cropperImg.path);

    emit(PickedImagesSuccess());
  }

  Future<void> uploadImages() async {
    await pickedImage();
    if (_image == null) {
      return;
    }
    emit(UploadImagesLoading());
    try {
      final File file = File(_image!.path);
      final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final response = await supabase.storage
          .from('images')
          .upload(fileName, file);

      if (response.isEmpty) {
        emit(UploadImagesFailure(error: 'Failed to upload image'));
        return;
      }

      final imageUrl = supabase.storage.from('images').getPublicUrl(fileName);

      emit(UploadImagesSuccess(image: imageUrl));
    } catch (e) {
      log('Error uploading image: $e');
      emit(UploadImagesFailure(error: 'Failed to upload image: $e'));
    }
  }
}
