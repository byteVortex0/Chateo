import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chateo/features/conversation/chats/data/model/chat_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'send_massage_state.dart';

class SendMassageCubit extends Cubit<SendMassageState> {
  SendMassageCubit() : super(SendMassageInitial());

  final supabase = Supabase.instance.client;

  Future<void> sendMassage({required ChatModel chat}) async {
    emit(SendMassageLoading());
    try {
      final response =
          await supabase
              .from('chats')
              .select('id, users')
              .or(
                'users->>user1_id.eq.${chat.users.user1Id},users->>user2_id.eq.${chat.users.user1Id}',
              )
              .or(
                'users->>user1_id.eq.${chat.users.user2Id},users->>user2_id.eq.${chat.users.user2Id}',
              )
              .limit(1)
              .maybeSingle();

      log('Response: $response');

      if (response == null) {
        final addResponse =
            await supabase.from('chats').insert(chat.toJson()).select();

        log('Add Response: $addResponse');

        emit(SendMassageSuccess(chat: chat, chatId: addResponse[0]['id']));
      } else {
        final updateResponse = await supabase.rpc(
          'add_chat_message',
          params: {
            'p_chat_id': response['id'],
            'p_message': chat.chatData,
            'p_last_message': chat.lastMessage,
            'p_last_message_time': chat.lastMessageTime.toIso8601String(),
          },
        );

        log('Update Response: $updateResponse');

        if (updateResponse == null) {
          emit(SendMassageError('Failed to send message'));
        } else {
          emit(SendMassageSuccess(chat: chat, chatId: response['id']));
        }
      }
    } catch (e) {
      log('Error: $e');
      emit(SendMassageError(e.toString()));
    }
  }
}
