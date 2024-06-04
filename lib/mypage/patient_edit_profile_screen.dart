import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import 'package:get_it/get_it.dart';
import '../database/drift_database.dart';
import '../login/view/login_screen.dart';

class PatientEditProfileScreen extends ConsumerWidget {
  const PatientEditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final nameController = TextEditingController(text: userInfo.name);
    final heightController = TextEditingController(text: userInfo.height.toString());
    final weightController = TextEditingController(text: userInfo.weight.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('개인정보 수정'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: heightController,
              decoration: InputDecoration(labelText: '키 (cm)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: weightController,
              decoration: InputDecoration(labelText: '몸무게 (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // 변경된 사용자 정보 가져오기 (TextEditingController에서)
                  String updatedName = nameController.text;
                  double updatedHeight = double.tryParse(heightController.text) ?? 0.0;
                  double updatedWeight = double.tryParse(weightController.text) ?? 0.0;

                  // userInfoProvider를 통해 상태 업데이트
                  ref.read(userInfoProvider.notifier).updateUserInfo(
                    name: updatedName,
                    height: updatedHeight,
                    weight: updatedWeight,
                  );

                  Navigator.pop(context); // 변경 사항 저장 후 화면 종료
                },
                child: Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}