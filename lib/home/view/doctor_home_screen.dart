import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/patient_list_screen.dart';
import '../../database/drift_database.dart';
import '../../deliver/view/window/phone_deliver_screen.dart';

final alarmProvider = FutureProvider<List<DoctorAlarm>>((ref) async {
  return await GetIt.I<MyDatabase>().getTopFiveDoctorAlarms();
});
class DoctorHomeScreen extends ConsumerWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<DoctorAlarm>> alarms = ref.watch(alarmProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlueAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.medication_liquid, color: Colors.red),
                            ),
                            Expanded(
                              child: Text(
                                '나의 환자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PatientList()),
                                );
                              },
                              icon: Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                        Expanded(
                          child: FutureBuilder<List<DoctorAlarm>>(
                            future: GetIt.I<MyDatabase>().getTopFiveDoctorAlarms(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError || !snapshot.hasData) {
                                return Text('No data available');
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final alarm = snapshot.data![index];
                                    return ListTile(
                                      title: Text(alarm.userName),
                                      subtitle: Text('증상: ${alarm.symptom}'),
                                      trailing: Text('약물: ${alarm.medicine}'),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFB9E8FF),
                          Colors.blue,
                        ],
                      ),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                    margin: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.send_rounded,
                              color: Colors.pink,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '의료데이터 전송',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.send_to_mobile_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PhoneDeliverScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


