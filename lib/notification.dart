import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import 'deliver/alarm_template.dart';
import 'second.dart';
import 'dart:io';

class FlutterLocalNotification {

  Future<void> init() async {
    if(Platform.isAndroid){
      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

      await GetIt.I<FlutterLocalNotificationsPlugin>().initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: (payload) async {
            onSelectNotification(payload);
          });
    }

    else if(Platform.isWindows){
      await GetIt.I<WindowsNotification>().initNotificationCallBack((s) {
        print(s.userInput);
        print(s.eventType);
      });
    }
  }

  Future<void> showNotification(Map<String, dynamic> payload) async {
    if(Platform.isWindows) {
    GetIt.I<WindowsNotification>().showNotificationCustomTemplate(NotificationMessage.fromCustomTemplate("test1", group: "jj"), alarmtTemplate);
    }

    else if(Platform.isAndroid){
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
        payload['title'] ?? '환자 추가 정보',
        payload['body'] ?? '증상, 의약품',
        notificationDetails,
        payload: payloadString,
      );
    }
  }

  Future onSelectNotification(NotificationResponse payload) async {
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