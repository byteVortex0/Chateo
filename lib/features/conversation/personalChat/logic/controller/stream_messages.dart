import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../chats/data/model/chat_model.dart';

class StreamMessages {
  Stream<List<ChatData>> streamMessages(String chatId) {
    final supabase = Supabase.instance.client;
    return supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .eq('id', chatId)
        .order('last_message_time')
        .map((event) {
          final chatDataList =
              (event.first['chat_data'] as List<dynamic>)
                  .map((e) => ChatData.fromJson(e as Map<String, dynamic>))
                  .toList();
          return chatDataList;
        });
  }
}
