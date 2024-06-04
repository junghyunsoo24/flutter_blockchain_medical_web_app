import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login/view/login_screen.dart';

class DoctorEditProfileScreen extends ConsumerWidget {
  const DoctorEditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorInfo = ref.watch(doctorInfoProvider);
    final nameController = TextEditingController(text: doctorInfo.name);
    final fieldController = TextEditingController(text: doctorInfo.field);
    final hospitalController = TextEditingController(text: doctorInfo.hospital);
    final introductionController = TextEditingController(text: doctorInfo.introduction);


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
              controller: fieldController,
              decoration: InputDecoration(labelText: '전공분야'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: hospitalController,
              decoration: InputDecoration(labelText: '병원'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: introductionController,
              decoration: InputDecoration(labelText: '소개'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // 변경된 사용자 정보 가져오기 (TextEditingController에서)
                  String updatedName = nameController.text;
                  String updatedField = fieldController.text;
                  String updatedHospital = hospitalController.text;
                  String updatedIntroduction = introductionController.text;


                  // userInfoProvider를 통해 상태 업데이트
                  ref.read(doctorInfoProvider.notifier).updateDoctorInfo(
                    name: updatedName,
                    field: updatedField,
                    hospital: updatedHospital,
                    introduction: updatedIntroduction,
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