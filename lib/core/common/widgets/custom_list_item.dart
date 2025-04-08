import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_manager.dart';
import '../../utils/fonts/style_manager.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        SizedBox(width: 7.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name', style: StyleManager.neutral10Regular(context)),
            SizedBox(width: 7.w),
            Text('Massage', style: StyleManager.neutral10Regular(context)),
          ],
        ),
      ],
    );
  }
}
