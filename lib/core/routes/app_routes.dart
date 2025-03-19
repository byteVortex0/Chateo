import 'package:chateo/core/routes/base_routes.dart';
import 'package:chateo/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static const String onboarding = 'onboarding';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return BaseRoutes(page: OnBoardingScreen());
      default:
        return null;
    }
  }
}
