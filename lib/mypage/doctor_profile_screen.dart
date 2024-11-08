import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_category_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/my_board_list.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/my_comment_list.dart';

import '../login/view/login_screen.dart';
import 'doctor_edit_profile_screen.dart';

class DoctorProfileScreen extends ConsumerWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorInfo = ref.watch(doctorInfoProvider);
    final userName = doctorInfo.name;
    final userField = doctorInfo.field;
    final userHospital = doctorInfo.hospital;
    final userIntroduction = doctorInfo.introduction;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0='),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$userName님', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('전공분야 $userField', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('병원 $userHospital', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('소개 $userIntroduction', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('게시물 관리', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>MyCommentList())
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.comment, size: 24),
                          SizedBox(width: 16),
                          Text('내가 댓글단 게시글', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                child: Row( // Row 위젯 추가
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 버튼 사이 공간 최대로
                  children: [
                    Expanded( // 버튼을 화면 너비에 맞게 확장
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DoctorEditProfileScreen()),
                          );
                        },
                        icon: Icon(Icons.edit),
                        label: Text('개인정보 수정'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[50],
                        ),
                      ),
                    ),
                    Expanded( // 버튼을 화면 너비에 맞게 확장
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.logout),
                        label: Text('로그아웃'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[50],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}