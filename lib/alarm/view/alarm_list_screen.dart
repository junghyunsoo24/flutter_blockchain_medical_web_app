import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_setUp_Screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/viewModel/alarm_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:flutter/material.dart';

import '../viewModel/alarm_manager.dart';

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({Key? key}) : super(key: key);
  @override
  _AlarmListScreenState createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  late List<Alarm> alarms = [];
  late final MyDatabase _database;
  late final AlarmViewModel _viewModel;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _database = MyDatabase();
    _viewModel = AlarmViewModel(MyDatabase());
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    _requestPermissions();
    _loadAlarms();

  }

  Future<void> _requestPermissions() async { //알림 권한 요청
    print("요청");
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

  }

  Future<void> _loadAlarms() async {
    final alarmList = await _database.getAllAlarms(); //모든 알람 가져오기
    print("여기");
    print(alarmList);
    setState(() {
      alarms = alarmList;
    });
  }

  Future<void> _toggleAlarmStatus(Alarm alarm) async {
    final updatedAlarm = alarm.copyWith(isEnabled: !alarm.isEnabled);
    await _database.updateAlarm(updatedAlarm);
    _loadAlarms(); // Refresh the list
  }

  Future<void> _confirmTakeMedication(Alarm alarm) async {
    await _viewModel.confirmTakeMedication(alarm);
    _loadAlarms(); // Refresh the list
  }
  Future<void> _deleteAlarm(Alarm alarm) async {
    await _viewModel.deleteAlarm(alarm);
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
            // trailing: Switch(
            //   value: medication.isEnabled,
            //   onChanged: (value) {
            //     _toggleAlarmStatus(medication);
            //   },
            // ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Switch(
                //   value: alarm.isEnabled,
                //   onChanged: (value) {
                //     _toggleAlarmStatus(alarm);
                //   },
                // ),
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
      //       trailing: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Switch(
      //             value: medication.isEnabled,
      //             onChanged: (value) {
      //               _toggleAlarmStatus(medication);
      //             },
      //           ),
      //           // IconButton(
      //           //   icon: Icon(Icons.check),
      //           //   onPressed: () {
      //           //     _confirmTakeMedication(medication);
      //           //   },
      //           // ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
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
