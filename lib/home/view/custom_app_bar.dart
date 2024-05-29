import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../login/view/login_screen.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
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

    return PreferredSize(
      preferredSize: Size.fromHeight(130.0),
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
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))//appBar borderRadius
          ),
        ),
        leading: Padding(
          padding:  const EdgeInsets.only(top: 10.0, left: 20.0), // 상단 여백 추가
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0='),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0), // 상단 여백 추가,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$userName님 환영합니다.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Text(
                '나만의 건강 블록에 오신 걸 환영합니다!',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          )
        ),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(130.0);
}
