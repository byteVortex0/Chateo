import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_manager.dart';
import '../../utils/fonts/style_manager.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.phoneNumber,
    required this.massage,
    this.timeMassage,
    this.onPressed,
  });

  final String name;
  final String imageUrl;
  final String phoneNumber;
  final String massage;
  final String? timeMassage;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child:
                  imageUrl.isNotEmpty
                      ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.person),
                      )
                      : const Icon(Icons.person),
            ),
          ),
          SizedBox(width: 7.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: StyleManager.neutral10Regular(
                    context,
                  ).copyWith(fontSize: 14.sp),
                ),
                SizedBox(width: 7.w),
                Text(
                  massage.isEmpty ? phoneNumber : massage,
                  style: StyleManager.neutral10Regular(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          timeMassage != null
              ? Text(
                timeMassage!,
                style: StyleManager.neutral10Regular(context),
              )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
