import 'package:chateo/core/app/theme_cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> setupInjection() async {
  await _initCore();
}

Future<void> _initCore() async {
  sl.registerFactory<ThemeCubit>(ThemeCubit.new);
}
