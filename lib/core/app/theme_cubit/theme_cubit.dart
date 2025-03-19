import 'package:bloc/bloc.dart';
import 'package:chateo/core/service/shared_pref/pref_key.dart';
import 'package:flutter/foundation.dart';

import '../../service/shared_pref/shared_pref.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  bool isDark =
      PlatformDispatcher.instance.platformBrightness == Brightness.dark;

  Future<void> changeThemeMode({bool? sharedMode}) async {
    if (sharedMode != null) {
      isDark = sharedMode;
    } else {
      isDark = !isDark;
      await SharedPref.setValue(PrefKey.isDark, isDark);
    }
    emit(ChangeThemeMode(isDark: isDark));
  }
}
