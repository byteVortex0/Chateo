import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/fonts/font_weight_helper.dart';

class MassageTwoLine extends StatelessWidget {
  const MassageTwoLine({
    super.key,
    required this.massage,
    required this.isMe,
    required this.time,
  });

  final String massage;
  final bool isMe;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          massage,
          style: TextStyle(
            color: isMe ? Colors.white : context.color.secondaryColor,
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.semiBold,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          isMe ? '$time . Read' : time,
          style: TextStyle(
            color: isMe ? Colors.white : LightColorManager.hintTextField,
            fontSize: 10.sp,
            fontWeight: FontWeightHelper.semiBold,
          ),
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
