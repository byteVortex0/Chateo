import 'package:chateo/core/di/injection.dart';
import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/features/Auth/loginByPhone/logic/login_by_phone/login_by_phone_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/fonts/style_manager.dart';

// ignore: must_be_immutable
class LoginByPhone extends StatelessWidget {
  LoginByPhone({super.key});

  final formKey = GlobalKey<FormState>();

  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginByPhoneCubit>(),
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
                          child: Form(
                            key: formKey,
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
                                  dropdownTextStyle:
                                      StyleManager.black14SemiBold(context),
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
                                    phoneNumber = phone.completeNumber;
                                  },

                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BlocConsumer<LoginByPhoneCubit, LoginByPhoneState>(
                        listener: (context, state) {
                          if (state is LoginByPhoneSendCode) {
                            //TODO: refactor
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Code sent successfully')),
                            );
                            context.pushNamed(
                              AppRoutes.loginVerificationOTP,
                              arguments: {
                                'verificationId': state.verificationId,
                                'phoneNumber': phoneNumber,
                              },
                            );
                          } else if (state is LoginByPhoneFailed) {
                            //TODO: refactor
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            title: 'Continue',
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginByPhoneCubit>().loginByPhone(
                                  phoneNumber: phoneNumber,
                                );
                              }
                            },
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
