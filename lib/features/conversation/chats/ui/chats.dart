import 'package:chateo/core/common/widgets/custom_list_item.dart';
import 'package:chateo/features/conversation/chats/logic/get_all_chats/get_all_chats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/common/widgets/loading_shimmer.dart';
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
          Expanded(
            child: BlocBuilder<GetAllChatsCubit, GetAllChatsState>(
              builder: (context, state) {
                if (state is GetAllChatsLoading) {
                  return ListView.separated(
                    padding: EdgeInsets.only(bottom: 30.h),
                    itemCount: 10,
                    itemBuilder: (context, index) => const LoadingShimmer(),
                    separatorBuilder:
                        (context, index) => SizedBox(height: 10.w),
                  );
                }
                if (state is GetAllChatsSuccess) {
                  return ListView.separated(
                    padding: EdgeInsets.only(bottom: 30.h),
                    itemCount: state.chats.length,
                    itemBuilder:
                        (context, index) => CustomListItem(
                          name: 'Name',
                          imageUrl: 'https://example.com/image.jpg',
                          phoneNumber: '1234567890',
                          massage: state.chats[index].lastMessage,
                        ),
                    separatorBuilder:
                        (context, index) => SizedBox(height: 10.w),
                  );
                }
                if (state is GetAllChatsFailure) {
                  return Center(
                    child: Text(
                      'Faild to load Chats',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  );
                }
                if (state is GetAllChatsEmpty) {
                  return Center(
                    child: Text('No Chats', style: TextStyle(fontSize: 20.sp)),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
