import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseConfig {
  static Future<void> setForegroundNotificationPresentationOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> onBackgroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  static void onMessenge() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
      }
    });
  }
}

Future<void> _messageHandler(RemoteMessage message) async {}
