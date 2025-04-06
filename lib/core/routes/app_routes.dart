import 'package:chateo/core/routes/base_routes.dart';
import 'package:chateo/features/Auth/loginByPhone/ui/login_by_phone.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/ui/login_profile_info.dart';
import 'package:chateo/features/Auth/loginVerificationOTP/ui/login_verification_otp.dart';
import 'package:chateo/features/Auth/onboarding/ui/onboarding_screen.dart';
import 'package:chateo/features/conversation/chats/ui/chats_screen.dart';
import 'package:chateo/features/conversation/personalChat/ui/personal_chat.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Auth/loginPersonalInfo/logic/add_personal_info/add_personal_info_cubit.dart';
import '../../features/Auth/loginPersonalInfo/logic/upload_images/upload_images_cubit.dart';
import '../di/injection.dart';

class AppRoutes {
  static const String onboarding = 'onboarding';
  static const String loginByPhone = 'loginByPhone';
  static const String loginVerificationOTP = 'loginVerificationOTP';
  static const String loginProfileInfo = 'loginProfileInfo';
  static const String chatsScreen = 'chats';
  static const String personalChat = 'personalChat';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case onboarding:
        return BaseRoutes(page: OnBoardingScreen());
      case loginByPhone:
        return BaseRoutes(page: LoginByPhone());
      case loginVerificationOTP:
        return BaseRoutes(
          page: LoginVerificationOTP(
            verificationId: (args as Map<String, String>)['verificationId']!,
            phoneNumber: args['phoneNumber']!,
          ),
        );
      case loginProfileInfo:
        return BaseRoutes(
          page: MultiBlocProvider(
            providers: [
              BlocProvider<AddPersonalInfoCubit>(
                create: (context) => sl<AddPersonalInfoCubit>(),
              ),
              BlocProvider<UploadImagesCubit>(
                create: (context) => sl<UploadImagesCubit>(),
              ),
            ],
            child: LoginProfileInfo(phoneNumber: args as String),
          ),
        );
      case chatsScreen:
        return BaseRoutes(page: ChatsScreen());
      case personalChat:
        return BaseRoutes(page: PersonalChat());
      default:
        return null;
    }
  }
}
