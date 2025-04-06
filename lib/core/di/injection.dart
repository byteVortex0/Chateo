import 'package:chateo/core/app/theme_cubit/theme_cubit.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/logic/add_personal_info/add_personal_info_cubit.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/logic/upload_images/upload_images_cubit.dart';
import 'package:chateo/features/Auth/loginVerificationOTP/logic/verify_otp/verify_otp_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/Auth/loginByPhone/logic/login_by_phone/login_by_phone_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> setupInjection() async {
  await _initCore();
  await _loginByPhone();
  await _loginProfileInfo();
}

Future<void> _initCore() async {
  sl.registerFactory<ThemeCubit>(ThemeCubit.new);
}

Future<void> _loginByPhone() async {
  sl.registerFactory<LoginByPhoneCubit>(LoginByPhoneCubit.new);
  sl.registerFactory<VerifyOtpCubit>(VerifyOtpCubit.new);
}

Future<void> _loginProfileInfo() async {
  sl.registerFactory<AddPersonalInfoCubit>(AddPersonalInfoCubit.new);
  sl.registerFactory<UploadImagesCubit>(UploadImagesCubit.new);
}
