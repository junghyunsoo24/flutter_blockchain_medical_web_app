import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'second.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class FlutterLocalNotification {
  FlutterLocalNotification._();

  static init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
          onSelectNotification(payload as String?);
        });
  }

  static Future<void> showNotification(Map<String, dynamic> payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      payload['title'] ?? 'No Title',
      payload['body'] ?? 'No Body',
      notificationDetails,
      payload: payload.toString(),
    );
  }

  static Future onSelectNotification(String? payload) async {
    if (payload != null) {
      final data = Map<String, dynamic>.from(payload.split(',') as Map);
      Navigator.push(
        FlutterLocalNotification.navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => SecondPage(payload: data),
        ),
      );
    }
  }

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}