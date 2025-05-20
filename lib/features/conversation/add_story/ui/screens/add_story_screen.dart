import 'dart:io';

import 'package:chateo/features/conversation/add_story/ui/widgets/share_story_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Auth/loginPersonalInfo/logic/upload_images/upload_images_cubit.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  File? _image;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    final greyBorder = Border.all(color: Colors.grey.shade300);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text("Add Story", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocConsumer<UploadImagesCubit, UploadImagesState>(
              listener: (context, state) {
                if (state is UploadImagesSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Image uploaded successfully'),
                    ),
                  );
                } else if (state is UploadImagesFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to upload image')),
                  );
                }
              },
              builder: (context, state) {
                final uploadCubit = context.read<UploadImagesCubit>();
                if (state is UploadImagesLoading) {
                  return Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: borderRadius,
                      border: greyBorder,
                    ),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is UploadImagesSuccess) {
                  _image = File(state.image);
                  return Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: borderRadius,
                      border: greyBorder,
                    ),
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.network(state.image, fit: BoxFit.fill),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () async {
                    await uploadCubit.uploadImages();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: borderRadius,
                      border: greyBorder,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _textController,
              maxLines: 4,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Write your story...",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const Spacer(),

            ShareStoryButton(image: _image, textController: _textController),
          ],
        ),
      ),
    );
  }
}
