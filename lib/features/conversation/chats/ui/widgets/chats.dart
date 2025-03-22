import 'package:chateo/features/conversation/chats/ui/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_text_field.dart';
import 'story_item.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            //TODO: Change this
            height: 60.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => StoryItem(),
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
            ),
          ),
          SizedBox(height: 10.h),
          Divider(),
          SizedBox(height: 10.h),
          CustomTextField(hint: 'Search', controller: searchController),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.separated(
              itemCount: 20,
              itemBuilder: (context, index) => ChatItem(),
              separatorBuilder: (context, index) => SizedBox(height: 10.w),
            ),
          ),
        ],
      ),
    );
  }
}
