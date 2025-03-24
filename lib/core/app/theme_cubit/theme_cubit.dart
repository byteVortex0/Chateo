import 'package:bloc/bloc.dart';
import 'package:chateo/core/service/shared_pref/pref_key.dart';
import 'package:flutter/foundation.dart';

import '../../service/shared_pref/shared_pref.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final savedTheme = await SharedPref.getValue(PrefKey.isDark) as bool?;
    final defaultTheme =
        PlatformDispatcher.instance.platformBrightness == Brightness.dark;

    emit(ChangeThemeMode(isDark: savedTheme ?? defaultTheme));
  }

  Future<void> changeThemeMode({bool? sharedMode}) async {
    final newMode = sharedMode ?? !isDark;
    await SharedPref.setValue(PrefKey.isDark, newMode);
    emit(ChangeThemeMode(isDark: newMode));
  }

  bool get isDark =>
      state is ChangeThemeMode && (state as ChangeThemeMode).isDark;
}
