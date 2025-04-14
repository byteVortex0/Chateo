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
  const ChatsList({super.key});

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

          final chats = snapshot.data!;

          return ListView.separated(
            padding: EdgeInsets.only(bottom: 30.h),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index]['chat'];
              final personalInfo = chats[index]['personalInfo'];

              // final personalInfo = PersonalInfoModel(
              //   id: '959acdfd-528e-4fc9-a3ae-d3a9808b086b',
              //   firstName: 'Mahmoud',
              //   lastName: 'Ahmed',
              //   imageUrl:
              //       'https://ocebphmquteghqmnphiq.supabase.co/storage/v1/object/public/images/images/1743927508595.jpg',
              //   phoneNumber: '01023456789',
              // );

              final now = DateTime.now();
              final String time;
              if ((chat.lastMessageTime as DateTime).formattedDate ==
                  now.formattedDate) {
                time = (chat.lastMessageTime as DateTime).formattedTime;
              } else if ((chat.lastMessageTime as DateTime).formattedDate ==
                  DateTime(now.year, now.month, now.day - 1).formattedDate) {
                time = 'Yesterday';
              } else {
                time = (chat.lastMessageTime as DateTime).formattedDate;
              }
              return CustomListItem(
                name: '${personalInfo.firstName} ${personalInfo.lastName}',
                imageUrl: personalInfo.imageUrl,
                phoneNumber: personalInfo.phoneNumber,
                massage: chat.lastMessage,
                timeMassage: time,
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
