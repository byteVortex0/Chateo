import 'dart:developer';

import 'package:chateo/core/app/constanst.dart';
import 'package:chateo/core/di/injection.dart';
import 'package:chateo/core/service/push_notification/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../../features/conversation/chats/data/model/chat_model.dart';
import '../../routes/app_routes.dart';

class FirebaseMessagingNavigate {
  //forGround
  static Future<void> foregroundMessage(RemoteMessage? message) async {
    // log('message: $message');
    if (message != null &&
        message.data['userId'] != null &&
        message.data['chatId'] != null) {
      // log('message.data: ${message.data}');
      if (currentChatId == message.data['chatId']) {
        log('same chat');
        return;
      }
      await LocalNotification.showNotification(
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        chatId: message.data['chatId'],
        userId: message.data['userId'],
        userImage: message.data['userImage'],
      );
    }
  }

  //BackGround
  static void backgroundMessage(RemoteMessage? message) {
    if (message != null &&
        message.data['userId'] != null &&
        message.data['chatId'] != null) {
      // Future.delayed(
      //   Duration(milliseconds: 500),
      //   () => _navigateToSpecificScreen(message),
      // );
      _navigateToSpecificScreen(message);
    }
  }

  //Terminated
  static void terminatedMessage(RemoteMessage? message) {
    if (message != null &&
        message.data['userId'] != null &&
        message.data['chatId'] != null) {
      _navigateToSpecificScreen(message);
    }
  }

  static void _navigateToSpecificScreen(RemoteMessage? message) async {
    final supabase = Supabase.instance.client;

    log('message: $message');

    log('message: ${message!.data['chatId']}');

    log('message: ${message.data['userId']}');

    final chatResponse =
        await supabase
            .from('chats')
            .select()
            .eq('id', message.data['chatId'])
            .limit(1)
            .maybeSingle();

    final userResponse =
        await supabase
            .from('users')
            .select()
            .eq('id', message.data['userId'])
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
}
