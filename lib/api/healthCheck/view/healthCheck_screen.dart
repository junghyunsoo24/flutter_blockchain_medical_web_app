import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

import '../../../login/view/login_screen.dart';
import 'healthCheck_request_screen.dart';

class HealthCheckScreen extends ConsumerStatefulWidget{
  const HealthCheckScreen({Key? key}) : super(key: key);

  @override
  _HealthCheckScreenState createState() => _HealthCheckScreenState();
}

class _HealthCheckScreenState extends ConsumerState<HealthCheckScreen>{
  late List<HealthCheck> healthChecks = [];
  //late final PrescriptionViewModel _viewModel;
  late String userName;

  @override
  void initState() {
    super.initState();
    //_viewModel = PrescriptionViewModel();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    //final prescriptionList = await _viewModel.getPrescriptions(); //모든 의약품 가져오기
    print("처방내역 작동");
    setState(() {
      //prescriptions = prescriptionList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoProvider);
    userName = userInfo.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('$userName님 건강검진 내역', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: prescriptions.length,
          //     itemBuilder: (context, index) {
          //       Prescription prescription = prescriptions[index];
          //       return ListTile(
          //         title: Text("약국명 : "+prescription.resHospitalName),
          //         subtitle: Text('처방 일자 : ${prescription.resTreatDate}'),
          //         trailing: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Text('의약품 명: ${prescription.resPrescribeDrugName}'),
          //             SizedBox(width: 8.0),
          //             Text('처방약품 효능: ${prescription.resPrescribeDrugEffect}'),
          //             SizedBox(width: 8.0),
          //             Text('복약일수: ${prescription.resPrescribeDays}'),
          //             SizedBox(width: 8.0),
          //             Text('투약 횟수: ${prescription.count}'),
          //             SizedBox(width: 8.0),
          //             // IconButton(
          //             //   icon: Icon(Icons.delete),
          //             //   onPressed: () => _deleteMedicine(medicine),
          //             // ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HealthCheckRequest()),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.double_arrow_rounded, color: Colors.white70),
            SizedBox(height: 1), // 아이콘과 텍스트 사이의 간격 조절
            Text('불러오기', style: TextStyle(color: Colors.white, fontSize:10)), // 추가할 텍스트
          ],
        ),
        backgroundColor: Colors.redAccent,
      ),

    );
  }
}