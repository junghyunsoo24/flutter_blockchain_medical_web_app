import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/viewModel/prescription_request_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/viewModel/prescription_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/viewModel/personal_medicine_view_model.dart';

class PrescriptionHistoryRequest extends StatefulWidget {
  const PrescriptionHistoryRequest({Key? key}) : super(key: key);

  @override
  _PrescriptionHistoryRequestState createState() => _PrescriptionHistoryRequestState();
}

class _PrescriptionHistoryRequestState extends State<PrescriptionHistoryRequest> {
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedProvider; // 선택된 통신사 저장
  final _prescriptionRequestViewModel = PrescriptionRequestViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('처방내역 불러오기', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    value: 'skt',
                    groupValue: _selectedProvider,
                    onChanged: (value) {
                      setState(() {
                        _selectedProvider = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('KT(알뜰폰)'),
                    value: 'kt',
                    groupValue: _selectedProvider,
                    onChanged: (value) {
                      setState(() {
                        _selectedProvider = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('LG(알뜰폰)'),
                    value: 'lg',
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
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _birthdayController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      _selectedProvider != null) {
                    _prescriptionRequestViewModel.requestPrescriptionHistory( // 환자의 데이터 viewModel로 전달
                      _nameController.text,
                      _birthdayController.text,
                      _phoneController.text,
                      _selectedProvider!,
                    );
                  } else {
                    // 경고 메시지 표시
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
