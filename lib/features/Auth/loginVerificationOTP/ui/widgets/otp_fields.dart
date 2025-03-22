import 'dart:developer';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/routes/app_routes.dart';
import 'package:chateo/core/utils/fonts/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPFields extends StatefulWidget {
  const OTPFields({super.key});

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return KeyboardListener(
          focusNode: FocusNode(),
          onKeyEvent: (event) => _onKeyPress(event, index),
          //TODO: Hard code
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 50,
            height: 50,
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
                  String otpCode = _controllers.map((e) => e.text).join();
                  log("رمز التحقق: $otpCode");
                }
              },
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              onEditingComplete: () {
                if (index < 5) {
                  _focusNodes[index + 1].requestFocus();
                } else {
                  context.pushNamedAndRemoveUntil(AppRoutes.loginProfileInfo);
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
