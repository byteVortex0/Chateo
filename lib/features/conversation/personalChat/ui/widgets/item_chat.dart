import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/extensions/date_extension.dart';
import 'package:chateo/features/conversation/chats/data/model/chat_model.dart';
import 'package:chateo/features/conversation/personalChat/logic/swipe_massege/swipe_massege_cubit.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/divider_day.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/swiper_massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import 'massage_one_line.dart';
import 'massage_two_line.dart';

class ItemChat extends StatefulWidget {
  const ItemChat({
    super.key,
    required this.isMe,
    required this.chatData,
    this.swiperMessage,
    required this.index,
    required this.showDivider,
    required this.user,
  });

  final bool isMe;
  final ChatData chatData;
  final ChatData? swiperMessage;
  final bool showDivider;
  final int index;
  final PersonalInfoModel user;

  @override
  State<ItemChat> createState() => _ItemChatState();
}

class _ItemChatState extends State<ItemChat> {
  double _dragOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.isMe ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* show divider
          widget.showDivider
              ? DividerDay(time: widget.chatData.sendAt.dateOfDivider)
              : const SizedBox.shrink(),

          //* message
          IntrinsicWidth(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragOffset += details.delta.dx;
                  if (_dragOffset < 0) _dragOffset = 0;
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragOffset > 100) {
                  context.read<SwipeMassegeCubit>().onSwipe(
                    chatData: widget.chatData,
                  );
                }
                setState(() {
                  _dragOffset = 0;
                });
              },
              child: Transform.translate(
                offset: Offset(_dragOffset, 0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  margin:
                      widget.isMe
                          ? EdgeInsets.only(left: 70.w, right: 10.w)
                          : EdgeInsets.only(left: 10.w, right: 70.w),

                  decoration: BoxDecoration(
                    color:
                        widget.isMe
                            ? context.color.brandColor
                            : context.color.senderItemColor,
                    borderRadius:
                        widget.isMe
                            ? BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            )
                            : BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      widget.swiperMessage != null
                          ? SwiperMassage(
                            isMe: widget.isMe,
                            chatData: widget.swiperMessage!,
                            user: widget.user,
                          )
                          : SizedBox.shrink(),
                      SizedBox(height: 5.h),
                      widget.chatData.content!.length < 25
                          ? MassageOneLine(
                            massage: widget.chatData.content!,
                            isMe: widget.isMe,
                            time: widget.chatData.sendAt.formattedTime,
                            isSeen: widget.chatData.isSeen,
                          )
                          : MassageTwoLine(
                            massage: widget.chatData.content!,
                            isMe: widget.isMe,
                            time: widget.chatData.sendAt.formattedTime,
                            isSeen: widget.chatData.isSeen,
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
