import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'emergency_data_history_screen.dart';

final emergencyViewModelProvider =
ChangeNotifierProvider((ref) => EmergencyViewModel(EmergencyRepository()));

class EmergencyListScreen extends ConsumerStatefulWidget {

  const EmergencyListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EmergencyListScreen> createState() => _EmergencyListScreenState();
}

class _EmergencyListScreenState extends ConsumerState<EmergencyListScreen> {
  @override
  void initState() {
    super.initState();
    _fetchEmergency(ref.read(userInfoProvider).userId);
  }

  void _fetchEmergency(String? userId) {
    ref.read(emergencyViewModelProvider).fetchEmergency(userId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(emergencyViewModelProvider);
    final userInfo = ref.watch(userInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('긴급 데이터'),
        backgroundColor: Colors.blue[50],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmergencyDataHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '회원님의 특이사항을 저장해보세요.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '긴급 상황 시 중요한 데이터가 됩니다.',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmergencyScreen()),
          );
        },
        backgroundColor: Colors.blue[50],
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmergencyList(EmergencyViewModel viewModel, UserInformation userInfo) {
    if (viewModel.emergency == null || viewModel.emergency!.content.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '아직 등록된 데이터가 없습니다.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '긴급데이터를 등록해보세요!',
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
        itemCount: 1, // 단일 Emergency 항목만 표시
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final emergency = viewModel.emergency!;
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
                Text(
                  emergency.content,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _showDeleteDialog(emergency, userInfo);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showDeleteDialog(Emergency emergency, UserInformation userInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('게시물 삭제'),
        content: const Text('게시물을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(emergencyViewModelProvider).deleteMyEmergencyData(ref.read(userInfoProvider).userId);
              Navigator.of(context).pop();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
