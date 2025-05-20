import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chateo/core/service/push_notification/firebase_cloud_messaging.dart';
import 'package:chateo/features/conversation/chats/data/model/chat_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';

part 'send_massage_state.dart';

class SendMassageCubit extends Cubit<SendMassageState> {
  SendMassageCubit() : super(SendMassageInitial());

  final supabase = Supabase.instance.client;

  Future<void> sendMassage({
    required ChatModel chat,
    required PersonalInfoModel user,
  }) async {
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

      final currentUserId = SharedPref.getValue(PrefKey.userId);

      final userId =
          chat.users.user1Id == currentUserId
              ? chat.users.user1Id
              : chat.users.user2Id;

      await sendNotification(
        body: chat.lastMessage,
        chatId: response!['id'],
        userId: userId,
        userToken: user.token ?? '',
      );

      // await FirebaseCloudMessaging().sendNotification(
      //   title: '${user.firstName} ${user.lastName}',
      //   body: chat.lastMessage,
      //   userToken: user.token ?? '',
      //   userId: user.id!,
      //   chatId: response!['id'],
      // );
    } catch (e) {
      log('Error: $e');
      emit(SendMassageError(e.toString()));
    }
  }
}

Future<void> sendNotification({
  required String body,
  required String chatId,
  required String userId,
  required String userToken,
}) async {
  final userResponse =
      await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', userId)
          .limit(1)
          .maybeSingle();

  // log('userResponse: $userResponse');

  if (userResponse != null) {
    final user = PersonalInfoModel.fromJson(userResponse);

    await FirebaseCloudMessaging().sendNotification(
      title: '${user.firstName} ${user.lastName}',
      body: body,
      userToken: userToken,
      userId: userId,
      chatId: chatId,
      userImage: user.imageUrl,
    );
  }
}


//* rpc for supabase
// CREATE OR REPLACE FUNCTION add_chat_message(
//   p_chat_id UUID,
//   p_message JSONB,
//   p_last_message TEXT,
//   p_last_message_time TIMESTAMP
// )
// RETURNS TEXT
// LANGUAGE plpgsql
// AS $$
// BEGIN
//   UPDATE chats
//   SET
//     chat_data = chat_data || p_message,
//     last_message = p_last_message,
//     last_message_time = p_last_message_time
//   WHERE id = p_chat_id;

//   RETURN 'ok';
// END;
// $$;

