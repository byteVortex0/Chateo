import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/utils/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwiperMassage extends StatelessWidget {
  const SwiperMassage({super.key, required this.isMe});

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: isMe ? Colors.white : context.color.yourSwiperContainerColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Container(
        margin:
            isMe
                ? EdgeInsetsDirectional.only(end: 5.w)
                : EdgeInsetsDirectional.only(start: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
          color:
              isMe
                  ? context.color.mySwiperMassageColor
                  : context.color.yourSwiperMassageColor,
          borderRadius:
              isMe
                  ? BorderRadiusDirectional.only(
                    topStart: Radius.circular(6.r),
                    bottomStart: Radius.circular(6.r),
                  )
                  : BorderRadiusDirectional.only(
                    topEnd: Radius.circular(6.r),
                    bottomEnd: Radius.circular(6.r),
                  ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              'You',
              style: TextStyle(
                color: isMe ? Colors.white : context.color.yourSwipernameColor,
                fontSize: 12.sp,
                fontWeight: FontWeightHelper.semiBold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Helooo',
              style: TextStyle(
                color: isMe ? Colors.white : context.color.yourSwipertextColor,
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
