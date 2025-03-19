import 'package:chateo/core/utils/theme/asset_theme_extensions.dart';
import 'package:chateo/core/utils/theme/color_theme_extension.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // for images
  AssetThemeExtension get asset =>
      Theme.of(this).extension<AssetThemeExtension>()!;

  // for colors
  ColorThemeExtension get color =>
      Theme.of(this).extension<ColorThemeExtension>()!;

  //Navigator
  void pop() => Navigator.of(this).pop();

  Future<dynamic> pushNamed(String routeName) =>
      Navigator.of(this).pushNamed(routeName);

  Future<dynamic> pushReplacementNamed(String routeName) =>
      Navigator.of(this).pushReplacementNamed(routeName);

  Future<dynamic> pushNamedAndRemoveUntil(String routeName) =>
      Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false);
}
