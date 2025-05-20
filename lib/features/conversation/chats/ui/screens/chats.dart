import 'package:chateo/features/conversation/chats/ui/widgets/chats_list.dart';
import 'package:chateo/features/conversation/chats/ui/widgets/story_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_text_field.dart';
import '../../../../../core/utils/color_manager.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> searchTextNotifier = ValueNotifier('');

  @override
  void dispose() {
    searchController.dispose();
    searchTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 60.h, child: StoryList()),
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
            onChanged: (value) {
              searchTextNotifier.value = value?.toLowerCase().trim() ?? '';
              return null;
            },
          ),
          SizedBox(height: 10.h),

          ValueListenableBuilder<String>(
            valueListenable: searchTextNotifier,
            builder: (context, value, _) {
              return ChatsList(searchText: value);
            },
          ),
        ],
      ),
    );
  }
}
