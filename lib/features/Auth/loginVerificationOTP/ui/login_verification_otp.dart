import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/features/Auth/loginByPhone/logic/login_by_phone/login_by_phone_cubit.dart';
import 'package:chateo/features/Auth/loginVerificationOTP/logic/verify_otp/verify_otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/fonts/style_manager.dart';
import 'widgets/otp_fields.dart';

class LoginVerificationOTP extends StatelessWidget {
  const LoginVerificationOTP({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  final String verificationId;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LoginByPhoneCubit>()),
        BlocProvider(create: (context) => sl<VerifyOtpCubit>()),
      ],
      child: Scaffold(
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
                                'We have sent you an SMS with the code\nto $phoneNumber',
                                style: StyleManager.black14SemiBold(context),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 20.h),

                              OTPFields(verificationId: verificationId),
                            ],
                          ),
                        ),
                      ),
                      BlocConsumer<LoginByPhoneCubit, LoginByPhoneState>(
                        listener: (context, state) {
                          if (state is LoginByPhoneFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          } else if (state is LoginByPhoneSendCode) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Code sent successfully')),
                            );
                          }
                        },
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              context.read<LoginByPhoneCubit>().loginByPhone(
                                phoneNumber: phoneNumber,
                              );
                            },
                            child: Text(
                              'Resend Code',
                              style: StyleManager.offWhite16SemiBold.copyWith(
                                color: context.color.resendCodeColor,
                              ),
                            ),
                          );
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
      ),
    );
  }
}
