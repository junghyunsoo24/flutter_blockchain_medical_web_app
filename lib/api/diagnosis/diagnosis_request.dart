import 'dart:convert';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/api/healthCheck/view/healthCheck_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/home_screen.dart';
import '../../../data.dart';
import '../../../database/drift_database.dart';

class DiagnosisRequest extends StatefulWidget {
  const DiagnosisRequest({Key? key}) : super(key: key);

  @override
  _DiagnosisRequestState createState() => _DiagnosisRequestState();
}

class _DiagnosisRequestState extends State<DiagnosisRequest> {
  String? REAL_PHONE_URL = dotenv.env['REAL_PHONE_URL'];

  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedProvider; // 선택된 통신사 저장
  //final _prescriptionRequestViewModel = PrescriptionRequestViewModel();

  Future<bool> secondCheck() async {
    final url = Uri.parse(
        'http://$REAL_PHONE_URL/api/v1/medical-api/health-checkup-result/first-request');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identity': _birthdayController.text,
        'userName': _nameController.text,
        'phoneNo': _phoneController.text,
        'telecom': _selectedProvider,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  DateTime? _parseDateString(String? dateString) {
    if (dateString == null) return null;
    try {
      DateTime dateTime = DateTime.parse("${dateString.substring(4)}-${dateString.substring(0, 2)}-${dateString.substring(2, 4)}");
      return dateTime;
    } catch (e) {
      print('Invalid date format: $e');
      return null;
    }
  }

  Future<bool> firstCheck() async {
    try { // 예외 처리 추가
      final url = Uri.parse('http://$REAL_PHONE_URL/api/v1/medical-api/health-checkup-result/second-request');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'identity': _birthdayController.text,
          'userName': _nameController.text,
          'phoneNo': _phoneController.text,
          'telecom': _selectedProvider,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        if ((jsonBody['result']['extraMessage'] == "") && (jsonBody['result']['message'] == "성공")) {
          final data = jsonBody['data'];
          final resResultList = data['resResultList'][0];
          final resPreviewList = data['resPreviewList'][0];

          if ((resPreviewList['resCheckupDate'] != "") &&  (!await GetIt.I<MyDatabase>().isSameCheckupDateExists(resResultList['resCheckupDate']))) {
            await GetIt.I<MyDatabase>().addHealthCheck(HealthChecksCompanion(
              resOrganizationName: Value(resResultList['resOrganizationName']),
              resCheckupDate: Value(DateTime.parse(resResultList['resCheckupDate'])),
              resHeight: Value(double.tryParse(resPreviewList['resHeight']) ?? 0.0),
              resWeight: Value(double.tryParse(resPreviewList['resWeight']) ?? 0.0),
              resWaist: Value(double.tryParse(resPreviewList['resWaist']) ?? 0.0),
              resBMI: Value(double.tryParse(resPreviewList['resBMI']) ?? 0.0),
              resSight: Value(resPreviewList['resSight']),
              resHearing: Value(resPreviewList['resHearing']),
              resBloodPressure: Value(resPreviewList['resBloodPressure']),
              resFastingBloodSuger: Value(double.tryParse(resPreviewList['resFastingBloodSuger']) ?? 0.0),
              resTotalCholesterol: Value(resPreviewList['resTotalCholesterol']),
            ));
            print('건강검진을 디비에 처음 저장합니다.');
            return true;
          } else {
            print("이미 같은날짜에 건강검진을 디비에 저장하였습니다.");
            return false;
          }
        } else if (jsonBody['result']['message'] == "이미 응답이 완료된 요청입니다.") {
          print('이미 응답이 완료된 요청입니다.');
          return false;
        } else if (jsonBody['result']['message'] ==
            "동일한 요청이 처리되는 중입니다. 중복 요청은 허용되지 않습니다. 잠시 후 다시 시도해주세요.") {
          print('동일한 요청이 처리되는 중입니다. 중복 요청은 허용되지 않습니다. 잠시 후 다시 시도해주세요.');
          return false;
        } else {
          print('API 요청 처리가 정상 진행 중입니다. 추가 정보를 입력하세요.');
          return false;
        }
      } else if (response.statusCode == 500) { // 500 에러 처리
        throw Exception('서버 오류 발생 (500)');
      } else {
        throw Exception('서버 요청 실패 (상태 코드: ${response.statusCode})'); // 일반적인 오류 처리
      }
    } catch (e) { // 예외 발생 시 다이얼로그 표시
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('API측 오류'),
          content: Text("API측이 현재 제공하지 않습니다."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('확인'),
            ),
          ],
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('진료 내용 불러오기', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5.0),
              Text(
                '아래 내용을 입력하고, 버튼을 누르면, 카카오톡 인증이 실시됩니다.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: '이름',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  hintText: '생년월일',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: '전화번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('통신사 선택'),
                  RadioListTile(
                    title: Text('SKT(알뜰폰)'),
                    value: '0',
                    groupValue: _selectedProvider,
                    onChanged: (value) {
                      setState(() {
                        _selectedProvider = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('KT(알뜰폰)'),
                    value: '1',
                    groupValue: _selectedProvider,
                    onChanged: (value) {
                      setState(() {
                        _selectedProvider = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('LG(알뜰폰)'),
                    value: '2',
                    groupValue: _selectedProvider,
                    onChanged: (value) {
                      setState(() {
                        _selectedProvider = value.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final outerContext = context;
                  if (_nameController.text.isNotEmpty && _birthdayController.text.isNotEmpty && _phoneController.text.isNotEmpty && _selectedProvider != null) {
                    bool firstSuccess = await firstCheck();
                    if (firstSuccess) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('1차인증 성공'),
                          content: Text('카카오 지갑 인증 후 확인버튼 눌러주세요.'),
                          actions: [
                            TextButton(
                              onPressed: () async{
                                Navigator.of(context).pop();
                                bool secondSuccess = await secondCheck();
                                if (secondSuccess) {
                                  print("디비에 저장하엿습니다.");
                                  Navigator.of(outerContext).pop();
                                } else {

                                }
                              },
                              child: Text('확인'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('1차인증 실패'),
                          content: Text('잘못 작성하였습니다. 데이터를 다시 확인해주세요.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('확인'),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('입력 오류'),
                        content: Text('모든 필드를 입력하고 통신사를 선택해 주세요.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('확인'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text('요청하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}