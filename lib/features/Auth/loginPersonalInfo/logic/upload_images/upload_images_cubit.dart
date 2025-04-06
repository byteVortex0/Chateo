import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'upload_images_state.dart';

class UploadImagesCubit extends Cubit<UploadImagesState> {
  UploadImagesCubit() : super(UploadImagesInitial());

  final supabase = Supabase.instance.client;

  Future<void> uploadImages() async {
    emit(UploadImagesLoading());
    try {
      final pickedImage = await ImagePicker().pickImage(
        imageQuality: 50,
        source: ImageSource.gallery,
      );

      if (pickedImage == null) {
        emit(UploadImagesFailure(error: 'No image selected'));
        return;
      }

      final File file = File(pickedImage.path);
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
