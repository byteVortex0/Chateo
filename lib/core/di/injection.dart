import 'package:chateo/core/app/theme_cubit/theme_cubit.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/logic/add_personal_info/add_personal_info_cubit.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/logic/upload_images/upload_images_cubit.dart';
import 'package:chateo/features/Auth/loginVerificationOTP/logic/verify_otp/verify_otp_cubit.dart';
import 'package:chateo/features/conversation/more/logic/get_personal_data/get_personal_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/Auth/loginByPhone/logic/login_by_phone/login_by_phone_cubit.dart';
import '../../features/conversation/add_story/logic/add_story/add_story_cubit.dart';
import '../../features/conversation/contacts/logic/get_all_contacts/get_all_contacts_cubit.dart';
import '../../features/conversation/main/logic/nav_bar/nav_bar_cubit.dart';
import '../../features/conversation/personalChat/logic/send_massage/send_massage_cubit.dart';
import '../../features/conversation/personalChat/logic/swipe_massege/swipe_massege_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> setupInjection() async {
  await _initCore();
  await _loginByPhone();
  await _loginProfileInfo();
  await _initConversation();
}

Future<void> _initCore() async {
  final navigationKey = GlobalKey<NavigatorState>();

  sl
    ..registerFactory<ThemeCubit>(ThemeCubit.new)
    ..registerSingleton<GlobalKey<NavigatorState>>(navigationKey);
}

Future<void> _loginByPhone() async {
  sl.registerFactory<LoginByPhoneCubit>(LoginByPhoneCubit.new);
  sl.registerFactory<VerifyOtpCubit>(VerifyOtpCubit.new);
}

Future<void> _loginProfileInfo() async {
  sl.registerFactory<AddPersonalInfoCubit>(AddPersonalInfoCubit.new);
  sl.registerFactory<UploadImagesCubit>(UploadImagesCubit.new);
}

Future<void> _initConversation() async {
  sl
    ..registerFactory<NavBarCubit>(NavBarCubit.new)
    ..registerFactory<GetPersonalDataCubit>(GetPersonalDataCubit.new)
    ..registerFactory<GetAllContactsCubit>(GetAllContactsCubit.new)
    ..registerFactory<SendMassageCubit>(SendMassageCubit.new)
    ..registerFactory<SwipeMassegeCubit>(SwipeMassegeCubit.new)
    ..registerFactory<AddStoryCubit>(AddStoryCubit.new);
}
