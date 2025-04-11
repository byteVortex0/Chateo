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
  final Color? senderItemColor;
  final Color? mySwiperMassageColor;
  final Color? yourSwiperMassageColor;
  final Color? yourSwiperContainerColor;
  final Color? yourSwipernameColor;
  final Color? yourSwipertextColor;

  const ColorThemeExtension({
    required this.brandColor,
    required this.neutralColor,
    required this.secondaryColor,
    required this.thirdColor,
    required this.bgTextFieldColor,
    required this.hintTextFieldColor,
    required this.resendCodeColor,
    required this.senderItemColor,
    required this.mySwiperMassageColor,
    required this.yourSwiperMassageColor,
    required this.yourSwiperContainerColor,
    required this.yourSwipernameColor,
    required this.yourSwipertextColor,
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
    Color? senderItemColor,
    Color? mySwiperMassageColor,
    Color? yourSwiperMassageColor,
    Color? yourSwiperContainerColor,
    Color? yourSwipernameColor,
    Color? yourSwipertextColor,
  }) {
    return ColorThemeExtension(
      brandColor: brandColor ?? this.brandColor,
      neutralColor: neutralColor ?? this.neutralColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      bgTextFieldColor: bgTextFieldColor ?? this.bgTextFieldColor,
      hintTextFieldColor: hintTextFieldColor ?? this.hintTextFieldColor,
      resendCodeColor: resendCodeColor ?? this.resendCodeColor,
      thirdColor: thirdColor ?? this.thirdColor,
      senderItemColor: senderItemColor ?? this.senderItemColor,
      mySwiperMassageColor: mySwiperMassageColor ?? this.mySwiperMassageColor,
      yourSwiperMassageColor:
          yourSwiperMassageColor ?? this.yourSwiperMassageColor,
      yourSwiperContainerColor:
          yourSwiperContainerColor ?? this.yourSwiperContainerColor,
      yourSwipernameColor: yourSwipernameColor ?? this.yourSwipernameColor,
      yourSwipertextColor: yourSwipertextColor ?? this.yourSwipertextColor,
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
      senderItemColor: Color.lerp(senderItemColor, other.senderItemColor, t),
      mySwiperMassageColor: Color.lerp(
        mySwiperMassageColor,
        other.mySwiperMassageColor,
        t,
      ),
      yourSwiperMassageColor: Color.lerp(
        yourSwiperMassageColor,
        other.yourSwiperMassageColor,
        t,
      ),
      yourSwiperContainerColor: Color.lerp(
        yourSwiperContainerColor,
        other.yourSwiperContainerColor,
        t,
      ),
      yourSwipernameColor: Color.lerp(
        yourSwipernameColor,
        other.yourSwipernameColor,
        t,
      ),
      yourSwipertextColor: Color.lerp(
        yourSwipertextColor,
        other.yourSwipertextColor,
        t,
      ),
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
    senderItemColor: Colors.white,
    mySwiperMassageColor: LightColorManager.mySwiperMassageLight,
    yourSwiperMassageColor: LightColorManager.dividerColor,
    yourSwiperContainerColor: LightColorManager.brandColorLight,
    yourSwipernameColor: LightColorManager.brandColorLight,
    yourSwipertextColor: LightColorManager.mySwipertextLight,
  );

  static const ColorThemeExtension dark = ColorThemeExtension(
    brandColor: DarkColorManager.brandColorDark,
    neutralColor: Colors.white,
    secondaryColor: Colors.white,
    thirdColor: DarkColorManager.bgDark,
    bgTextFieldColor: DarkColorManager.bgTextFieldDark,
    hintTextFieldColor: DarkColorManager.offWhiteDark,
    resendCodeColor: LightColorManager.offWhite,
    senderItemColor: LightColorManager.neutralLight,
    mySwiperMassageColor: DarkColorManager.mySwiperMassageDark,
    yourSwiperMassageColor: DarkColorManager.bgTextFieldDark,
    yourSwiperContainerColor: LightColorManager.offWhite,
    yourSwipernameColor: LightColorManager.offWhite,
    yourSwipertextColor: LightColorManager.offWhite,
  );
}
