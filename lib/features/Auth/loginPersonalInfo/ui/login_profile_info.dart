import 'package:chateo/core/common/widgets/custom_elevated_button.dart';
import 'package:chateo/core/common/widgets/custom_text_field.dart';
import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/utils/fonts/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/routes/app_routes.dart';

class LoginProfileInfo extends StatelessWidget {
  const LoginProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: StyleManager.black18SemiBold(context),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(context.asset.profile!),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          hint: 'First Name (Required)',
                          controller: TextEditingController(),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          hint: 'Last Name (Optional)',
                          controller: TextEditingController(),
                        ),
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    title: 'Save',
                    onTap: () {
                      context.pushNamedAndRemoveUntil(AppRoutes.chatsScreen);
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
