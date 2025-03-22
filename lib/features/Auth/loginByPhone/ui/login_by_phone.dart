import 'dart:developer';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/fonts/style_manager.dart';

class LoginByPhone extends StatelessWidget {
  const LoginByPhone({super.key});

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
                              'Enter Your Phone Number',
                              style: StyleManager.black24Bold(context),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'Please confirm your country code and enter\nyour phone number',
                              style: StyleManager.black14SemiBold(context),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 20.h),

                            IntlPhoneField(
                              autofocus: true,
                              dropdownTextStyle: StyleManager.black14SemiBold(
                                context,
                              ),
                              style: StyleManager.black14SemiBold(context),
                              decoration: InputDecoration(
                                fillColor: context.color.bgTextFieldColor,
                                filled: true,
                                hintText: 'Phone Number',
                                hintStyle: StyleManager.offWhite14SemiBold(
                                  context,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              initialCountryCode: 'EG',
                              onChanged: (phone) {
                                log(
                                  'رقم الهاتف بالكامل: ${phone.completeNumber}',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomElevatedButton(
                      title: 'Continue',
                      onTap: () {
                        context.pushNamed(AppRoutes.loginVerificationOTP);
                      },
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
