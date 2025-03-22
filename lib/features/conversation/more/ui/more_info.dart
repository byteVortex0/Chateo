import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/fonts/style_manager.dart';
import 'widgets/build_list_tile.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(context.asset.profileImage!),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    Text(
                      'Almayra Zamzamy',
                      style: StyleManager.secondary14SemiBold(context),
                    ),
                    Text(
                      //TODO: change number
                      '+62 1309 - 1710 - 1920',
                      style: StyleManager.offWhite12Regular,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            BuildListTile(),
          ],
        ),
      ),
    );
  }
}
