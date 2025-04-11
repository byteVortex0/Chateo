import 'package:chateo/features/conversation/personalChat/ui/widgets/enter_message.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/show_massages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import 'widgets/app_bar_chat.dart';

class PersonalChat extends StatelessWidget {
  const PersonalChat({super.key, required this.user});

  final PersonalInfoModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarChat(user: user),
      body: SafeArea(
        child: Column(
          children: [
            //* Show Massages in List View
            ShowMassages(),
            SizedBox(height: 10.h),
            //* Enter Message
            EnterMessage(user: user),
          ],
        ),
      ),
    );
  }
}
