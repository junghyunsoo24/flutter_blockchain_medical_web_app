import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../database/drift_database.dart';
import '../../login/model/doctor_info.dart';

class PatientList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? BASE_URL = dotenv.env['BASE_URL'];
    final doctorInfo = GetIt.I<DoctorInfo>();
    String doctorId = doctorInfo.userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('전송받은 기록 이력'),
      ),
      body: Container(// 밝은 회색 배경
        child: FutureBuilder<List<DoctorAlarm>>(
          future: GetIt.I<MyDatabase>().getAllDoctorAlarms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // 중앙에 로딩 표시
            } else if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: Text('데이터가 없습니다.')); // 중앙에 메시지 표시
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final alarm = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ExpansionTile( // 확장 가능한 타일 형태
                      title: Text(
                        '${alarm.userName} (${alarm.patientId})',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.person), // 사람 아이콘 추가
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('약물: ${alarm.medicine}'),
                              Text('증상: ${alarm.symptom}'),
                              Text('세부 정보: ${alarm.detail}'),
                              Divider(),
                              Text('병의원(약국) 정보', style: TextStyle(fontWeight: FontWeight.bold)),
                              ListTile(
                                leading: Icon(Icons.local_hospital),
                                title: Text('명칭: ${alarm.resHospitalName}'),
                              ),
                              ListTile(
                                leading: Icon(Icons.medication),
                                title: Text('의약품 명: ${alarm.resPrescribeDrugName}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('효능: ${alarm.resPrescribeDrugEffect}'),
                                    Text('투약일수: ${alarm.resPrescribeDays}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ElevatedButton( // "긴급 데이터 조회" 버튼 추가
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent, // 배경색 변경
                          ),
                          onPressed: () async {
                            final TextEditingController reasonController = TextEditingController(); // 이유 입력 컨트롤러

                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('긴급 데이터 조회'),
                                content: TextField( // 이유 입력 텍스트 필드
                                  controller: reasonController,
                                  decoration: InputDecoration(hintText: '조회 이유를 입력하세요'),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('취소'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context); // 팝업 창 닫기

                                      try {
                                        final response = await http.post(
                                          Uri.parse('$BASE_URL/doctor/get-patient-urgent-data'),
                                          headers: {'Content-Type': 'application/json'},
                                          body: jsonEncode({
                                            'patientId': alarm.patientId,
                                            'doctorId': doctorId,
                                            'reason': reasonController.text, // 입력된 이유 사용
                                          }),
                                        );

                                        if (response.statusCode == 200) {
                                          final String responseBody = response.body;
                                          final String decodedData = utf8.decode(responseBody.runes.toList());

                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('긴급 데이터'),
                                              content: Text(decodedData), // 받아온 데이터를 문자열로 표시 (예시)
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: Text('닫기'),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          // TODO: 서버 응답 에러 처리 (예: 팝업 창으로 에러 메시지 표시)
                                          throw Exception('Failed to load urgent data');
                                        }
                                      } catch (error) {
                                        // TODO: 예외 처리 (예: 팝업 창으로 에러 메시지 표시)
                                        print('Error: $error');
                                      }
                                    },
                                    child: Text('확인'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text('긴급 데이터 조회', style: TextStyle(color: Colors.white)),
                          // 텍스트 색상 흰색으로 변경
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
