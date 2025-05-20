import 'dart:convert';
import 'dart:developer';

import 'package:chateo/features/Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/conversation/chats/data/model/chat_model.dart';
import '../../di/injection.dart';
import '../../routes/app_routes.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: onTap,
    );
  }

  static Future<void> onTap(NotificationResponse response) async {
    final supabase = Supabase.instance.client;

    // payload is a JSON string
    final payload = response.payload;

    if (payload == null) {
      log('payload is null');
      return;
    }

    final data = jsonDecode(payload);

    log('data: $data');

    final chatId = data['chatId'];
    final userId = data['userId'];

    log('chatId: $chatId');
    log('userId: $userId');

    final chatResponse =
        await supabase
            .from('chats')
            .select()
            .eq('id', chatId)
            .limit(1)
            .maybeSingle();

    final userResponse =
        await supabase
            .from('users')
            .select()
            .eq('id', userId)
            .limit(1)
            .maybeSingle();

    if (chatResponse == null || userResponse == null) {
      log('chat or user is null');
      return;
    }

    final user = PersonalInfoModel.fromJson(userResponse);

    final chat = ChatModel.fromJson(chatResponse);

    sl<GlobalKey<NavigatorState>>().currentState!.pushNamed(
      AppRoutes.personalChat,
      arguments: {'chat': chat, 'user': user},
    );
  }

  static final Map<String, List<String>> chatMessages = {};

  static Future<void> showNotification({
    required String title,
    required String body,
    required String chatId,
    required String userId,
    required String userImage,
  }) async {
    chatMessages[chatId] = chatMessages[chatId] ?? [];

    chatMessages[chatId]!.add(body);

    final inboxStyle = InboxStyleInformation(
      chatMessages[chatId]!,
      contentTitle: title,
      summaryText: '${chatMessages[chatId]!.length} messages',
    );

    await flutterLocalNotificationsPlugin.show(
      chatId.hashCode,
      title,
      body,
      payload: jsonEncode({'userId': userId, 'chatId': chatId}),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: inboxStyle,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  static Future<void> cancelNotification(int chatIdHashCode) async {
    await flutterLocalNotificationsPlugin.cancel(chatIdHashCode);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
