import 'package:chateo/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class StyleManager {
  static const TextStyle black24Bold = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle white16SemiBold = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle secondary14SemiBold = TextStyle(
    color: LightColorManager.secondary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}
