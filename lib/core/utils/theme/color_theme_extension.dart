import 'package:chateo/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  final Color? brandColor;
  final Color? neutralColor;
  final Color? secondaryColor;

  const ColorThemeExtension({
    required this.brandColor,
    required this.neutralColor,
    required this.secondaryColor,
  });

  @override
  ThemeExtension<ColorThemeExtension> copyWith({
    Color? brandColor,
    Color? neutralColor,
    Color? secondaryColor,
  }) {
    return ColorThemeExtension(
      brandColor: brandColor ?? this.brandColor,
      neutralColor: neutralColor ?? this.neutralColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
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
    );
  }

  static const ColorThemeExtension light = ColorThemeExtension(
    brandColor: LightColorManager.brandColorLight,
    neutralColor: LightColorManager.neutralLight,
    secondaryColor: Colors.black,
  );

  static const ColorThemeExtension dark = ColorThemeExtension(
    brandColor: DarkColorManager.brandColorDark,
    neutralColor: Colors.white,
    secondaryColor: Colors.white,
  );
}
