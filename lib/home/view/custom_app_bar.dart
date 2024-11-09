import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/deliver/view/window/second_window_page.dart';
import 'dart:io';
import '../../deliver/notification.dart';
import '../../deliver/view/mobile/second.dart';
import '../../login/view/login_screen.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final doctorInfo = ref.watch(doctorInfoProvider);
    late String userName;
    if (Platform.isAndroid) {
      userName = userInfo.name;
    }
    else if(Platform.isWindows){
      userName = doctorInfo.name;
    }
    else{
      userName = "";
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = screenHeight * 0.8;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFB9E8FF),
                    Colors.blue,
                  ]),
          ),
        ),
        leading: Padding(
          padding:  EdgeInsets.only(left: screenWidth * 0.03), // 상단 여백 추가
          child: CircleAvatar(
            radius: screenWidth * 0.1,
            backgroundImage: NetworkImage('https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0='),
          ),
        ),
        title: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$userName님 환영합니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                Text(
                  '나만의 건강 블록에 오신 걸 환영합니다!',
                  style: TextStyle(fontSize: screenWidth * 0.03,
                  ),
                ),
              ],
            )
        ),
        actions: <Widget>[
          IconButton(onPressed: (){
            Map<String, dynamic>? data = FlutterLocalNotification.lastPayload;
            if (Platform.isWindows) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondWindowPage()),
              );
            }
            else if(Platform.isAndroid){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage(payload: data)),
              );
            }
          }, icon: Icon(Icons.notifications_active,
            size: screenWidth * 0.08,
          ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    final screenHeight = WidgetsBinding.instance.window.physicalSize.height /
        WidgetsBinding.instance.window.devicePixelRatio;
    return Size.fromHeight(screenHeight * 0.2);
  }
}