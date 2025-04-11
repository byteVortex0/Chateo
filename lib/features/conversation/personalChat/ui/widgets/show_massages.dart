import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/item_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/fonts/style_manager.dart';
import '../../logic/get_all_messages/get_all_messages_cubit.dart';

class ShowMassages extends StatelessWidget {
  const ShowMassages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllMessagesCubit, GetAllMessagesState>(
      builder: (context, state) {
        if (state is GetAllMessagesSuccess) {
          return StreamBuilder<List<dynamic>>(
            stream: context.read<GetAllMessagesCubit>().getAllMessages(
              chatId: state.chat.id!,
            ),
            builder: (context, snapshot) {
              return Expanded(
                child: Container(
                  color: context.color.bgTextFieldColor,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                    itemBuilder: (context, index) {
                      final isMe = false;
                      return ItemChat(
                        isMe: isMe,
                        chatData: state.chat.chatData[index],
                      );
                    },
                    separatorBuilder:
                        (context, index) => SizedBox(height: 10.h),
                    itemCount: 1,
                  ),
                ),
              );
            },
          );
        }
        if (state is GetAllMessagesLoading) {
          return Expanded(
            child: Container(
              color: context.color.bgTextFieldColor,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (state is GetAllMessagesError) {
          return Expanded(
            child: Container(
              color: context.color.bgTextFieldColor,
              child: Center(
                child: Text(
                  'Failed to load messages: ${state.error}',
                  style: StyleManager.neutral10Regular(context),
                ),
              ),
            ),
          );
        }
        if (state is GetAllMessagesEmpty) {
          return Expanded(
            child: Container(
              color: context.color.bgTextFieldColor,
              child: const Center(child: Text('No messages yet')),
            ),
          );
        }
        return Expanded(child: SizedBox());
      },
    );
  }
}
