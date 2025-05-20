import 'dart:developer';

import 'package:chateo/core/app/env_variables.dart';
import 'package:chateo/core/service/push_notification/firebase_messaging_navigate.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class FirebaseCloudMessaging {
  static final FirebaseCloudMessaging instance = FirebaseCloudMessaging._();

  FirebaseCloudMessaging._();

  factory FirebaseCloudMessaging() => instance;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  bool isPremissionGranted = false;

  Future<void> init() async {
    await notificationPermission();

    FirebaseMessaging.onMessage.listen(
      FirebaseMessagingNavigate.foregroundMessage,
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      FirebaseMessagingNavigate.backgroundMessage,
    );

    FirebaseMessaging.instance.getInitialMessage().then(
      FirebaseMessagingNavigate.terminatedMessage,
    );
  }

  Future<void> notificationPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      isPremissionGranted = true;
      log('User granted permission');
    }
  }

  Future<String?> getApiToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "chateo-1a8b0",
      "private_key_id": EnvVariables.instance.privateKeyId,
      "private_key": EnvVariables.instance.privateKey,
      "client_email":
          "firebase-adminsdk-fbsvc@chateo-1a8b0.iam.gserviceaccount.com",
      "client_id": "102574147000025061279",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40chateo-1a8b0.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
      );

      auth.AccessCredentials accessCredentials = await auth
          .obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client,
          );

      client.close();

      log(accessCredentials.accessToken.data);

      return accessCredentials.accessToken.data;
    } catch (e) {
      log("Error getting access token: $e");
      return null;
    }
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    required String userToken,
    required String userId,
    required String chatId,
    required String userImage,
  }) async {
    try {
      // Get the API token
      final token = await getApiToken();

      if (token == null) {
        log('Failed to get API token.');
        return;
      }

      final response = await Dio().post<dynamic>(
        'https://fcm.googleapis.com/v1/projects/chateo-1a8b0/messages:send',
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'message': {
            'token': userToken,
            'notification': {'title': title, 'body': body},
            'data': {
              'userId': userId,
              'chatId': chatId,
              'userImage': userImage,
            },
          },
        },
      );

      if (response.statusCode == 200) {
        log('Notification sent successfully');
      }
    } catch (e) {
      log('Error sending notification: $e');
    }
  }
}
