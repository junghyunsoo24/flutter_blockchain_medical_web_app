import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/view/alarm_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/custom_app_bar.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/mypage/profile_screen.dart';
import '../../colors.dart';
import '../layout/default_layout.dart';
import 'home_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener(){
    setState((){
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar:CustomAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: '복용',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '마이 페이지',
          ),

        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          HomeScreen(),
          BoardListScreen(),
          AlarmListScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}