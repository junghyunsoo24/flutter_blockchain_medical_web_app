import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_setUp_Screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:flutter/material.dart';

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({Key? key}) : super(key: key);
  @override
  _AlarmListScreenState createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  late List<Alarm> medications = [];
  late final MyDatabase _database;

  @override
  void initState() {
    super.initState();
    _database = MyDatabase();
    _loadMedications();
  }

  Future<void> _loadMedications() async {
    final medicationsList = await _database.getAllAlarms(); //모든 알람 가져오기
    print("여기");
    print(medicationsList);
    setState(() {
      medications = medicationsList;
    });
  }
  Future<void> loadMedications() async {
    await _loadMedications();
  }

  Future<void> _toggleAlarmStatus(Alarm alarm) async {
    final updatedAlarm = alarm.copyWith(isEnabled: !alarm.isEnabled);
    await _database.updateAlarm(updatedAlarm);
    _loadMedications(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알람목록', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          final medication = medications[index];
          return ListTile(
            title: Text(
              '${medication.time.hour}:${medication.time.minute.toString().padLeft(2, '0')} - ${medication.medicationName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            subtitle: Text('Dosage: ${medication.dosage}', ),
            trailing: Switch(
              value: medication.isEnabled,
              onChanged: (value) {
                _toggleAlarmStatus(medication);
              },
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
