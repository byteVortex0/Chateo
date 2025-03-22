import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/fonts/style_manager.dart';
import 'widgets/otp_fields.dart';

class LoginVerificationOTP extends StatelessWidget {
  const LoginVerificationOTP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Enter Code',
                              style: StyleManager.black24Bold(context),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              //TODO: add number
                              'We have sent you an SMS with the code\nto +62 1309 - 1710 - 1920',
                              style: StyleManager.black14SemiBold(context),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 20.h),

                            OTPFields(),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend Code',
                        style: StyleManager.offWhite16SemiBold.copyWith(
                          color: context.color.resendCodeColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
