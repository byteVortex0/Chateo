import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/utils/color_manager.dart';
import 'package:chateo/core/utils/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleManager {
  static TextStyle black24Bold(BuildContext context) => GoogleFonts.mulish(
    color: context.color.secondaryColor,
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle black14SemiBold(BuildContext context) => GoogleFonts.mulish(
    color: context.color.secondaryColor,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle black18SemiBold(BuildContext context) => GoogleFonts.mulish(
    color: context.color.secondaryColor,
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle neutral10Regular(BuildContext context) => GoogleFonts.mulish(
    color: context.color.neutralColor,
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle black28Bold(BuildContext context) => GoogleFonts.mulish(
    color: context.color.secondaryColor,
    fontSize: 28.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle offWhite14SemiBold(BuildContext context) =>
      GoogleFonts.mulish(
        color: context.color.hintTextFieldColor,
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.semiBold,
      );

  static TextStyle offWhite16SemiBold = GoogleFonts.mulish(
    color: LightColorManager.offWhite,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle offWhite12Regular = GoogleFonts.mulish(
    color: LightColorManager.hintTextField,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle secondary14SemiBold(BuildContext context) =>
      GoogleFonts.mulish(
        color: context.color.neutralColor,
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.semiBold,
      );
}
