import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/fonts/style_manager.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Icon(Icons.add, color: LightColorManager.hintTextField),
        ),
        SizedBox(height: 7.w),
        Text('Name', style: StyleManager.neutral10Regular(context)),
      ],
    );
  }
}
