import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_list_item.dart';
import '../../../../../core/common/widgets/loading_shimmer.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/fonts/style_manager.dart';
import '../../logic/controller/get_all_chats_controller.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key, required this.searchText});

  final String? searchText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: GetAllChatsController().getAllChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
              padding: EdgeInsets.only(bottom: 30.h),
              itemCount: 10,
              itemBuilder: (context, index) => const LoadingShimmer(),
              separatorBuilder: (context, index) => SizedBox(height: 10.w),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No chats yet',
                style: StyleManager.black18SemiBold(context),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error fetching chats',
                style: StyleManager.black18SemiBold(context),
              ),
            );
          }

          final allChats = snapshot.data!;

          final filteredChats =
              searchText == null && searchText!.isEmpty
                  ? allChats
                  : allChats.where((chat) {
                    final personalInfo = chat['personalInfo'];
                    final fullName =
                        '${personalInfo.firstName} ${personalInfo.lastName}'
                            .toLowerCase();
                    return fullName.contains(searchText!);
                  }).toList();

          return ListView.separated(
            padding: EdgeInsets.only(bottom: 30.h),
            itemCount: filteredChats.length,
            itemBuilder: (context, index) {
              final chat = filteredChats[index]['chat'];
              final personalInfo = filteredChats[index]['personalInfo'];
              final unRead = filteredChats[index]['unread'];

              return CustomListItem(
                name: '${personalInfo.firstName} ${personalInfo.lastName}',
                imageUrl: personalInfo.imageUrl,
                phoneNumber: personalInfo.phoneNumber,
                massage: chat.lastMessage,
                timeMassage:
                    (chat.lastMessageTime as DateTime).timeOrDateofMessage,
                messagesNotRead: unRead[index],
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.personalChat,
                    arguments: {'user': personalInfo, 'chat': chat},
                  );
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10.w),
          );
        },
      ),
    );
  }
}
