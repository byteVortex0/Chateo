import 'package:chateo/core/utils/color_manager.dart';
import 'package:chateo/core/utils/theme/asset_theme_extensions.dart';
import 'package:chateo/core/utils/theme/color_theme_extension.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    extensions: const <ThemeExtension<dynamic>>[
      ColorThemeExtension.light,
      AssetThemeExtension.light,
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    // textTheme: TextTheme(
    //   headlineSmall: GoogleFonts.mulish(
    //     fontSize: 24.sp,
    //     fontWeight: FontWeight.w800,
    //     color: LightColorManager.brandColorLight,
    //   ),
    // ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: DarkColorManager.bgDark,
    extensions: const <ThemeExtension<dynamic>>[
      ColorThemeExtension.dark,
      AssetThemeExtension.dark,
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: DarkColorManager.bgDark,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    // textTheme: TextTheme(
    //   headlineSmall: GoogleFonts.mulish(
    //     fontSize: 24.sp,
    //     fontWeight: FontWeight.w800,
    //     color: DarkColorManager.brandColorDark,
    //   ),
    // ),
  );
}

/// | NAME           | SIZE |  WEIGHT |  SPACING |             |
/// |----------------|------|---------|----------|-------------|
/// | displayLarge   | 96.0 | light   | -1.5     |             |
/// | displayMedium  | 60.0 | light   | -0.5     |             |
/// | displaySmall   | 48.0 | regular |  0.0     |             |
/// | headlineMedium | 34.0 | regular |  0.25    |             |
/// | headlineSmall  | 24.0 | regular |  0.0     |             |
/// | titleLarge     | 20.0 | medium  |  0.15    |             |
/// | titleMedium    | 16.0 | regular |  0.15    |             |
/// | titleSmall     | 14.0 | medium  |  0.1     |             |
/// | bodyLarge      | 16.0 | regular |  0.5     |             |
/// | bodyMedium     | 14.0 | regular |  0.25    |             |
/// | bodySmall      | 12.0 | regular |  0.4     |             |
/// | labelLarge     | 14.0 | medium  |  1.25    |             |
/// | labelSmall     | 10.0 | regular |  1.5     |             |
