import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/add_story/add_story_cubit.dart';

class ShareStoryButton extends StatelessWidget {
  const ShareStoryButton({super.key, this.onTap});

  final void Function()? onTap;

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
            onPressed: onTap,
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
