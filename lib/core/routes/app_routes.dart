import 'package:chateo/core/routes/base_routes.dart';
import 'package:chateo/features/Auth/loginByPhone/ui/login_by_phone.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/ui/login_profile_info.dart';
import 'package:chateo/features/Auth/loginVerificationOTP/ui/login_verification_otp.dart';
import 'package:chateo/features/Auth/onboarding/ui/onboarding_screen.dart';
import 'package:chateo/features/conversation/main/ui/main_screen.dart';
import 'package:chateo/features/conversation/personalChat/logic/send_massage/send_massage_cubit.dart';
import 'package:chateo/features/conversation/personalChat/ui/personal_chat.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../features/Auth/loginPersonalInfo/logic/add_personal_info/add_personal_info_cubit.dart';
import '../../features/Auth/loginPersonalInfo/logic/upload_images/upload_images_cubit.dart';
import '../../features/conversation/chats/data/model/chat_model.dart';
import '../../features/conversation/contacts/logic/get_all_contacts/get_all_contacts_cubit.dart';
import '../../features/conversation/main/logic/nav_bar/nav_bar_cubit.dart';
import '../../features/conversation/more/logic/get_personal_data/get_personal_data_cubit.dart';
import '../../features/conversation/personalChat/logic/swipe_massege/swipe_massege_cubit.dart';
import '../di/injection.dart';

class AppRoutes {
  static const String onboarding = 'onboarding';
  static const String loginByPhone = 'loginByPhone';
  static const String loginVerificationOTP = 'loginVerificationOTP';
  static const String loginProfileInfo = 'loginProfileInfo';
  static const String mainScreen = 'mainScreen';
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
      case mainScreen:
        return BaseRoutes(
          page: MultiBlocProvider(
            providers: [
              BlocProvider<NavBarCubit>(create: (context) => sl<NavBarCubit>()),
              BlocProvider<GetPersonalDataCubit>(
                create:
                    (context) => sl<GetPersonalDataCubit>()..getPersonalData(),
              ),

              BlocProvider<GetAllContactsCubit>(
                create:
                    (context) => sl<GetAllContactsCubit>()..getAllContacts(),
              ),
            ],
            child: MainScreen(),
          ),
        );
      case personalChat:
        final map = args as Map<String, dynamic>;
        final user = map['user'] as PersonalInfoModel;
        final chat = map['chat'] as ChatModel?;
        return BaseRoutes(
          page: MultiBlocProvider(
            providers: [
              BlocProvider<SendMassageCubit>(
                create: (context) => sl<SendMassageCubit>(),
              ),
              BlocProvider<SwipeMassegeCubit>(
                create: (context) => sl<SwipeMassegeCubit>(),
              ),
            ],
            child: PersonalChat(user: user, chat: chat),
          ),
        );
      default:
        return null;
    }
  }
}
