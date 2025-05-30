import 'package:chateo/core/app/theme_cubit/theme_cubit.dart';
import 'package:chateo/core/di/injection.dart';
import 'package:chateo/core/routes/app_routes.dart';
import 'package:chateo/core/service/shared_pref/shared_pref.dart';
import 'package:chateo/core/utils/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/service/shared_pref/pref_key.dart';

class Chateo extends StatelessWidget {
  const Chateo({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => child!,
      child: BlocProvider(
        create: (BuildContext context) => sl<ThemeCubit>(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Chateo',
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeManager.darkTheme,
              theme: ThemeManager.lightTheme,
              themeMode:
                  context.read<ThemeCubit>().isDark
                      ? ThemeMode.dark
                      : ThemeMode.light,
              initialRoute:
                  SharedPref.getValue(PrefKey.isLoggedIn) == true
                      ? AppRoutes.mainScreen
                      : AppRoutes.onboarding,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              navigatorKey: sl<GlobalKey<NavigatorState>>(),
            );
          },
        ),
      ),
    );
  }
}
