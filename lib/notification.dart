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
      print('나는야 핸드폰');
      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

      await GetIt.I<FlutterLocalNotificationsPlugin>().initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: (payload) async {
            onSelectNotification(payload);
          });
    }
    else if(Platform.isWindows){
      print('나는야 데스크톱');
      await GetIt.I<WindowsNotification>().initNotificationCallBack((s) {
      });
    }
  }

  Future<void> showNotification(Map<String, dynamic> payload) async {
    if (Platform.isWindows) {
      String userName = payload['환자 이름'] ?? '정보 없음';
      String medicine = payload['추가 의약품'] ?? '정보 없음';
      String symptom = payload['추가 증상'] ?? '정보 없음';
      String detail = payload['상세 내용'] ?? '정보 없음';

      String updatedTemplate = alarmtTemplate
          .replaceAll('userName', userName)
          .replaceAll('medicine', medicine)
          .replaceAll('symptom', symptom)
          .replaceAll('detail', detail);

      GetIt.I<WindowsNotification>().showNotificationCustomTemplate(NotificationMessage.fromCustomTemplate("test1", group: "jj"), updatedTemplate);
    }

    else if(Platform.isAndroid){
      const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'channel_id',
        'channel_title',
        channelDescription: 'channel_description',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
      String payloadString = mapToQueryString(payload);

      await GetIt.I<FlutterLocalNotificationsPlugin>().show(
        0,
        payload['전문의 이름'] ?? '이름 없음',
        payload['제목'] ?? '제목 없음',

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
              return MapEntry(Uri.decodeComponent(parts[0].trim()),
                  Uri.decodeComponent(parts[1].trim()));
            } else {
              throw FormatException("잘못된 데이터 포맷입니다.");
            }
          }));

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

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

String mapToQueryString(Map<String, dynamic> map) {
  return map.entries
      .map((entry) =>
          '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
      .join('&');
}