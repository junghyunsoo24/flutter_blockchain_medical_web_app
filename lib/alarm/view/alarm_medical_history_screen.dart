import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_setUp_Screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/viewModel/alarm_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:flutter/material.dart';

import '../viewModel/alarm_manager.dart';

class AlarmMedicalHistoryScreen extends StatefulWidget {
  const AlarmMedicalHistoryScreen({Key? key}) : super(key: key);
  @override
  _AlarmMedicalHistoryScreenState createState() => _AlarmMedicalHistoryScreenState();
}

class _AlarmMedicalHistoryScreenState extends State<AlarmMedicalHistoryScreen> {
  late List<Alarm> alarms = [];
  late final AlarmViewModel _viewModel;

  @override
  void initState() {
    _viewModel = AlarmViewModel();
    _loadTakeTimeAlarms();
  }

  Future<void> _loadTakeTimeAlarms() async {
    final alarmHistoryList = await _viewModel.getAlarmsWithNonNullTakeTime();
    print("작동");
    print(alarmHistoryList);
    setState(() {
      alarms = alarmHistoryList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('복용 기록', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          final alarm = alarms[index];
          return Column(
            children: [
              ListTile(
                title: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: '복용약 ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      TextSpan(
                        text: '${alarm.medicationName}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                subtitle: Text('복용일시: ${alarm.takeTime}', style: TextStyle(fontSize: 16)),
              ),
              Divider(), // 각 데이터마다 구분선 추가
            ],
          );
        },
      ),
    );
  }

}
