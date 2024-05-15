import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'second.dart';

class FlutterLocalNotification {

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    print("코드확인1");

    await GetIt.I<FlutterLocalNotificationsPlugin>().initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
          print("코드확인2");
          onSelectNotification(payload);
        });
  }

  static Future<void> showNotification(Map<String, dynamic> payload) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    String payloadString = mapToQueryString(payload);

    await GetIt.I<FlutterLocalNotificationsPlugin>().show(
      0,
      payload['title'] ?? 'No Title',
      payload['body'] ?? 'No Body',
      notificationDetails,
      payload: payloadString,
    );
  }

  static Future onSelectNotification(NotificationResponse payload) async {
    print("코드호출이 안됨");
    if (payload != null) {
      if (payload.payload != null) {
        try {
          final data = Map<String, dynamic>.fromEntries(
              payload.payload!.split('&').map((item) {
                final List<String> parts = item.split('=');
                if (parts.length == 2) {
                  return MapEntry(Uri.decodeComponent(parts[0].trim()), Uri.decodeComponent(parts[1].trim()));
                } else {
                  throw FormatException("잘못된 데이터 포맷입니다.");
                }
              })
          );

          if (navigatorKey.currentState != null) {
            navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => SecondPage(payload: data),
              ),
            );
          } else {
            print('navigatorKey가 비어있습니다.');
          }
        } catch (e) {
          print('데이터 파싱 중 에러 발생: $e');
        }
      }
    }
  }

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

String mapToQueryString(Map<String, dynamic> map) {
  return map.entries.map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}').join('&');
}