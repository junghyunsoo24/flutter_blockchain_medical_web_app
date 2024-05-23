import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_medical_history_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_setUp_Screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/viewModel/alarm_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../viewModel/alarm_manager.dart';

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({Key? key}) : super(key: key);
  @override
  _AlarmListScreenState createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  late List<Alarm> alarms = [];
  late final AlarmViewModel _viewModel;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late final AlarmManager _alarmManager;
  // 싱글톤 인스턴스
  static _AlarmListScreenState? _instance;

  factory _AlarmListScreenState() {
    _instance ??= _AlarmListScreenState._();
    return _instance!;
  }

  _AlarmListScreenState._() {
    // 인스턴스 초기화
    _viewModel = AlarmViewModel();
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _alarmManager = AlarmManager(_flutterLocalNotificationsPlugin);
    _requestPermissions();
    _loadAlarms();
    _initializeNotifications();
  }

  // 알림 초기화 메서드
  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // 알림을 클릭했을 때 실행되는 콜백 함수
        _handleNotificationTap(response);

      },);
  }

  void _handleNotificationTap(NotificationResponse response) {
    final alarmId = response.id; // 현재 울린 알람 ID
    final alarm = alarms.firstWhere((a) => a.id == alarmId); // 알람 객체 찾기
    if (alarm != null) {
      _viewModel.confirmTakeMedication(alarm); // 해당 알람 정보 업데이트
      _alarmManager.showSuccessNotification();
    }
  }
  @override
  void dispose() {
    // 인스턴스 해제
    _instance = null;
    super.dispose();
  }
  Future<void> _requestPermissions() async { //알림 권한 요청
    print("요청");
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

  }

  Future<void> _loadAlarms() async {
    final alarmList = await GetIt.I<MyDatabase>().getAllAlarms(); //모든 알람 가져오기
    print("여기");
    print(alarmList);
    setState(() {
      alarms = alarmList;
    });
  }

  Future<void> _toggleAlarmStatus(Alarm alarm) async {
    final updatedAlarm = alarm.copyWith(isEnabled: !alarm.isEnabled);
    await GetIt.I<MyDatabase>().updateAlarm(updatedAlarm);
    _loadAlarms(); // Refresh the list
  }

  Future<void> _confirmTakeMedication(Alarm alarm) async {
    await _viewModel.confirmTakeMedication(alarm);
    _loadAlarms(); // Refresh the list
  }
  Future<void> _deleteAlarm(Alarm alarm) async {
    await _viewModel.deleteAlarm(alarm);
    await _alarmManager.cancelNotification(alarm.id);
    _loadAlarms();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('알람이 삭제되었습니다.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알람목록', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // 복용 기록 조회 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlarmMedicalHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          final alarm = alarms[index];
          return ListTile(
            title: Text(
              '${alarm.time.hour}:${alarm.time.minute.toString().padLeft(2, '0')} - ${alarm.medicationName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            subtitle: Text('Dosage: ${alarm.dosage}', ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('삭제'),
                        ],
                      ),
                      onTap: () {
                        _deleteAlarm(alarm);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the medication setup screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlarmSetupScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white70),
        backgroundColor: Colors.blue,
      ),
    );
  }
}