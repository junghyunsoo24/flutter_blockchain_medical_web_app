import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/MedicalView/DetailScreen.dart';
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
      margin: EdgeInsets.all(5.0), // 상하좌우 여백 설정
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // 테두리 색상 설정
          width: 2, // 테두리 두께 설정
        ),
        borderRadius: BorderRadius.circular(20), // 모서리 둥글기 설정
      ),
      child: Padding(
        padding: EdgeInsets.all(3.0), // 내부 여백 설정
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.local_hospital_rounded, color: Colors.red),
                    ),
                    Expanded(
                      child: ExpandableText(
                        '진료 내용',
                        expandText: '더보기',
                        maxLines: 2,
                        linkColor: Colors.blueAccent,

                      ),

                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen()),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),

                  ],
                ),
              ),

            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(20)
                ),
                margin: EdgeInsets.all(5.0),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(20)
                ),
                margin: EdgeInsets.all(5.0),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(20)
                ),
                margin: EdgeInsets.all(5.0),
              ),
            ),
          ],
        ),
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