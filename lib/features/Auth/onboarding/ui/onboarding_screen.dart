import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/utils/fonts/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../core/routes/app_routes.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(context.asset.onBoarding!),
                    SizedBox(height: 20.h),
                    Text(
                      'Connect easily with\nyour family and friends\nover countries',
                      textAlign: TextAlign.center,
                      style: StyleManager.black24Bold(context),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Terms & Privacy Policy',
              style: StyleManager.secondary14SemiBold(context),
            ),
            SizedBox(height: 7.h),
            CustomElevatedButton(
              title: 'Start Messaging',
              onTap: () {
                context.pushNamed(AppRoutes.loginByPhone);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
