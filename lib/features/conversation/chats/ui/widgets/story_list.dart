import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/routes/app_routes.dart';
import 'package:chateo/features/conversation/chats/ui/widgets/story_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../add_story/data/model/story_model.dart';
import '../../logic/controller/get_all_stories_controller.dart';
import 'story_item.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: GetAllStoriesController().getAllStories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => const StoryShimmer(),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                );
              }

              if (!snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder:
                      (context, index) => StoryItem(
                        name: 'My Story',
                        onTap: () {
                          context.pushNamed(AppRoutes.addStoryScreen);
                        },
                      ),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                );
              }

              final allStories = snapshot.data!;

              allStories.sort((a, b) {
                final aStory = a['story'] as StoryModel;
                final bStory = b['story'] as StoryModel;

                if (aStory.storiesData.isEmpty) return 1;
                if (bStory.storiesData.isEmpty) return -1;

                final aLatest = aStory.storiesData
                    .map((e) => e.createdAt)
                    .reduce((a, b) => a.isAfter(b) ? a : b);

                final bLatest = bStory.storiesData
                    .map((e) => e.createdAt)
                    .reduce((a, b) => a.isAfter(b) ? a : b);

                return bLatest.compareTo(aLatest);
              });

              allStories.insert(0, {
                'story': StoryModel(userId: '', storiesData: []),
                'personalInfo': {'firstName': 'My Story', 'imageUrl': ''},
              });

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: allStories.length,
                itemBuilder: (context, index) {
                  final personalInfo = allStories[index]['personalInfo'];
                  if (index == 0) {
                    return StoryItem(
                      name: 'My Story',
                      onTap: () {
                        context.pushNamed(AppRoutes.addStoryScreen);
                      },
                    );
                  }
                  return StoryItem(
                    name: '${personalInfo.firstName}',
                    imageUrl: personalInfo.imageUrl,
                    onTap: () {
                      context.pushNamed(
                        AppRoutes.viewStoryScreen,
                        arguments: {'allStories': allStories, 'index': index},
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
              );
            },
          ),
        ),
      ],
    );
  }
}
