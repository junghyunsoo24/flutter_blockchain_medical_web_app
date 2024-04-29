import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

class AlarmSetupScreen extends StatefulWidget {
  @override
  _AlarmSetupScreenState createState() => _AlarmSetupScreenState();
}
class _AlarmSetupScreenState extends State<AlarmSetupScreen> {

  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _medicineController = TextEditingController();
  TextEditingController _dosageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('복용 알람 설정'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  surfaceTintColor: Colors.blue
              ),
              onPressed: () {
                _selectTime(context);
              },
              child: Text('시간 설정', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                // controller: _medicineController,
                decoration: InputDecoration(
                  labelText: '약 정보',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                // controller: _medicineController,
                decoration: InputDecoration(
                  labelText: '복용 양',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final dateTime = DateTime(//dateTime 타입으로 변환
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  _selectedTime.hour,
                  _selectedTime.minute,
                );
                final alarm = Alarm(//사용자가 새로 등록한 알람
                  id: 1,
                  medicationName: _medicineController.text,
                  dosage: _dosageController.text,
                  time: dateTime,
                  isEnabled: true,
                );
                final database = MyDatabase();
                await database.addAlarm(alarm);//데이터베이스에 데이터 insert
                Navigator.pop(context);
                // _loadMedications(); // 새로운 알람 추가 후 목록 업데이트
              },
              child: Text('저장', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}