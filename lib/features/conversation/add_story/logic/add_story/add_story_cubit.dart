import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../data/model/story_model.dart';

part 'add_story_state.dart';

class AddStoryCubit extends Cubit<AddStoryState> {
  AddStoryCubit() : super(AddStoryInitial());

  final supabase = Supabase.instance.client;

  //create method to add story to supabase
  Future<void> addStory({required StoryModel story}) async {
    emit(AddStoryLoading());
    final userId = SharedPref.getValue(PrefKey.userId);

    try {
      final response =
          await supabase
              .from('stories')
              .select()
              .eq('user_id', userId)
              .limit(1)
              .maybeSingle();

      if (response == null) {
        await supabase.from('stories').insert(story.toJson());
        emit(AddStorySuccess());
      } else {
        final existingStories =
            (response['stories_data'] as List)
                .map((e) => StoryData.fromJson(e))
                .toList();

        existingStories.addAll(story.storiesData);

        await supabase
            .from('stories')
            .update({
              'stories_data': existingStories.map((e) => e.toJson()).toList(),
            })
            .eq('id', response['id']);

        emit(AddStorySuccess());
      }
    } catch (e) {
      log(e.toString());
      emit(AddStoryError(message: e.toString()));
    }
  }
}
