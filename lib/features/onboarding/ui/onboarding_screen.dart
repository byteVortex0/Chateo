import 'package:chateo/core/utils/color_manager.dart';
import 'package:chateo/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    SvgPicture.asset('assets/images/svgs/onboarding.svg'),
                    SizedBox(height: 20.h),
                    Text(
                      'Connect easily with\nyour family and friends\nover countries',
                      textAlign: TextAlign.center,
                      style: StyleManager.black24Bold,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Terms & Privacy Policy',
              style: StyleManager.secondary14SemiBold,
            ),
            SizedBox(height: 7.h),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightColorManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                ),
                child: Text(
                  'Start Messaging',
                  style: StyleManager.white16SemiBold,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
