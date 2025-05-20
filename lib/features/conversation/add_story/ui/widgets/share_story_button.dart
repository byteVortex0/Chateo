import 'dart:developer';
import 'dart:io';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../data/model/story_model.dart';
import '../../logic/add_story/add_story_cubit.dart';

class ShareStoryButton extends StatelessWidget {
  const ShareStoryButton({super.key, this.image, this.textController});

  final File? image;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddStoryCubit, AddStoryState>(
      listener: (context, state) {
        if (state is AddStoryError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to share story')));
        } else if (state is AddStorySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Story shared successfully')),
          );
          context.pop();
        }
      },
      builder: (context, state) {
        if (state is AddStoryLoading) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          padding: EdgeInsets.only(bottom: 30.h),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              log('text: ${textController?.text}');
              if (image != null ||
                  (textController != null && textController!.text.isNotEmpty)) {
                context.read<AddStoryCubit>().addStory(
                  story: StoryModel(
                    storiesData: [
                      StoryData(
                        caption: textController!.text,
                        imageUrl: image?.path,
                        createdAt: DateTime.now(),
                      ),
                    ],
                    userId: SharedPref.getValue(PrefKey.userId),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Add an image or write text first"),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text("Share Story", style: TextStyle(fontSize: 16)),
          ),
        );
      },
    );
  }
}
