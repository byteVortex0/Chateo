import 'package:chateo/core/extensions/context_extension.dart';
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
  const ItemChat({super.key, required this.isMe, required this.chatData});

  final bool isMe;
  final ChatData chatData;

  @override
  State<ItemChat> createState() => _ItemChatState();
}

class _ItemChatState extends State<ItemChat> {
  final String massage = 'Hellof ghfhfh gh';

  final String time = '7:00 PM';

  final GlobalKey _swiperKey = GlobalKey();
  final GlobalKey _containerKey = GlobalKey();

  double _maxWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UpdateWidthCubit>().updateMaxWidth(
        width1: _swiperKey.currentContext?.size?.width ?? 0,
        width2: _containerKey.currentContext?.size?.width ?? 0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.isMe ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DividerDay(),
          BlocBuilder<UpdateWidthCubit, UpdateWidthState>(
            builder: (context, state) {
              if (state is UpdateWidthChanged) {
                _maxWidth = state.maxWidth;
              }
              return Container(
                key: _containerKey,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                width: _maxWidth > 0 ? _maxWidth : null,
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
                    SizedBox(
                      width: _maxWidth > 0 ? _maxWidth : null,
                      child: SwiperMassage(isMe: widget.isMe, key: _swiperKey),
                    ),
                    SizedBox(height: 5.h),
                    massage.length < 30
                        ? MassageOneLine(
                          massage: massage,
                          isMe: widget.isMe,
                          time: time,
                        )
                        : MassageTwoLine(
                          massage: massage,
                          isMe: widget.isMe,
                          time: time,
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
