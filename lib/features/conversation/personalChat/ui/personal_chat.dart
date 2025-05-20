import 'package:chateo/core/app/constanst.dart';
import 'package:chateo/core/service/push_notification/local_notification.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/enter_message.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/show_massages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../chats/data/model/chat_model.dart';
import 'widgets/app_bar_chat.dart';

class PersonalChat extends StatefulWidget {
  const PersonalChat({super.key, required this.user, this.chat});

  final PersonalInfoModel user;
  final ChatModel? chat;

  @override
  State<PersonalChat> createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  @override
  void initState() {
    super.initState();
    if (widget.chat != null) {
      currentChatId = widget.chat!.id!;
      LocalNotification.chatMessages.remove(widget.chat!.id!);
      LocalNotification.cancelNotification(widget.chat!.id!.hashCode);
    }
  }

  @override
  void dispose() {
    currentChatId = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarChat(user: widget.user),
      body: SafeArea(
        child: Column(
          children: [
            //* Show Massages in List View
            ShowMassages(chat: widget.chat, user: widget.user),
            SizedBox(height: 10.h),
            //* Enter Message
            EnterMessage(user: widget.user),
          ],
        ),
      ),
    );
  }
}
