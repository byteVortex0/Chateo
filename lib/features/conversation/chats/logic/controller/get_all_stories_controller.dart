import 'dart:developer';

import 'package:chateo/core/service/shared_pref/pref_key.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../../add_story/data/model/story_model.dart';

class GetAllStoriesController {
  final supabase = Supabase.instance.client;
  List<String> users = [];

  Stream<List<Map<String, dynamic>>> getAllStories() {
    final userId = SharedPref.getValue(PrefKey.userId);
    return supabase.from('stories').stream(primaryKey: ['id']).asyncMap((
      event,
    ) async {
      users.clear();
      final now = DateTime.now();

      final storyModelList =
          (event as List<dynamic>)
              .map((e) {
                final story = StoryModel.fromJson(e as Map<String, dynamic>);

                final filteredStoriesData =
                    story.storiesData
                        .map((storyData) {
                          final createdAt = storyData.createdAt;

                          final difference = now.difference(createdAt);

                          if (difference.inHours >= 24) {
                            deleteExpiredStory(
                              storyId: storyData.id ?? '',
                              id: story.id ?? '',
                            );
                            return null;
                          }

                          return storyData;
                        })
                        .whereType<StoryData>()
                        .toList();

                if (filteredStoriesData.isNotEmpty) {
                  story.storiesData = filteredStoriesData;
                }

                if (story.userId == userId) {
                  return null;
                }
                users.add(story.userId);
                return story;
              })
              .whereType<StoryModel>()
              .toList();

      final personalInfoList = await Future.wait(
        users.map((id) async {
          final userData =
              await supabase.from('users').select().eq('id', id).maybeSingle();

          if (userData != null) {
            return PersonalInfoModel.fromJson(userData);
          }
          return null;
        }),
      );

      final results = <Map<String, dynamic>>[];

      for (var stroy in storyModelList) {
        final personalInfo = personalInfoList.firstWhere(
          (info) => info?.id == stroy.userId,
          orElse: () => null,
        );

        results.add({'story': stroy, 'personalInfo': personalInfo});
      }

      return results;
    });
  }

  Future<void> deleteExpiredStory({
    required String storyId,
    required String id,
  }) async {
    final response =
        await supabase.from('stories').select().eq('id', id).maybeSingle();

    if (response == null) {
      log('Error fetching story row:');
      return;
    }

    List<dynamic> storiesData = response['stories_data'];

    storiesData.removeWhere((story) => story['id'] == storyId);

    await supabase
        .from('stories')
        .update({'stories_data': storiesData})
        .eq('id', id);
  }
}
