import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/fonts/style_manager.dart';
import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';

class AppBarChat extends StatelessWidget implements PreferredSizeWidget {
  const AppBarChat({super.key, required this.user});

  final PersonalInfoModel user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.color.thirdColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 15.r,
            backgroundColor: context.color.bgTextFieldColor,
            child:
                user.imageUrl.isNotEmpty
                    ? ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.network(
                        user.imageUrl,
                        fit: BoxFit.cover,
                        width: 40.w,
                        height: 40.h,
                      ),
                    )
                    : Icon(
                      Icons.person,
                      color: context.color.hintTextFieldColor,
                      size: 30.sp,
                    ),
          ),
          SizedBox(width: 10.w),
          Text(
            '${user.firstName} ${user.lastName}',
            style: StyleManager.neutral10Regular(
              context,
            ).copyWith(fontSize: 18.sp),
          ),
        ],
      ),
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: context.color.secondaryColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50.h);
}
