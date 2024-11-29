import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../database/drift_database.dart';
import '../../blockchain_service.dart';

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
      body: FutureBuilder<List<PatientAlarm>>(
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

                var medicalData = {
                  "doctor_id": alarm.id,
                  "name": alarm.userName,
                  "title": alarm.title,
                  "body": alarm.body
                };
                var originDataHash = blockchainService.calculateHash(medicalData);
                print("============================================");
                print('알람 ID: ${alarm.id}, 원본 해시값: $originDataHash');

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile( // 사용자 정보를 ListTile로 표시
                          leading: Icon(Icons.account_circle), // 사용자 아이콘 추가
                          title: Text('${alarm.userName} 님', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Divider(),
                        Text('제목: ${alarm.title}', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Text('내용: ${alarm.body}'),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await blockchainService.registerNodes();

                              var contractAddress = await blockchainService.storeHashOnBlockchain(blockchainService.calculateHash(medicalData), alarm.id);
                              var dataHash = await blockchainService.getHashFromBlockchain(contractAddress!);
                              //블록체인에 저장된 해시값


                              // 3. 해시값을 비교하여 결과값 보여주기
                              bool isVerified = await blockchainService.verifyMedicalData(originDataHash, dataHash);
                              print("============================================");
                              print('받아온 해시값: $dataHash');
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('의료 데이터 검증 결과'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(isVerified
                                          ? '의료 데이터의 무결성이 확인되었습니다.'
                                          : '의료 데이터가 변조되었습니다.'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('확인'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // 버튼 색상 변경
                            ),
                            child: Text('검증하기', style: TextStyle(color: Colors.white)), // 텍스트 색상 흰색
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}