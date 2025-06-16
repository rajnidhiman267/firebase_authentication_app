import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  // Private constructor
  NotificationService._();

  // The single instance
  static final NotificationService instance = NotificationService._();

  // Firebase messaging instance
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> getDeviceToken() async {
    // await _firebaseMessaging.requestPermission();

    String? token = Platform.isIOS
        ? await _firebaseMessaging.getAPNSToken()
        : await _firebaseMessaging.getToken();

    if (token == null) return "";

    log('FCM Token: $token');

    noticationsetup();

    return token;
  }

  void noticationsetup() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message while in the foreground!');
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Got a message while in the background!');
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    log('Handling a background message ${message.messageId}');
  }
}
