import 'dart:convert';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_flutter_blockchain_medical_web_app/api/prescriptionHistory/view/prescription_history_list.dart';
import '../../../data.dart';
import '../../../database/drift_database.dart';


class PrescriptionHistoryRequest extends StatefulWidget {
  const PrescriptionHistoryRequest({Key? key}) : super(key: key);

  @override
  _PrescriptionHistoryRequestState createState() => _PrescriptionHistoryRequestState();
}

class _PrescriptionHistoryRequestState extends State<PrescriptionHistoryRequest> {
  String? BASE_URL = dotenv.env['BASE_URL'];

  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedProvider; // 선택된 통신사 저장
  //final _prescriptionRequestViewModel = PrescriptionRequestViewModel();
  bool _isLoading = false;
  Future<bool> firstCheck() async {
    final url = Uri.parse(
        '$BASE_URL/medical-api/treatment-information/first-request');
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
    }
    else {
      return false;
    }
  }


  Future<bool> secondCheck() async {
    final url = Uri.parse('$BASE_URL/medical-api/treatment-information/second-request');

    print("url");
    print(url);
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
      final dataList = jsonBody['data']['data']['resMediDetailList'] as List<dynamic>;

      for (final item in dataList) {
        for (final prescriptionData in dataList) {
          final prescription = PrescriptionsCompanion(
            resTreatDate: Value(prescriptionData['resTreatDate'] ?? ''),
            resTreatTypeDet: Value(prescriptionData['resTreatTypeDet'] ?? ''),
            resPrescribeCntDet: Value(prescriptionData['resPrescribeCntDet'] ?? ''),
            resPrescribeDrugName: Value(prescriptionData['resPrescribeDrugName'] ?? ''),
            resPrescribeDrugEffect: Value(prescriptionData['resPrescribeDrugEffect'] ?? ''),
            resPrescribeDays: Value(prescriptionData['resPrescribeDays'] ?? ''),
            resDrugCode: Value(prescriptionData['resDrugCode'] ?? ''),
            resDrugImageLink: Value(prescriptionData['resDrugImageLink'] ?? ''),
            resMedicationDirection: Value(prescriptionData['resMedicationDirection'] ?? ''),
            resBrand: Value(prescriptionData['resBrand'] ?? ''),
            resATCCode: Value(prescriptionData['resATCCode'] ?? ''),
            resFormula: Value(prescriptionData['resFormula'] ?? ''),
            resHospitalName: Value(item['resHospitalName'] ?? ''),
            resTreatStartDate: Value(item['resTreatStartDate'] ?? ''),
            resTreatType: Value(item['resTreatType'] ?? ''),
            resVisitDays: Value(item['resVisitDays'].toString() ?? '0'),//string으로 변환필요!
            resPrescribeCnt: Value(item['resPrescribeCnt'].toString() ?? '0'),//string으로 변환필요!
            resMedicationCnt: Value(item['resMedicationCnt'] .toString()?? '0'),//string으로 변환필요!
            resType: Value(item['resType'] ?? ''),
            name: Value("처방내역"),
          );

          if (!await GetIt.I<MyDatabase>().isSameExistsPrescriptions(prescription)) {
            await GetIt.I<MyDatabase>().addPrescriptions(prescription);
            print('처방전 데이터를 SQLite에 저장했습니다.');
          } else {
            print('이미 같은 처방전 데이터가 SQLite에 존재합니다.');
          }
        }
      }
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      final message = jsonBody['result']['message'];
      if (message == "이미 응답이 완료된 요청입니다.") {
        print('이미 응답이 완료된 요청입니다.');
        return false;
      } else if (message == "동일한 요청이 처리되는 중입니다. 중복 요청은 허용되지 않습니다. 잠시 후 다시 시도해주세요.") {
        print('동일한 요청이 처리되는 중입니다. 중복 요청은 허용되지 않습니다. 잠시 후 다시 시도해주세요.');
        return false;
      } else {
        print('API 요청 처리가 정상 진행 중입니다. 추가 정보를 입력하세요.');
        return false;
      }
    } else {
      print('서버에 요청이 오지 않았습니다.');
      return false;
    }
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title:
          Text('처방 내역 불러오기', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    if (_nameController.text.isNotEmpty &&
                        _birthdayController.text.isNotEmpty &&
                        _phoneController.text.isNotEmpty &&
                        _selectedProvider != null) {
                      setState(() {
                        _isLoading = true;
                      });
                      bool firstSuccess = await firstCheck();
                      if (firstSuccess) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: Text('1차인증 성공'),
                                content: Text('카카오 지갑 인증 후 확인버튼 눌러주세요.'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => AlertDialog(
                                          title: Row(
                                            children: [
                                              CircularProgressIndicator(),
                                              SizedBox(width: 16.0),
                                              Expanded(
                                                child: Text('요청 처리 중입니다.'),
                                              ),
                                            ],
                                          ),
                                          content: Text('잠시만 기다려주세요.'),
                                        ),
                                      );
                                      bool secondSuccess = await secondCheck();
                                      if (secondSuccess) {
                                        print("디비에 저장하였습니다.");
                                        Navigator.pushReplacement(
                                          outerContext,
                                          MaterialPageRoute(
                                            builder: (context) => PrescriptionHistoryListScreen(),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
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
                          builder: (context) =>
                              AlertDialog(
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
                      setState(() {
                        _isLoading = false;
                      });
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
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
                  child: _isLoading
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text('요청하기'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
