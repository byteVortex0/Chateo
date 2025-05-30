import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../data/model/chat_model.dart';

class GetAllChatsController {
  final supabase = Supabase.instance.client;
  List<String> users = [];

  Stream<List<Map<String, dynamic>>> getAllChats() {
    final userId = SharedPref.getValue(PrefKey.userId);
    // log('userId from stream: $userId');
    return supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        // .eq('users->>user1_id', userId)
        .order('last_message_time')
        .asyncMap((event) async {
          // log('message');
          String lastMessages;
          List<int> unReads = [];
          final chatModelList =
              (event as List<dynamic>)
                  .map((e) {
                    final chat = ChatModel.fromJson(e as Map<String, dynamic>);

                    int unReadMessages = 0;

                    lastMessages = chat.chatData.last.messageId!;
                    // log('lastMessages1: $lastMessages');

                    for (var message in chat.chatData) {
                      if (message.isSeen == false &&
                          message.senderId != userId) {
                        unReadMessages += 1;
                      }

                      if (message.messageId == lastMessages) {
                        unReads.add(unReadMessages);
                      }
                    }

                    return chat;
                  })
                  .where(
                    (chat) =>
                        chat.users.user1Id == userId ||
                        chat.users.user2Id == userId,
                  )
                  .toList();
          // log('ChatDataList from stream: $chatModelList');

          // log('unReads from stream: $unReads');

          // log('ChatDataList from stream: $unreadChats');

          // get other user id
          users.clear();
          for (var e in chatModelList) {
            bool isUser1 = e.users.user1Id == userId;

            isUser1 ? users.add(e.users.user2Id) : users.add(e.users.user1Id);
          }

          /// 2. هات بيانات كل يوزر باستخدام Future.wait
          final personalInfoList = await Future.wait(
            users.map((id) async {
              final userData =
                  await supabase
                      .from('users')
                      .select()
                      .eq('id', id)
                      .maybeSingle();

              if (userData != null) {
                return PersonalInfoModel.fromJson(userData);
              }
              return null;
            }),
          );

          // log('personalInfo: ${personalInfoList.length}');

          /// 3. اربط كل chat ببيانات الـ user التاني
          final results = <Map<String, dynamic>>[];

          for (var chat in chatModelList) {
            final isUser1 = chat.users.user1Id == userId;
            final otherUserId =
                isUser1 ? chat.users.user2Id : chat.users.user1Id;

            final personalInfo = personalInfoList.firstWhere(
              (info) => info?.id == otherUserId,
              orElse: () => null,
            );

            results.add({
              'chat': chat,
              'personalInfo': personalInfo,
              'unread': unReads,
            });
          }

          return results;
        });
  }
}
