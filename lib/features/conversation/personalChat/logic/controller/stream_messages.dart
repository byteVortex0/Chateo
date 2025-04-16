import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../../chats/data/model/chat_model.dart';

class StreamMessages {
  Stream<List<ChatData>> streamMessages(String chatId) {
    final supabase = Supabase.instance.client;
    final currentUserId = SharedPref.getValue(PrefKey.userId);
    return supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .eq('id', chatId)
        .order('last_message_time')
        .asyncMap((event) async {
          final chatDataList =
              (event.first['chat_data'] as List<dynamic>)
                  .map((e) => ChatData.fromJson(e as Map<String, dynamic>))
                  .toList();

          final unreadMessages =
              (event.first['chat_data'] as List<dynamic>)
                  .where(
                    (message) =>
                        message['is_seen'] == false &&
                        message['sender_id'] != currentUserId,
                  )
                  .toList();

          if (unreadMessages.isNotEmpty) {
            final updatedChatData =
                (event.first['chat_data'] as List<dynamic>).map((message) {
                  if (unreadMessages.any(
                    (unread) => unread['id'] == message['id'],
                  )) {
                    return {...message, 'is_seen': true};
                  }
                  return message;
                }).toList();

            await supabase
                .from('chats')
                .update({'chat_data': updatedChatData})
                .eq('id', event.first['id']);
          }
          return chatDataList;
        });
  }
}
