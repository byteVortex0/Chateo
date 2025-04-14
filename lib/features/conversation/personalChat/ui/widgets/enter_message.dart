import 'dart:developer';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_text_field.dart';
import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../../chats/data/model/chat_model.dart';
import '../../logic/send_massage/send_massage_cubit.dart';

class EnterMessage extends StatefulWidget {
  const EnterMessage({super.key, required this.user});

  final PersonalInfoModel user;

  @override
  State<EnterMessage> createState() => _EnterMessageState();
}

class _EnterMessageState extends State<EnterMessage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.thirdColor,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              hint: 'Write a message',
              controller: _messageController,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              maxLines: 4,
            ),
          ),
          SizedBox(width: 10.w),
          BlocBuilder<SendMassageCubit, SendMassageState>(
            builder: (context, state) {
              String userId = SharedPref.getValue(PrefKey.userId);
              return IconButton(
                onPressed: () {
                  context.read<SendMassageCubit>().sendMassage(
                    chat: ChatModel(
                      users: Users(user1Id: userId, user2Id: widget.user.id!),
                      chatData: [
                        ChatData(
                          senderId: userId,
                          content: _messageController.text,
                          sendAt: DateTime.now(),
                          isSeen: false,
                          swipperMessageId: '',
                        ),
                      ],
                      lastMessageTime: DateTime.now(),
                      lastMessage: _messageController.text,
                    ),
                  );
                  _messageController.clear();
                  log('send');
                },
                icon: Icon(Icons.send, color: context.color.brandColor),
              );
            },
          ),
        ],
      ),
    );
  }
}
