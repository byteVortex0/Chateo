import 'dart:developer';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/routes/app_routes.dart';
import 'package:chateo/core/utils/fonts/style_manager.dart';
import 'package:chateo/features/Auth/loginVerificationOTP/logic/verify_otp/verify_otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPFields extends StatefulWidget {
  const OTPFields({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  final String verificationId;
  final String phoneNumber;

  @override
  State<OTPFields> createState() => _OTPFieldsState();
}

class _OTPFieldsState extends State<OTPFields> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        if (_controllers[5].text.isNotEmpty) {
          context.read<VerifyOtpCubit>().verifyOTP(
            verificationId: widget.verificationId,
            otp: _controllers.map((e) => e.text).join(),
          );
        }
      }
    }
  }

  void _onKeyPress(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Verified successfully')));
          context.pushNamedAndRemoveUntil(
            AppRoutes.loginProfileInfo,
            arguments: {
              'token': state.token,
              'phoneNumber': widget.phoneNumber,
            },
          );
        } else if (state is VerifyOtpFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Expanded(
                  child: KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (event) => _onKeyPress(event, index),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: StyleManager.black28Bold(context),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => _onChanged(value, index),
                        onSubmitted: (value) {
                          if (index == 5) {
                            String otpCode =
                                _controllers.map((e) => e.text).join();
                            log("رمز التحقق: $otpCode");
                          }
                        },
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        onEditingComplete: () async {
                          if (index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20.h),
            if (state is VerifyOtpLoading) CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
