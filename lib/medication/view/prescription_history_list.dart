import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/view/prescription_history_request.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/viewModel/prescription_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/viewModel/personal_medicine_view_model.dart';

class PrescriptionHistoryListScreen extends StatefulWidget{
  const PrescriptionHistoryListScreen({Key? key}) : super(key: key);

  @override
  _PrescriptionHistoryListScreenState createState() => _PrescriptionHistoryListScreenState();
}

class _PrescriptionHistoryListScreenState extends State<PrescriptionHistoryListScreen>{
  late List<Prescription> prescriptions = [];
  late final PrescriptionViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = PrescriptionViewModel();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    final prescriptionList = await _viewModel.getPrescriptions(); //모든 의약품 가져오기
    print("처방내역 작동");
    print(prescriptionList);
    setState(() {
      prescriptions = prescriptionList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('김정민 님의 처방내역', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                Prescription prescription = prescriptions[index];
                return ListTile(
                  title: Text("약국명 : "+prescription.resHospitalName),
                  subtitle: Text('처방 일자 : ${prescription.resTreatDate}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('의약품 명: ${prescription.resPrescribeDrugName}'),
                      SizedBox(width: 8.0),
                      Text('처방약품 효능: ${prescription.resPrescribeDrugEffect}'),
                      SizedBox(width: 8.0),
                      Text('복약일수: ${prescription.resPrescribeDays}'),
                      SizedBox(width: 8.0),
                      Text('투약 횟수: ${prescription.count}'),
                      SizedBox(width: 8.0),
                      // IconButton(
                      //   icon: Icon(Icons.delete),
                      //   onPressed: () => _deleteMedicine(medicine),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PrescriptionHistoryRequest()),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.double_arrow_rounded, color: Colors.white70),
            SizedBox(height: 4), // 아이콘과 텍스트 사이의 간격 조절
            Text('불러오기', style: TextStyle(color: Colors.white)), // 추가할 텍스트
          ],
        ),
        backgroundColor: Colors.redAccent,
      ),

    );
  }
}