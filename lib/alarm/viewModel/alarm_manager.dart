import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';
import 'dart:core';

import 'alarm_view_model.dart';
class AlarmManager {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final AlarmViewModel _viewModel;

  AlarmManager(this._flutterLocalNotificationsPlugin)
      : _viewModel = AlarmViewModel() {
    tz.initializeTimeZones();

    // 3. 주기적으로 알림 예약 확인
    // 1분마다 getAllAlarms() 메서드를 호출하여 새로운 알림 예약
    Timer.periodic(Duration(minutes: 1), (timer) {
      getAllAlarms();
    });
  }

  // 1. Alarm 테이블에서 모든 데이터 조회
  Future<List<Alarm>> getAllAlarms() async {
    final alarms = await _viewModel.getAlarms();
    scheduleNotifications(alarms);
    print("작동?");
    return alarms;
  }

  // 2. 조회한 데이터로 알림 예약
  void scheduleNotifications(List<Alarm> alarms) {
    final now = tz.TZDateTime.now(tz.local);
    for (var alarm in alarms) {
      final tzDateTime = tz.TZDateTime.from(alarm.time, tz.local);
      if (tzDateTime.isAfter(now)) {
        scheduleNotification(
          id: alarm.id,
          medicationName: alarm.medicationName,
          dosage: alarm.dosage,
          dateTime: alarm.time,
          isEnabled: alarm.isEnabled,
        );
      }
    }
  }

  // 4. 알림 취소
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // 5. Alarm 테이블 업데이트
  // Future<void> updateAlarm(Alarm alarm) async {
  //   await _viewModel.updateAlarm(alarm); // AlarmViewModel의 updateAlarm() 함수 호출
  // }


  Future<void> scheduleNotification({
    required int id,
    required String medicationName,
    required String dosage,
    required DateTime dateTime,
    required bool isEnabled,
  }) async {
    final tzDateTime = tz.TZDateTime.from(dateTime, tz.local);
    final alarm = Alarm(
      id: id,
      medicationName: medicationName,
      dosage: dosage,
      time: dateTime,
      isEnabled: isEnabled,
    );
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      medicationName,
      "복용 시간입니다.",
      tzDateTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
          .absoluteTime, //절대적 시간 사용
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time, // 매일 동일 시간에 전송
    );
  }

  Future<void> showSuccessNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'id',
      'name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      '약 복용 시간 기록',
      '사용자의 약 복용시간이 기록되었습니다.',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
