import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import '../../database/drift_database.dart';
import '../../login/view/login_screen.dart';
import '../../notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebDeliverScreen extends ConsumerStatefulWidget  {

  @override
  _WebDeliverScreenState createState() => _WebDeliverScreenState();
}

class _WebDeliverScreenState extends ConsumerState<WebDeliverScreen> {
  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance.collection('doctorToPatient').snapshots();
  bool _isInitialLoadComplete = false;

  final TextEditingController _bodyController = TextEditingController();

  String? _selectedSymptom; // 선택된 증상
  String? _selectedMedicine; // 선택된 개인 의약품

  late List<Symptom> _symptoms = [];
  late List<PersonalMedicine> _medicines = [];
  late String userName;

  late String symptom, medicine;

  Future<void> _loadData() async {
    _symptoms = await GetIt.I<MyDatabase>().getAllSymptoms();
    _medicines = await GetIt.I<MyDatabase>().getAllPersonalMedicines();
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    _loadData();

    GetIt.I<FlutterLocalNotification>().init();

    final userInfo = ref.read(userInfoProvider);
    userName = userInfo.name;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      GetIt.I<FlutterLocalNotification>().showNotification({
        'title': '환자 추가 정보',
        'body': '$userName, $symptom, $medicine, ${_bodyController.text}'
      });
    });

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
    final userInfo = ref.read(userInfoProvider);
    userName = userInfo.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('메시지 전송'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedSymptom,
              hint: Text('증상 선택'),
              onChanged: (value) {
                setState(() {
                  _selectedSymptom = value;
                });
              },
              items: _symptoms.map((symptom) {
                return DropdownMenuItem<String>(
                  value: symptom.symptom,
                  child: Text(symptom.symptom),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _selectedMedicine,
              hint: Text('개인 의약품 선택'),
              onChanged: (value) {
                setState(() {
                  _selectedMedicine = value;
                });
              },
              items: _medicines.map((medicine) {
                return DropdownMenuItem<String>(
                  value: medicine.pillName,
                  child: Text(medicine.pillName),
                );
              }).toList(),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: '상세 내용'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_selectedSymptom != null) {
                  symptom = _selectedSymptom!;
                }
                else{
                  symptom =" 추가 증상 없음";
                }
                if (_selectedMedicine != null) {
                  medicine = _selectedMedicine!;
                }
                else{
                  medicine =" 추가 의약품 없음";
                }

                await FirebaseFirestore.instance.collection('patientToDoctor').add({
                  '환자 이름': userName,
                  '추가 증상': symptom,
                  '추가 의약품': medicine,
                  '상세 내용': _bodyController.text,
                });

                // 데이터 추가 후, 필드 초기화
                _bodyController.clear();
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
    _bodyController.dispose();
    super.dispose();
  }
}