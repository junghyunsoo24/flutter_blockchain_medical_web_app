import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../database/drift_database.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

class DoctorSignupScreen extends StatefulWidget {
  const DoctorSignupScreen({Key? key}) : super(key: key);


  @override
  _DoctorSignupScreenState createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends State<DoctorSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _userID, _userPW, _name, _field, _hospital, _introduction;

  Future<bool> submitDoctorInfo() async {
    final url = Uri.parse('http://localhost:8080/api/v1/doctor/sign-up');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': _userID,
        'pw': _userPW,
        'role': "doctor",
        'name': _name,
        'field': _field,
        'hospital': _hospital,
        'introduction': _introduction
      }),
    );

    if (response.statusCode == 200) {
      print('의사 회원 가입 성공!');
      return true;
    } else {
      print('의사 회원 가입 실패..');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('의사 로그인'),
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
                onSaved: (value) => _userID = value,
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
                onSaved: (value) => _userPW = value,
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
                decoration: const InputDecoration(labelText: '전공분야'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '전공분야를 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _field = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '병원'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '병원을 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _hospital = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '소개'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '병원 소개를 입력하세요!';
                  }
                  return null;
                },
                onSaved: (value) => _introduction = value,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    bool success = await submitDoctorInfo();
                    if(success) {
                      await GetIt.I<MyDatabase>().addDoctor(DoctorsCompanion(
                          userID: Value(_userID!),
                          userPW: Value(_userPW!),
                          name: Value(_name!),
                          field: Value(_field!),
                          hospital: Value(_hospital!),
                          introduction: Value(_introduction!)
                      ));
                    }

                    Navigator.pop(context);
                  }
                },
                child: const Text('의사 회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}