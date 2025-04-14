import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/color_manager.dart';

class DividerDay extends StatelessWidget {
  const DividerDay({super.key, required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: LightColorManager.dividerColor,
              thickness: 1.5,
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            time,
            style: TextStyle(
              color: context.color.hintTextFieldColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Divider(
              color: LightColorManager.dividerColor,
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
