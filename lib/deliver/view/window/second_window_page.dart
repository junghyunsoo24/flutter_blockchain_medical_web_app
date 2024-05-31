import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift; // drift 임포트 추가
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../database/drift_database.dart';

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:get_it/get_it.dart';

import '../../blockchain_service.dart';

class SecondWindowPage extends StatelessWidget {
  final blockchainService = BlockchainService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림 정보 페이지'),
      ),
      body: Center(
        child: FutureBuilder<List<DoctorAlarm>>(
          future: GetIt.I<MyDatabase>().select(GetIt.I<MyDatabase>().doctorAlarms).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data found');
            } else {
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
                        ElevatedButton(
                          onPressed: () async {
                            await blockchainService.registerNodes();

                            var medicalData = {
                              "patient_id": alarm.id,
                              "name": alarm.userName,
                              "diagnosis": alarm.symptom,
                              "treatment": alarm.medicine
                            };

                            var contractAddress = await blockchainService.storeHashOnBlockchain(
                                blockchainService.calculateHash(medicalData)
                            );

                            var isVerified = await blockchainService.verifyMedicalData(
                                medicalData, contractAddress
                            );

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('의료 데이터 검증 결과'),
                                content: Text(isVerified
                                    ? '의료 데이터의 무결성이 확인되었습니다.'
                                    : '의료 데이터가 변조되었습니다.'),
                                actions: [
                                  TextButton(
                                    child: Text('확인'),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text('검증하기'),
                        ),
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