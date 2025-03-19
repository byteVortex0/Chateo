part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ChangeThemeMode extends ThemeState {
  final bool isDark;

  ChangeThemeMode({required this.isDark});
}
