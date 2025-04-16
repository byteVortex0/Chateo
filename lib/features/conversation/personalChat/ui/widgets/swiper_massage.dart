import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/service/shared_pref/pref_key.dart';
import 'package:chateo/core/service/shared_pref/shared_pref.dart';
import 'package:chateo/core/utils/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../../chats/data/model/chat_model.dart';

class SwiperMassage extends StatelessWidget {
  const SwiperMassage({
    super.key,
    required this.isMe,
    required this.chatData,
    required this.user,
  });

  final bool isMe;
  final ChatData chatData;
  final PersonalInfoModel user;

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
              SharedPref.getValue(PrefKey.userId) == chatData.senderId
                  ? 'You'
                  : '${user.firstName} ${user.lastName}',
              style: TextStyle(
                color: isMe ? Colors.white : context.color.yourSwipernameColor,
                fontSize: 12.sp,
                fontWeight: FontWeightHelper.semiBold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              chatData.content!,
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
