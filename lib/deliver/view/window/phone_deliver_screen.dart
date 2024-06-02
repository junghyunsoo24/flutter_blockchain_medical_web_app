import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/model/doctor_info.dart';

import '../../../database/drift_database.dart';
import '../../../login/view/login_screen.dart';
import '../../notification.dart';

class PhoneDeliverScreen extends ConsumerStatefulWidget {

  @override
  _PhoneDeliverScreenState createState() => _PhoneDeliverScreenState();
}

class _PhoneDeliverScreenState extends ConsumerState<PhoneDeliverScreen> {
  late String doctorId;
  late String doctorName;
  bool _isInitialLoadComplete = false;

  final TextEditingController _patientController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState(){
    super.initState();

    GetIt.I<FlutterLocalNotification>().init();

    final doctorInfo = GetIt.I<DoctorInfo>(); // GetIt에서 UserInfo 객체 가져오기
    String doctorId = doctorInfo.userId;
    String doctorName = doctorInfo.name;
    print(doctorId);
    print(doctorName);

    final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance.collection("patientTo${doctorId}").snapshots();

    _messagesStream.listen((querySnapshot) {
      if (_isInitialLoadComplete) {
        for (var change in querySnapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
            GetIt.I<FlutterLocalNotification>().showNotification(data);
          }
        }
      } else {
        _isInitialLoadComplete = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctorInfo = GetIt.I<DoctorInfo>(); // GetIt에서 UserInfo 객체 가져오기
    String doctorId = doctorInfo.userId;
    String doctorName = doctorInfo.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('메시지 전송'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _patientController,
              decoration: InputDecoration(labelText: '데이터 보낼 환자 아이디'),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: '내용'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Firestore에 데이터 추가
                await FirebaseFirestore.instance.collection("doctorTo${_patientController.text}").add({
                  '전문의 아이디': doctorId,
                  '전문의 이름': doctorName,
                  '제목': _titleController.text,
                  '내용': _bodyController.text,
                });

                _patientController.clear();
                _titleController.clear();
                _bodyController.clear();
                // 선택적으로 성공 메시지 표시나 다른 화면으로의 이동 로직 추가
              },
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}