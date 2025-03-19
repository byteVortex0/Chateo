import 'package:chateo/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: DarkColorManager.primary,
  );
}
