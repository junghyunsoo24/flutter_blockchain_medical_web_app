import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as drift; // drift 임포트 추가
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../database/drift_database.dart';
// ... (기존 코드)

class SecondWindowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('세부 정보 페이지'),
      ),
      body: Center(
        child: FutureBuilder<List<DoctorAlarm>>(
          future: GetIt.I<MyDatabase>().select(GetIt.I<MyDatabase>().doctorAlarms).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // 데이터 로딩 중 표시
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // 에러 발생 시 표시
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data found'); // 데이터가 없을 경우 표시
            } else {
              // 데이터가 있을 경우 화면에 표시
              final alarms = snapshot.data!;
              return ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  final alarm = alarms[index];
                  return ListTile(
                    title: Text('사용자 이름: ${alarm.userName}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('약물: ${alarm.medicine}'),
                        Text('증상: ${alarm.symptom}'),
                        Text('세부 정보: ${alarm.detail}'),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}