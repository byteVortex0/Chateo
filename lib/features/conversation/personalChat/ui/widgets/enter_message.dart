import 'dart:developer';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/features/conversation/personalChat/logic/swipe_massege/swipe_massege_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_text_field.dart';
import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../../../../core/utils/fonts/font_weight_helper.dart';
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

  String? messageId;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeMassegeCubit, SwipeMassegeState>(
      builder: (context, state) {
        if (state is SwipeMassegeSuccess) {
          return Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: context.color.thirdColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                replyContainer(context, state),
                SizedBox(height: 5.h),
                mainContainer(context),
              ],
            ),
          );
        }
        return mainContainer(context);
      },
    );
  }

  Container replyContainer(BuildContext context, SwipeMassegeSuccess state) {
    final name =
        state.chatData.senderId == widget.user.id
            ? '${widget.user.firstName} ${widget.user.lastName}'
            : 'You';
    messageId = state.chatData.messageId;
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsetsDirectional.only(start: 8.w, end: 8.w),
      decoration: BoxDecoration(
        color: context.color.yourSwiperContainerColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.r),
          topLeft: Radius.circular(10.r),
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.color.yourSwiperMassageColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.r),
            // topLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        margin: EdgeInsetsDirectional.only(start: 8.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: context.color.yourSwipernameColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${state.chatData.content}',
                    style: TextStyle(
                      color: context.color.yourSwipertextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<SwipeMassegeCubit>().onSwipeCancel();
              },
              icon: Icon(Icons.clear),
            ),
          ],
        ),
      ),
    );
  }

  Container mainContainer(BuildContext context) {
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
                          swipperMessageId: messageId ?? '',
                        ),
                      ],
                      lastMessageTime: DateTime.now(),
                      lastMessage: _messageController.text,
                    ),
                    user: widget.user,
                  );
                  _messageController.clear();
                  context.read<SwipeMassegeCubit>().onSwipeCancel();
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
