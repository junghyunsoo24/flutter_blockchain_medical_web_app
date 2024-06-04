import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/api/prescriptionHistory/view/prescription_history_request.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/viewModel/prescription_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/viewModel/personal_medicine_view_model.dart';

import '../../../deliver/blockchain_service.dart';
import '../../../login/view/login_screen.dart';

class PrescriptionHistoryListScreen extends ConsumerStatefulWidget {
  const PrescriptionHistoryListScreen({Key? key}) : super(key: key);

  @override
  _PrescriptionHistoryListScreenState createState() => _PrescriptionHistoryListScreenState();
}

class _PrescriptionHistoryListScreenState extends ConsumerState<PrescriptionHistoryListScreen> {
  late List<Prescription> prescriptions = [];
  late String userName;
  final blockchainService = BlockchainService();

  @override
  void initState() {
    super.initState();
    _loadPrescriptions();
  }

  Future<void> _loadPrescriptions() async {
    final query = GetIt.I<MyDatabase>().select(GetIt.I<MyDatabase>().prescriptions);
    final prescriptionsList = await query.get();
    setState(() {
      prescriptions = prescriptionsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoProvider);
    userName = userInfo.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('$userName님의 처방 내역', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: prescriptions.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.0),
                itemBuilder: (context, index) {
                  Prescription prescription = prescriptions[index];
                  var medicalData = {
                    "사용자": userName,
                    "병의원(약국)명칭": prescription.resHospitalName,
                    "처방 일자": prescription.resTreatDate,
                    "의약품 명": prescription.resPrescribeDrugName,
                    "처방약품 효능": prescription.resPrescribeDrugEffect,
                    "복약일수": prescription.resPrescribeDays,
                    "투약 횟수": prescription.resPrescribeDays
                  };
                  var originDataHash = blockchainService.calculateHash(medicalData);
                  //직접 계산한 해시값
                  print("============================================");
                  print('사용자 ID: $userName, 원본 해시값: $originDataHash');

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '병의원(약국)명칭: ${prescription.resHospitalName}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '처방 일자: ${prescription.resTreatDate}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Wrap(
                            spacing: 8.0,
                            children: [
                              Text(
                                '의약품 명: ${prescription.resPrescribeDrugName}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '처방약품 효능: ${prescription.resPrescribeDrugEffect}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '복약일수: ${prescription.resPrescribeDays}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '투약 횟수: ${prescription.resPrescribeDays}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await blockchainService.registerNodes();

                              var contractAddress = await blockchainService.storeHashOnBlockchain(blockchainService.calculateHash(medicalData), userName);
                              var dataHash = await blockchainService.getHashFromBlockchain(contractAddress!);
                              //블록체인에 저장된 해시값

                              // 3. 해시값을 비교하여 결과값 보여주기
                              bool isVerified = await blockchainService.verifyMedicalData(originDataHash, dataHash);
                              print("============================================");
                              print('받아온 해시값: $dataHash');

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('의료 데이터 검증 결과'),
                                  content: Text(isVerified
                                      ? '의료 데이터의 무결성이 확인되었습니다.'
                                      : '의료 데이터가 변조되었습니다.'),
                                  actions: [
                                    TextButton(
                                      child: Text('확인'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text('검증하기'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
            SizedBox(height: 1),
            Text('불러오기', style: TextStyle(color: Colors.white, fontSize: 10)),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
