import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../database/drift_database.dart';
import '../../blockchain_service.dart';

import '../../phone_blockchain_service.dart';

class SecondPage extends StatelessWidget {
  final Map<String, dynamic>? payload;
  SecondPage({Key? key, required this.payload}) : super(key: key);

  final blockchainService = BlockchainService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림 정보 페이지'),
      ),
      body: Center(
        child: FutureBuilder<List<PatientAlarm>>(
          future: GetIt.I<MyDatabase>().select(GetIt.I<MyDatabase>().patientAlarms).get(),
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
                        Text('제목: ${alarm.title}'),
                        Text('내용: ${alarm.body}'),
                        ElevatedButton(
                          onPressed: () async {
                            await blockchainService.registerNodes();

                            var medicalData = {
                              "doctor_id": alarm.id,
                              "name": alarm.userName,
                              "title": alarm.title,
                              "body": alarm.body
                            };
                            var originDataHash = blockchainService.calculateHash(medicalData);
                            //직접 계산한 해시값

                            var changeData = {
                              "doctor_id": alarm.id + 1,
                              "name": alarm.userName,
                              "title": alarm.title,
                              "body": alarm.body
                            };
                            var changeDataHash = blockchainService.calculateHash(changeData);
                            //변조된 직접 계산한 해시값


                            var contractAddress = await blockchainService.storeHashOnBlockchain(
                                blockchainService.calculateHash(medicalData), alarm.id
                            );
                            var dataHash = await blockchainService.getHashFromBlockchain(contractAddress!);
                            //블록체인에 저장된 해시값



                            var isVerified = await blockchainService.verifyMedicalData(
                                originDataHash, dataHash
                            ); //true

                            var isNotVerified = await blockchainService.verifyMedicalData(
                                changeDataHash, dataHash
                            ); //false


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