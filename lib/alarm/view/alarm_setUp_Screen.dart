import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_list_screen.dart';

class AlarmSetupScreenState extends StatefulWidget {
  const AlarmSetupScreenState({Key? key}) : super(key: key);

  @override
  _AlarmSetupScreenState createState() => _AlarmSetupScreenState();
}

class _AlarmSetupScreenState extends State<AlarmSetupScreenState> {
  TimeOfDay _selectedTime = TimeOfDay.now();

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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                surfaceTintColor: Colors.blue
              ),
              onPressed: () {
                // 알람 저장 및 리스트 페이지로 이동
                Navigator.pop(context);
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
