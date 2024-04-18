import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/model/alarm.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_setUp_Screen.dart';
class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({Key? key}) : super(key: key);

  @override
  _AlarmListScreenState createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  List<Alarm> alarms = [
    Alarm(time: TimeOfDay(hour: 8, minute: 0), isEnabled: true),
    Alarm(time: TimeOfDay(hour: 12, minute: 30), isEnabled: false),
    Alarm(time: TimeOfDay(hour: 17, minute: 40),  isEnabled: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(//상/중/하로 쉽게 나누고 싶을 때 Scanffold 사용
      appBar: AppBar(
        title: Text('알람 목록', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          final alarm = alarms[index];
          return ListTile(
            title: Text('${alarm.time.hour}:${alarm.time.minute.toString().padLeft(2, '0')}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            trailing: CupertinoSwitch(
              value: alarm.isEnabled,
              activeColor: CupertinoColors.activeBlue,
              onChanged: (value) {
                setState(() {
                  alarm.isEnabled = value;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 알람 설정 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlarmSetupScreenState()),
          );
        },
        child: Icon(Icons.add, color: Colors.white70,),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
