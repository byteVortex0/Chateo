import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoryShimmer extends StatelessWidget {
  const StoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    //create a shimmer effect for the story item
    return Column(
      children: [
        Container(
          height: 40.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 7.w),
        Container(
          height: 10.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
