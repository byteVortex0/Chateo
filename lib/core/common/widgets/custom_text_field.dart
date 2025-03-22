import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/fonts/style_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
  });

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        style: StyleManager.black14SemiBold(context),
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.color.bgTextFieldColor,
          hintText: hint,
          hintStyle: StyleManager.offWhite14SemiBold(context),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
