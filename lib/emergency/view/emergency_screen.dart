import 'package:flutter/cupertino.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/model/emergency.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/viewModel/emergency_entire_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/viewModel/emergency_view_model.dart';

import '../../login/view/login_screen.dart';
final emergencyViewModelProvider = ChangeNotifierProvider((ref) => EmergencyInsertViewModel());

class EmergencyScreen extends ConsumerWidget {

  final Emergency? emergency;
  const EmergencyScreen({super.key, this.emergency});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(emergencyViewModelProvider);
    String userId = ref.read(userInfoProvider).userId;

    void _showSuccessSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('긴급데이터 등록이 완료되었습니다.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    // void _navigateToBoardListScreen() {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => BoardListScreen(category: viewModel.selectedCategory),
    //     ),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('긴급데이터 등록'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLines: null,
                decoration: InputDecoration(
                  labelText: '본인의 특이사항을 자유롭게 적어주세요.'
                      '긴급 상황 시 의료진이 참고할 사항입니다.',
                  border: OutlineInputBorder(),
                ),
                onChanged: viewModel.setEmergency,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.submitEmergencyForm(userId).then((_) {
                      _showSuccessSnackBar();
                      //_navigateToBoardListScreen();
                    }).catchError((error) {
                      // 에러 처리
                    });
                  },
                  child: Text('등록'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

