import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import '../../data.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

class PatientSignupScreen extends StatefulWidget {
  const PatientSignupScreen({Key? key}) : super(key: key);

  @override
  _PatientSignupScreenState createState() => _PatientSignupScreenState();
}

class _PatientSignupScreenState extends State<PatientSignupScreen> {
  String? baseUrl = dotenv.env['BASE_URL'];
  final _formKey = GlobalKey<FormState>();
  String? _userId, _password, _name, _birthday;
  int? _gender;
  double? _height, _weight;

  Future<bool> submitPatientInfo() async {
    final url = Uri.parse('http://$realPhoneIp/api/v1/patient/sign-up');
    print(url);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': _userId,
        'pw': _password,
        'role': "patient"
      }),
    );

    if (response.statusCode == 200) {
      print('환자 회원 가입 성공!');
      return true;
    } else {
      print('환자 회원 가입 실패..');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('환자 로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: '아이디'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '아이디를 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _userId = value,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: '비밀번호'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '이름'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '생년월일'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '생년월일을 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _birthday = value,
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: '성별'),
                value: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 0,
                    child: Text('남'),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('여'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return '성별을 입력하세요!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '키'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '키를 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _height = double.tryParse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '몸무게'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '몸무게를 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _weight = double.tryParse(value!),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    bool success = await submitPatientInfo();
                    if (success) {
                      await GetIt.I<MyDatabase>().addPatient(PatientsCompanion(
                          userID: Value(_userId!),
                          userPW: Value(_password!),
                          name: Value(_name!),
                          birthday: Value(_birthday!),
                          gender: Value(_gender!),
                          height: Value(_height!),
                          weight: Value(_weight!),
                          role: Value("1")
                      ));

                      Navigator.pop(context);
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("환자 회원가입 실패"),
                            content: Text("회원가입 정보를 다시 확인해주세요."),
                            actions: [
                              TextButton(
                                child: Text("확인"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }

                },
                child: const Text('환자 회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}