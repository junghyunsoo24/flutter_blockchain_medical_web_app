import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';
import 'dart:core';

import 'alarm_view_model.dart';
class AlarmManager {
  final MyDatabase _database;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final AlarmViewModel _viewModel;

  AlarmManager(this._database, this._flutterLocalNotificationsPlugin)
      : _viewModel = AlarmViewModel(_database) {
    tz.initializeTimeZones();
  }
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
      actions: [
        AndroidNotificationAction(
          'confirm',
          '복용 완료',
        ),

        AndroidNotificationAction(
          'cancel',
          '복용 취소',
        ),
      ],
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
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time, // 매일 동일 시간에 전송
    );
  }


// Future<void> scheduleNotification(Alarm alarm) async {
  //   final now = DateTime.now();
  //   final dateTime = DateTime(now.year, now.month, now.day, alarm.time.hour, alarm.time.minute);
  //   final tzDateTime = TZDateTime.from(dateTime, tz.local);
  //
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //     alarm.id,
  //     alarm.medicationName,
  //     "복용 시간입니다.",
  //     tzDateTime,
  //     NotificationDetails(
  //       android: AndroidNotificationDetails('channelId', 'channelName'),
  //     ),
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //
  //     matchDateTimeComponents: DateTimeComponents.time,// 반복 설정
  //   );
  // }

// Future<void> scheduleNotification(Alarm alarm) async {
  //   final dateTime = _convertToDateTime(alarm.time as TimeOfDay);
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //     alarm.id,
  //     alarm.medicationName,
  //     "복용 시간입니다.",
  //     TZDateTime.from(dateTime, tz.local),
  //     NotificationDetails(
  //       android: AndroidNotificationDetails('channelId', 'channelName'),
  //     ),
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //     matchDateTimeComponents: DateTimeComponents.time,//반복 설정
  //   );
  // }

// Future<void> scheduleNotification(Alarm alarm) async {
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //     alarm.id,
  //     alarm.medicationName,
  //     "복용 시간입니다.",
  //     _convertToDateTime(alarm.time),
  //     NotificationDetails(
  //       android: AndroidNotificationDetails('channelId', 'channelName'),
  //     ),
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //   );
  }


// DateTime _convertToDateTime(TimeOfDay timeOfDay) {
  //   final now = DateTime.now();
  //   final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  //   return TZDateTime.from(dateTime, tz.local);
  // }


// showNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       1,
  //       "제목3",
  //       "내용3",
  //       makeDate(18, 58, 0),
  //       NotificationDetails(
  //         android: AndroidNotificationDetails('channelId', 'channelName')
  //       ),
  //       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
  //   ,androidAllowWhileIdle: true);
  // }
  //
  // makeDate(h, m, s){
  //   var now = tz.TZDateTime.now(tz.local);
  //   var when = tz.TZDateTime(tz.local, now.year, now.month, now.day, h, m, s);
  //   if(when.isBefore(now)){
  //     return when.add(Duration(days: 1));
  //   }else{
  //     return when;
  //   }
  // }

  // Future<void> scheduleAlarm(Alarm alarm) async { // Alarm 객체 받아서 알람 세부 정보 구성
  //   final notificationDetails = NotificationDetails( // NotificationDetails 객체 생성해서 Android 알림 세부 정보 설정
  //     android: AndroidNotificationDetails(
  //       'channel_id',
  //       'Channel Name',
  //       channelDescription: 'Channel Description',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //     ),
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.zonedSchedule( //알림 예약
  //     alarm.id, //알림 id
  //     'Time to take your medication!', //제목
  //     '${alarm.medicationName} (${alarm.dosage})', //알림 내용
  //     tz.TZDateTime.from(alarm.time, tz.local), //사용자의 현지 시간 대에 맞춰 알림 예약
  //     notificationDetails,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //     UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

  // Future<void> confirmTakeMedication(Alarm alarm) async {
  //   await _database.updateAlarm(
  //     alarm.copyWith(takeTime: DateTime.now()),
  //   );
  // }
