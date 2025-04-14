import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/extensions/date_extension.dart';
import 'package:chateo/features/conversation/chats/data/model/chat_model.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/divider_day.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/swiper_massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/update_width/update_width_cubit.dart';
import 'massage_one_line.dart';
import 'massage_two_line.dart';

class ItemChat extends StatefulWidget {
  const ItemChat({
    super.key,
    required this.isMe,
    required this.chatData,
    required this.index,
    required this.showDivider,
  });

  final bool isMe;
  final ChatData chatData;
  final bool showDivider;
  final int index;

  @override
  State<ItemChat> createState() => _ItemChatState();
}

class _ItemChatState extends State<ItemChat> {
  final GlobalKey _swiperKey = GlobalKey();
  // final GlobalKey _containerKey = GlobalKey();

  double _maxWidth = 0;

  List<double> messageWidths = [];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // عندما يتم عرض الرسالة أولاً، نقوم بحساب الأبعاد
    //   final currentWidth = _containerKey.currentContext?.size?.width ?? 0;
    //   if (messageWidths.length <= widget.index) {
    //     messageWidths.add(currentWidth);
    //   } else {
    //     messageWidths[widget.index] = currentWidth;
    //   }

    //   // تحديث الـ Cubit بأبعاد الرسالة الحالية
    //   context.read<UpdateWidthCubit>().updateMaxWidth(
    //     width1: messageWidths[widget.index],
    //     width2: _swiperKey.currentContext?.size?.width ?? 0,
    //   );
    // });
  }

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
          BlocBuilder<UpdateWidthCubit, UpdateWidthState>(
            builder: (context, state) {
              if (state is UpdateWidthChanged) {
                _maxWidth = state.maxWidth;
              }

              return Container(
                // key: _containerKey,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                margin:
                    widget.isMe
                        ? EdgeInsets.only(left: 70.w, right: 10.w)
                        : EdgeInsets.only(left: 10.w, right: 70.w),

                // width: _maxWidth > 0 ? _maxWidth : null,
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
                  children: [
                    widget.chatData.swipperMessageId!.isNotEmpty
                        ? SizedBox(
                          width: _maxWidth > 0 ? _maxWidth : null,
                          child: SwiperMassage(
                            isMe: widget.isMe,
                            key: _swiperKey,
                          ),
                        )
                        : SizedBox.shrink(),
                    SizedBox(height: 5.h),
                    widget.chatData.content!.length < 30
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
              );
            },
          ),
        ],
      ),
    );
  }
}
