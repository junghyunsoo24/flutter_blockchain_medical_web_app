import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
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
    _loadHealthChecks();
  }

  Future<void> _loadHealthChecks() async {
    final query = GetIt.I<MyDatabase>().select(GetIt.I<MyDatabase>().healthChecks); // 모든 HealthCheck 행을 선택하는 쿼리 생성
    final healthCheckList = await query.get();
    setState(() {
      healthChecks = healthCheckList;
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
      body: healthChecks.isEmpty
          ? Center(child: Text('건강검진 내역이 없습니다.'))
          : ListView.builder(
        itemCount: healthChecks.length,
        itemBuilder: (context, index) {
          final healthCheck = healthChecks[index];
          final formattedDate = DateFormat('yyyy-MM-dd').format(healthCheck.resCheckupDate);
          return Card( // Card 위젯 추가
            child: ListTile(
              title: Text('검진기관: ${healthCheck.resOrganizationName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('검진일자: $formattedDate'),
                  Text('키: ${healthCheck.resHeight.toStringAsFixed(1)}cm'),
                  Text('몸무게: ${healthCheck.resWeight.toStringAsFixed(1)}kg'),
                  Text('허리둘레: ${healthCheck.resWaist.toStringAsFixed(1)}cm'),
                  Text('BMI: ${healthCheck.resBMI.toStringAsFixed(1)}'),
                  Text('시력: ${healthCheck.resSight}'),
                  Text('청력: ${healthCheck.resHearing}'),
                  Text('혈압: ${healthCheck.resBloodPressure}'),
                  Text('혈당(공복): ${healthCheck.resFastingBloodSuger.toStringAsFixed(1)} mg/dL'),
                  Text('총 콜레스테롤: ${healthCheck.resTotalCholesterol}'),
                ],
              ),
            ),
          );
        },
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