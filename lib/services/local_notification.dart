import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class LocalNotification {
  LocalNotification();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_add_alert');

    DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
        onDidReceiveNotificationResponse: onSelectNotification(),
    );
  }
Future<NotificationDetails> _notifications() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
        channelDescription: 'description',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
        );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
}
Future<void> showNotification({
    required int id,
  required String title,
  required String body,
})
async {
  final detail = await _notifications();
  await _localNotificationService.show(id, title, body, detail);
}
 void _onDidReceiveLocalNotification(  int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  onSelectNotification() {
    print("payload payload");
  }


}

