import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../login/view/login_screen.dart';
import '../notification.dart';

class PhoneDeliverScreen extends ConsumerStatefulWidget {

  @override
  _PhoneDeliverScreenState createState() => _PhoneDeliverScreenState();
}

class _PhoneDeliverScreenState extends ConsumerState<PhoneDeliverScreen> {
  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance.collection('patientToDoctor').snapshots();
  bool _isInitialLoadComplete = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  late String doctorName;

  @override
  void initState(){
    super.initState();

    GetIt.I<FlutterLocalNotification>().init();

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
    final doctorInfo = ref.read(doctorInfoProvider);
    doctorName = doctorInfo.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('메시지 전송'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                await FirebaseFirestore.instance.collection('doctorToPatient').add({
                  '전문의 이름': doctorName,
                  '제목': _titleController.text,
                  '내용': _bodyController.text,
                });
                // 데이터 추가 후, 필드 초기화
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