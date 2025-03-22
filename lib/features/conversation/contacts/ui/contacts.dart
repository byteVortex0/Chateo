import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../../chats/ui/widgets/chat_item.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(hint: 'Search', controller: TextEditingController()),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) => ChatItem(),
              separatorBuilder: (context, index) => SizedBox(height: 10.w),
            ),
          ),
        ],
      ),
    );
  }
}
