import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_category_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_detail_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_entire_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/repository/emergency_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/view/emergency_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/viewModel/emergency_view_model.dart';

import '../../login/model/user_info.dart';
import '../../login/view/login_screen.dart';
import '../model/emergency.dart';
import '../viewModel/emergency_entire_view_model.dart';

final emergencyViewModelProvider =
ChangeNotifierProvider((ref) => EmergencyViewModel(EmergencyRepository()));

class EmergencyDataHistoryScreen extends ConsumerStatefulWidget {

  const EmergencyDataHistoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EmergencyDataHistoryScreen> createState() => _EmergencyDataHistoryScreenState();
}

class _EmergencyDataHistoryScreenState extends ConsumerState<EmergencyDataHistoryScreen> {
  @override
  void initState() {
    super.initState();
    _fetchEmergency(ref.read(userInfoProvider).userId);
  }

  void _fetchEmergency(String? userId) {
    ref.read(emergencyViewModelProvider).fetchEmergencyViewHistory(userId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(emergencyViewModelProvider);
    final userInfo = ref.watch(userInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('긴급 데이터 열람 기록'),
        backgroundColor: Colors.blue[50],
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '회원님의 긴급 데이터를 조회한 의료진을 알 수 있어요!',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _buildEmergencyList(viewModel, userInfo),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => EmergencyScreen()),
      //     );
      //   },
      //   backgroundColor: Colors.blue[50],
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _buildEmergencyList(EmergencyViewModel viewModel, UserInformation userInfo) {
    if (viewModel.emergencyData.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '아직 회원님의 긴급 데이터를 열람한 의료진이 없습니다.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: viewModel.emergencyData.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final emergency = viewModel.emergencyData[index];
          print(emergency.reason);
          return _buildEmergencyItem(emergency, userInfo);
        },
      );
    }
  }
  Widget _buildEmergencyItem(Emergency emergency, UserInformation userInfo) {
    return Stack(
      children: [
        GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width - 32.0,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blue),
                    const SizedBox(width: 8.0),
                    Text(
                      emergency.doctorId ?? '의사 ID 없음',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (emergency.date != null)
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.blue),
                          const SizedBox(width: 8.0),
                          Text(
                            DateFormat('yy-MM-dd').format(emergency.date!),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.question_mark_rounded, color: Colors.blue),
                    const SizedBox(width: 8.0),
                    Text(
                      emergency.reason ?? '',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.content_paste_search_sharp, color: Colors.blue),
                    const SizedBox(width: 8.0),
                    Text(
                      '열람한 데이터:${emergency.content}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
