import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/fonts/style_manager.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, this.onTap, this.imageUrl, required this.name});

  final void Function()? onTap;
  final String? imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            //TODO: Hard code
            height: 40.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: context.color.bgTextFieldColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: LightColorManager.hintTextField),
            ),
            child:
                imageUrl != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person);
                        },
                      ),
                    )
                    : const Icon(
                      Icons.person,
                      color: LightColorManager.hintTextField,
                    ),
          ),
          SizedBox(height: 7.w),
          Text(name, style: StyleManager.neutral10Regular(context)),
        ],
      ),
    );
  }
}
