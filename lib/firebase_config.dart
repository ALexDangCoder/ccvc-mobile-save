import 'dart:developer';

import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/fcm_notification/fcm_notification_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseConfig {
  static Future<void> setForegroundNotificationPresentationOptions() async {

    await FirebaseMessaging.instance.requestPermission(

    );
  }

  static Future<void> onBackgroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  static void getInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null && PrefsService.getToken().isNotEmpty) {
        final data = FcmNotificationModel.fromJson(value.data);
        if (data.screenTypeEnum != null) {
          _pushDetails(data.screenTypeEnum!, data);
        }
      }
    });
  }

  static void onMessageOpenApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((value) {
      final data = FcmNotificationModel.fromJson(value.data);
      if (data.screenTypeEnum != null && PrefsService.getToken().isNotEmpty) {
        _pushDetails(data.screenTypeEnum!, data);
      }
    });
  }

  static void _pushDetails(ScreenType screenTypeFcm, FcmNotificationModel data) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.push(
        MessageConfig.contextConfig!,
        MaterialPageRoute(
          builder: (context) {
            return screenTypeFcm.screen(data: data );
          },
        ),
      );
    });
  }
}

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
