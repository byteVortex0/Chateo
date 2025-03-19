import 'package:chateo/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class AssetThemeExtension extends ThemeExtension<AssetThemeExtension> {
  final String? prfile;
  final String? onBoarding;

  const AssetThemeExtension({required this.prfile, required this.onBoarding});

  @override
  ThemeExtension<AssetThemeExtension> copyWith({
    String? prfile,
    String? onBoarding,
  }) {
    return AssetThemeExtension(
      prfile: prfile ?? this.prfile,
      onBoarding: onBoarding ?? this.onBoarding,
    );
  }

  @override
  ThemeExtension<AssetThemeExtension> lerp(
    covariant ThemeExtension<AssetThemeExtension>? other,
    double t,
  ) {
    if (other is! AssetThemeExtension) {
      return this;
    }
    return AssetThemeExtension(
      prfile: other.prfile,
      onBoarding: other.onBoarding,
    );
  }

  static const AssetThemeExtension light = AssetThemeExtension(
    prfile: AppImages.profileLight,
    onBoarding: AppImages.onBoardingLight,
  );
  static const AssetThemeExtension dark = AssetThemeExtension(
    prfile: AppImages.profileDark,
    onBoarding: AppImages.onBoardingDark,
  );
}
