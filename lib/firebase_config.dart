import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseConfig {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  ///Foreground notification
  static Future<void> setForegroundNotificationPresentationOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  ///background message
  static Future<void> onBackgroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  static void onMessenge() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {}
    });
  }

  /// Also handle any interaction when the app is in the background via a Stream listener
  static void setupInteractedNotify() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
}

void _handleMessage(RemoteMessage message) {}

Future<void> _messageHandler(RemoteMessage message) async {}
