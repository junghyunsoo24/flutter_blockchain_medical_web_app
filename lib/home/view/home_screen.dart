import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/provider/user_me_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Center(
    //   child: ElevatedButton(
    //     onPressed: (){
    //       ref.read(userMeProvider.notifier).logout();
    //     },
    //     child: const Text('메인 화면'),
    //   ),
    // );
    return Container(
      margin: EdgeInsets.all(20.0), // 상하좌우 여백 설정
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.lightBlueAccent, // 테두리 색상 설정
          width: 2, // 테두리 두께 설정
        ),
        borderRadius: BorderRadius.circular(20), // 모서리 둥글기 설정
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0), // 내부 여백 설정
        child: Text('내용'), // 내부 컨텐츠
      ),
    );
    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: Size.fromHeight(130.0),//appBar 사이즈 조정
    //     child: AppBar(
    //       backgroundColor: Colors.transparent,//배경 투명색
    //       elevation: 0,//appBar 그림자
    //       flexibleSpace: Container(//배경색 그라데이션
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //               begin: Alignment.centerLeft,
    //               end: Alignment.centerRight,
    //               colors: [
    //                 Colors.lightBlueAccent,
    //                 Colors.blueAccent,
    //               ]
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}