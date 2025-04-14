import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/fonts/font_weight_helper.dart';

class MassageOneLine extends StatelessWidget {
  const MassageOneLine({
    super.key,
    required this.massage,
    required this.isMe,
    required this.time,
    required this.isSeen,
  });

  final String massage;
  final bool isMe;
  final String time;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: massage,
            style: TextStyle(
              color: isMe ? Colors.white : context.color.secondaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
          WidgetSpan(child: SizedBox(width: 5.w)),
          TextSpan(
            text: time,
            style: TextStyle(
              color: isMe ? Colors.white : LightColorManager.hintTextField,
              fontSize: 10.sp,
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
          isSeen
              ? TextSpan(
                text: ' . Read',
                style: TextStyle(
                  color: isMe ? Colors.white : LightColorManager.hintTextField,
                  fontSize: 10.sp,
                  fontWeight: FontWeightHelper.semiBold,
                ),
              )
              : TextSpan(),
        ],
      ),
    );
  }
}
