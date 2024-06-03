import 'package:drift/drift.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/deliver/view/window/second_window_page.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import '../database/drift_database.dart';
import 'alarm_template.dart';
import 'view/mobile/second.dart';
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
        onSelectWindowNotification();
      });
    }
  }

  Future<void> showNotification(Map<String, dynamic> payload) async {
    if (Platform.isWindows) {
      print("!!!!!!!!!!!");
      String patientId = payload['환자 아이디'] ?? '정보 없음';
      String userName = payload['환자 이름'] ?? '정보 없음';
      String medicine = payload['추가 의약품'] ?? '정보 없음';
      String symptom = payload['추가 증상'] ?? '정보 없음';
      String detail = payload['상세 내용'] ?? '정보 없음';
      List<dynamic> prescriptionDataList = payload['처방내역'];
      print(patientId);
      print(userName);

      // 처방 내역 데이터 처리 (첫 번째 처방만 사용)
      if (prescriptionDataList.isNotEmpty) {
        Map<String, dynamic> firstPrescription = prescriptionDataList[0];
        await GetIt.I<MyDatabase>().addDoctorAlarm(DoctorAlarmsCompanion(
          patientId: Value(patientId),
          userName: Value(userName),
          medicine: Value(medicine),
          symptom: Value(symptom),
          detail: Value(detail),
          resHospitalName: Value(firstPrescription['병의원(약국)명칭'] ?? '정보 없음'),
          resTreatDate: Value(firstPrescription['처방 일자'] ?? '정보 없음'),
          resPrescribeDrugName: Value(firstPrescription['의약품 명'] ?? '정보 없음'),
          resPrescribeDrugEffect: Value(firstPrescription['처방약품 효능'] ?? '정보 없음'),
          resPrescribeDays: Value(firstPrescription['투약일수'] ?? '정보 없음'),
        ));
      }
      else {
        await GetIt.I<MyDatabase>().addDoctorAlarm(DoctorAlarmsCompanion(
            patientId: Value(patientId),
            userName: Value(userName),
            medicine: Value(medicine),
            symptom: Value(symptom),
            detail: Value(detail),
            resHospitalName: Value('정보 없음'),
            resTreatDate: Value('정보 없음'),
            resPrescribeDrugName: Value('정보 없음'),
            resPrescribeDrugEffect: Value('정보 없음'),
            resPrescribeDays: Value('정보 없음')
        ));
      }

      // 알림 템플릿 업데이트 및 알림 표시
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
        '전문의 이름: ${payload['전문의 이름'] ?? '이름 없음'}',
        payload['제목'] ?? '제목 없음',

        notificationDetails,
        payload: payloadString,
      );

    }
  }

  static Map<String, dynamic>? lastPayload;


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
            await GetIt.I<MyDatabase>().addPatientAlarm(PatientAlarmsCompanion(
              userName: Value(data['전문의 이름']),
              title: Value(data['제목']),
              body: Value(data['내용']),
            ));
            print(data['전문의 이름']);
            print("haha");
            navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => SecondPage(payload: data),
              ),
            );
            lastPayload = data;
          } else {
            print('navigatorKey가 비어있습니다.');
          }
        } catch (e) {
          print('데이터 파싱 중 에러 발생: $e');
        }
      }
    }
  }

  Future onSelectWindowNotification() async {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => SecondWindowPage(),
        ),
      );
    } else {
      print('navigatorKey가 비어있습니다.');
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