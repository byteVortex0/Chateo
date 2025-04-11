import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../data/model/chat_model.dart';

part 'get_all_chats_state.dart';

class GetAllChatsCubit extends Cubit<GetAllChatsState> {
  GetAllChatsCubit() : super(GetAllChatsLoading());

  final supabase = Supabase.instance.client;

  Future<void> getAllChats() async {
    emit(GetAllChatsLoading());
    try {
      final userId = SharedPref.getValue(PrefKey.userId);
      final response = await supabase
          .from('chats')
          .select()
          .or('users->>user1_id.eq.$userId,users->>user2_id.eq.$userId');

      log('Response: $response');

      if (response.isEmpty) {
        emit(GetAllChatsEmpty());
      } else {
        log('data');
        final data = response.map((e) => ChatModel.fromJson(e)).toList();
        emit(GetAllChatsSuccess(data));
      }
    } catch (e) {
      log('Error fetching all chats: $e');
      emit(GetAllChatsFailure(e.toString()));
    }
  }
}
