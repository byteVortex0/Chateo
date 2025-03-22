import 'package:chateo/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  final Color? brandColor;
  final Color? neutralColor;
  final Color? secondaryColor;
  final Color? thirdColor;
  final Color? bgTextFieldColor;
  final Color? hintTextFieldColor;
  final Color? resendCodeColor;

  const ColorThemeExtension({
    required this.brandColor,
    required this.neutralColor,
    required this.secondaryColor,
    required this.thirdColor,
    required this.bgTextFieldColor,
    required this.hintTextFieldColor,
    required this.resendCodeColor,
  });

  @override
  ThemeExtension<ColorThemeExtension> copyWith({
    Color? brandColor,
    Color? neutralColor,
    Color? secondaryColor,
    Color? thirdColor,
    Color? bgTextFieldColor,
    Color? hintTextFieldColor,
    Color? resendCodeColor,
  }) {
    return ColorThemeExtension(
      brandColor: brandColor ?? this.brandColor,
      neutralColor: neutralColor ?? this.neutralColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      bgTextFieldColor: bgTextFieldColor ?? this.bgTextFieldColor,
      hintTextFieldColor: hintTextFieldColor ?? this.hintTextFieldColor,
      resendCodeColor: resendCodeColor ?? this.resendCodeColor,
      thirdColor: thirdColor ?? this.thirdColor,
    );
  }

  @override
  ThemeExtension<ColorThemeExtension> lerp(
    covariant ThemeExtension<ColorThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorThemeExtension) {
      return this;
    }
    return ColorThemeExtension(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t),
      secondaryColor: Color.lerp(neutralColor, other.neutralColor, t),
      thirdColor: Color.lerp(neutralColor, other.neutralColor, t),
      bgTextFieldColor: Color.lerp(bgTextFieldColor, other.bgTextFieldColor, t),
      hintTextFieldColor: Color.lerp(
        hintTextFieldColor,
        other.hintTextFieldColor,
        t,
      ),
      resendCodeColor: Color.lerp(resendCodeColor, other.resendCodeColor, t),
    );
  }

  static const ColorThemeExtension light = ColorThemeExtension(
    brandColor: LightColorManager.brandColorLight,
    neutralColor: LightColorManager.neutralLight,
    secondaryColor: Colors.black,
    thirdColor: Colors.white,
    bgTextFieldColor: LightColorManager.offWhite,
    hintTextFieldColor: LightColorManager.hintTextField,
    resendCodeColor: LightColorManager.brandColorLight,
  );

  static const ColorThemeExtension dark = ColorThemeExtension(
    brandColor: DarkColorManager.brandColorDark,
    neutralColor: Colors.white,
    secondaryColor: Colors.white,
    thirdColor: DarkColorManager.bgDark,
    bgTextFieldColor: DarkColorManager.bgTextFieldDark,
    hintTextFieldColor: DarkColorManager.offWhiteDark,
    resendCodeColor: LightColorManager.offWhite,
  );
}
