import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/fonts/style_manager.dart';
import '../../logic/nav_bar/nav_bar_cubit.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.icons,
  });

  final String title;
  final int currentIndex;
  final String icons;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<NavBarCubit>().changeIndex(currentIndex);
          },
          borderRadius: BorderRadius.circular(30),
          highlightColor: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context.read<NavBarCubit>().index == currentIndex
                      ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: StyleManager.black14SemiBold(context),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.color.secondaryColor,
                            ),
                          ),
                        ],
                      )
                      : SvgPicture.asset(icons),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
