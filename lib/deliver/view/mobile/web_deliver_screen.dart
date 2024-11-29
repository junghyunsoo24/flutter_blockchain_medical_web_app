import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/model/user_info.dart';
import '../../../database/drift_database.dart';
import '../../../login/view/login_screen.dart';
import '../../notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebDeliverScreen extends ConsumerStatefulWidget {
  @override
  _WebDeliverScreenState createState() => _WebDeliverScreenState();
}

class _WebDeliverScreenState extends ConsumerState<WebDeliverScreen> {
  List<Map<String, dynamic>> prescriptionDataList = [];

  late String patientId;
  late String patientName;

  bool _isInitialLoadComplete = false;

  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  String? _selectedPrescription;
  String? _selectedSymptom; // 선택된 증상
  String? _selectedMedicine; // 선택된 개인 의약품

  late List<Symptom> _symptoms = [];
  late List<PersonalMedicine> _medicines = [];


  late String symptom, medicine;
  String prescriptionName = '';

  Future<void> _loadData() async {
    // 데이터베이스에서 데이터 가져오기
    _symptoms = await GetIt.I<MyDatabase>().getAllSymptoms();
    _medicines = await GetIt.I<MyDatabase>().getAllPersonalMedicines();

    // 처방내역 가져오기 및 상태 업데이트
    String loadedPrescriptionName = (await GetIt.I<MyDatabase>().getNameFromPrescriptions())!;
    setState(() { // 상태 업데이트
      prescriptionName = loadedPrescriptionName;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();

    GetIt.I<FlutterLocalNotification>().init();

    final patientInfo = GetIt.I<UserInformation>(); // GetIt에서 UserInfo 객체 가져오기
    String patientId = patientInfo.userId;
    String patientName = patientInfo.name;
    print(patientId);
    print(patientName);

    final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance.collection("doctorTo${patientId}").snapshots();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   GetIt.I<FlutterLocalNotification>().showNotification({
    //     'title': '환자 추가 정보',
    //     'body': '$patientId, $symptom, $medicine, ${_bodyController.text}'
    //   });
    // });

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
    final patientInfo = GetIt.I<UserInformation>(); // GetIt에서 UserInfo 객체 가져오기
    String patientId = patientInfo.userId;
    String patientName = patientInfo.name;

    return Scaffold(
        appBar: AppBar(
          title: Text('메시지 전송'),
          backgroundColor: Colors.lightBlueAccent, // 앱바 색상 변경
          leading: Icon(Icons.message), // 앱바에 메시지 아이콘 추가
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  value: _selectedPrescription,
                  hint: Text('API 선택'),
                  onChanged: (value) async {
                    setState(() {
                      _selectedPrescription = value;
                    });
                  },
                  items: prescriptionName == '건강검진내역' // null 체크 불필요
                      ? [
                    DropdownMenuItem<String>(
                      value: '건강검진내역',
                      child: Text('건강검진내역'),
                    ),
                  ]
                      : [], // _selectedPrescription이 null이면 빈 리스트 표시
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                  dropdownColor: Colors.white,
                  elevation: 8,
                  isExpanded: true,
                ),
                SizedBox(height: 16.0),

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
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue, // 드롭다운 텍스트 색상 변경
                  ),
                  dropdownColor: Colors.white,
                  // 드롭다운 배경색 변경
                  elevation: 8,
                  // 드롭다운 그림자 효과 추가
                  isExpanded: true, // 드롭다운 너비를 화면 가득 채움
                ),
                SizedBox(height: 16.0),

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
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue, // 드롭다운 텍스트 색상 변경
                  ),
                  dropdownColor: Colors.white,
                  // 드롭다운 배경색 변경
                  elevation: 8,
                  // 드롭다운 그림자 효과 추가
                  isExpanded: true, // 드롭다운 너비를 화면 가득 채움
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _doctorController,
                  decoration: InputDecoration(
                    labelText: '데이터 보낼 의료진 아이디',
                    labelStyle: TextStyle(
                      color: Colors.blue, // 텍스트필드 라벨 색상 변경
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // 텍스트필드 모서리 둥글게
                      borderSide: BorderSide(
                        color: Colors.blue, // 텍스트필드 테두리 색상 변경
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _bodyController,
                  decoration: InputDecoration(
                    labelText: '상세 내용',
                    labelStyle: TextStyle(
                      color: Colors.blue, // 텍스트필드 라벨 색상 변경
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // 텍스트필드 모서리 둥글게
                      borderSide: BorderSide(
                        color: Colors.blue, // 텍스트필드 테두리 색상 변경
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    if (_selectedSymptom != null) {
                      symptom = _selectedSymptom!;
                    } else {
                      symptom = " 추가 증상 없음";
                    }
                    if (_selectedMedicine != null) {
                      medicine = _selectedMedicine!;
                    } else {
                      medicine = " 추가 의약품 없음";
                    }

                    if (_selectedPrescription == null) {
                      print("1번째다");
                      // List<Prescription>? prescriptions = await GetIt.I<MyDatabase>().getAllPrescriptions();
                      // // 처방 내역 데이터 가져오기
                      // Prescription firstPrescription = prescriptions.first; // 첫 번째 처방 가져오기
                      //
                      // prescriptionDataList = [ // 리스트로 감싸서 단일 항목 저장
                      //   {
                      //     '병의원(약국)명칭': firstPrescription.resHospitalName,
                      //     '처방 일자': firstPrescription.resTreatDate,
                      //     '의약품 명': firstPrescription.resPrescribeDrugName,
                      //     '처방약품 효능': firstPrescription.resPrescribeDrugEffect,
                      //     '투약일수': firstPrescription.resPrescribeDays,
                      //     // 필요한 다른 처방 정보 추가
                      //   }
                      // ];
                      print("처방내역이 선택되었습니다.");
                      print("prescriptionDataList: $prescriptionDataList");
                    } else {
                      print("처방내역이 실패되었습니다.");
                      prescriptionDataList = [];
                    }

                    await FirebaseFirestore.instance
                        .collection("patientTo${_doctorController.text}")
                        .add({
                      '환자 아이디': patientId,
                      '환자 이름': patientName,
                      '처방내역': prescriptionDataList,
                      '추가 증상': symptom,
                      '추가 의약품': medicine,
                      '상세 내용': _bodyController.text,
                    });

                    // 데이터 추가 후, 필드 초기화
                    _bodyController.clear();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check), // 확인 버튼에 아이콘 추가
                      SizedBox(width: 8.0),
                      Text('확인'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // 버튼 색상 변경
                    padding: EdgeInsets.symmetric(vertical: 16.0), // 버튼 패딩 조정
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _bodyController.dispose();
    super.dispose();
  }
}