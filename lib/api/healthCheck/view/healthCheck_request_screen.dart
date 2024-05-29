import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../data.dart';

class HealthCheckRequest extends StatefulWidget {
  const HealthCheckRequest({Key? key}) : super(key: key);

  @override
  _HealthCheckRequestState createState() => _HealthCheckRequestState();
}

class _HealthCheckRequestState extends State<HealthCheckRequest> {
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedProvider; // 선택된 통신사 저장
  //final _prescriptionRequestViewModel = PrescriptionRequestViewModel();

  Future<bool> firstCheck() async {
    final url = Uri.parse('http://$realPhoneIp/api/v1/medical-api/health-checkup-result/first-request');
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
    else{
      return false;
    }
  }

  Future<bool> secondCheck() async {
    final url = Uri.parse('http://$realPhoneIp/api/v1/medical-api/health-checkup-result/second-request');
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
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      if (jsonBody['result']['extraMessage'] == "" && jsonBody['result']['message'] == "성공") {
        print('haha');
        return true;
      }
      else if(jsonBody['result']['message'] == "이미 응답이 완료된 요청입니다."){
        print('이미 응답이 완료된 요청입니다.');
        return false;
      }
      else if(jsonBody['result']['message'] == "동일한 요청이 처리되는 중입니다. 중복 요청은 허용되지 않습니다. 잠시 후 다시 시도해주세요."){
        print('동일한 요청이 처리되는 중입니다. 중복 요청은 허용되지 않습니다. 잠시 후 다시 시도해주세요.');
        return false;
      }
      else{
        print('API 요청 처리가 정상 진행 중입니다. 추가 정보를 입력하세요.');
        return false;
      }
    }
    else{
      print('서버에 요청이 오지 않았습니다.');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('건강검진 내역 불러오기', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  fontSize: 12.0,
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
                  if (_nameController.text.isNotEmpty && _birthdayController.text.isNotEmpty && _phoneController.text.isNotEmpty && _selectedProvider != null) {
                    bool firstSuccess = await firstCheck();
                    if(firstSuccess){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('1차인증 성공'),
                          content: Text('카카오 지갑 확인시 2차인증 진행합니다.'),
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

                      bool secondSuccess = await secondCheck();
                      if(secondSuccess){

                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('2차인증 실패'),
                            content: Text('카카오 지갑 인증을 확인해주세요.'),
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
                    }
                    else{
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