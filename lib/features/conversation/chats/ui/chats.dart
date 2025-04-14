import 'package:chateo/features/conversation/chats/ui/widgets/chats_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/utils/color_manager.dart';
import 'widgets/story_item.dart';

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
          CustomTextFormField(
            hint: 'Search',
            controller: searchController,
            prefixIcon: Icon(
              Icons.search,
              color: LightColorManager.hintTextField,
            ),
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            padding: EdgeInsets.zero,
          ),
          SizedBox(height: 10.h),
          ChatsList(),
        ],
      ),
    );
  }
}
