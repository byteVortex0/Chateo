import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/fonts/style_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
  });

  final String hint;
  final TextEditingController controller;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextFormField(
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
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $hint';
              }
              return null;
            },
      ),
    );
  }
}
