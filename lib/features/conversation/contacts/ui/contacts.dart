import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/common/widgets/custom_list_item.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextFormField(
            hint: 'Search',
            controller: TextEditingController(),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 30.h),
              itemCount: 10,
              itemBuilder: (context, index) => CustomListItem(),
              separatorBuilder: (context, index) => SizedBox(height: 10.w),
            ),
          ),
        ],
      ),
    );
  }
}
