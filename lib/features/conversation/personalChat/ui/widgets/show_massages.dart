import 'dart:developer';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/extensions/date_extension.dart';
import 'package:chateo/features/conversation/personalChat/logic/controller/stream_messages.dart';
import 'package:chateo/features/conversation/personalChat/logic/send_massage/send_massage_cubit.dart';
import 'package:chateo/features/conversation/personalChat/ui/widgets/item_chat.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../../../../core/utils/fonts/style_manager.dart';
import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../../chats/data/model/chat_model.dart';
import 'shimmer_message.dart';

class ShowMassages extends StatefulWidget {
  const ShowMassages({super.key, this.chat, required this.user});

  final ChatModel? chat;
  final PersonalInfoModel user;

  @override
  State<ShowMassages> createState() => _ShowMassagesState();
}

class _ShowMassagesState extends State<ShowMassages> {
  final ScrollController _scrollController = ScrollController();
  final supabase = Supabase.instance.client;
  String? chatId;
  bool isLoading = true;
  bool? noChatYet;

  @override
  void initState() {
    super.initState();
    checkExistingChat();
  }

  Future<void> checkExistingChat() async {
    if (widget.chat == null) {
      final response =
          await supabase
              .from('chats')
              .select('id, users')
              .or(
                'users->>user1_id.eq.${widget.user.id!},users->>user2_id.eq.${widget.user.id!}',
              )
              .maybeSingle();

      if (response != null) {
        chatId = response['id'];

        log('chatId: $chatId');
        noChatYet = false;
      } else {
        noChatYet = true;
      }
    } else {
      chatId = widget.chat!.id;
      log('chatId (from widget): $chatId');
      noChatYet = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add a slight delay to ensure the layout is complete
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          // log('offset: ${_scrollController.offset}');
          // log('maxScrollExtent: ${_scrollController.position.maxScrollExtent}');
        } else {
          log('ScrollController has no clients');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return chatId != null
        ? getMessagesStream(chatId!)
        : BlocBuilder<SendMassageCubit, SendMassageState>(
          builder: (context, state) {
            if (state is SendMassageSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  chatId = state.chatId;
                  isLoading = false;
                });
              });
            }
            if (state is SendMassageError) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Error fetching messages',
                    style: StyleManager.black18SemiBold(context),
                  ),
                ),
              );
            }

            if (noChatYet == true) {
              return Expanded(
                child: Center(
                  child: Text(
                    'No messages yet in this chat',
                    style: StyleManager.black18SemiBold(context),
                  ),
                ),
              );
            }
            return Expanded(child: Container());
          },
        );
  }

  StreamBuilder<List<ChatData>> getMessagesStream(String id) {
    return StreamBuilder<List<ChatData>>(
      stream: StreamMessages().streamMessages(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && isLoading) {
          return Expanded(
            child: Container(
              color: context.color.bgTextFieldColor,
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 20.h),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: 10,
                itemBuilder: (context, index) => const ShimmerMessage(),
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Expanded(
            child: Center(
              child: Text(
                'No messages yet in this chat',
                style: StyleManager.black18SemiBold(context),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Text(
                'Error fetching messages',
                style: StyleManager.black18SemiBold(context),
              ),
            ),
          );
        }

        final messages = snapshot.data!;
        final userId = SharedPref.getValue(PrefKey.userId);

        scrollToBottom();

        return Expanded(
          child: Container(
            height: double.infinity,
            color: context.color.bgTextFieldColor,
            child: ListView.separated(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
              itemBuilder: (context, index) {
                final isMe = messages[index].senderId == userId;
                final bool showDivider;
                if (index == 0) {
                  showDivider = true;
                } else {
                  if (messages[index].sendAt.formattedDate ==
                      messages[index - 1].sendAt.formattedDate) {
                    showDivider = false;
                  } else {
                    showDivider = true;
                  }
                }

                ChatData? swiperMessage;
                if (messages[index].swipperMessageId != null) {
                  swiperMessage = messages.firstWhereOrNull(
                    (msg) => msg.messageId == messages[index].swipperMessageId,
                  );
                }

                return ItemChat(
                  isMe: isMe,
                  chatData: messages[index],
                  index: index,
                  showDivider: showDivider,
                  swiperMessage: swiperMessage,
                  user: widget.user,
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: messages.length,
            ),
          ),
        );
      },
    );
  }
}
