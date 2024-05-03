import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/view/DetailScreen.dart';
import '../../user/provider/user_me_provider.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Center(
    //   child: ElevatedButton(
    //     onPressed: (){
    //       ref.read(userMeProvider.notifier).logout();
    //     },
    //     child: const Text('게시판'),
    //   ),
    // );
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.white,
        //   width: 2,
        // ),
        //color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue.withOpacity(0.8), // 그림자 색상
                      width: 2.0, // 그림자 두께
                      style: BorderStyle.solid, // 그림자 스타일
                      // 그림자 속성
                      // offset: Offset(0, 2), // 그림자 위치 (x, y)
                      // blurRadius: 50, // 그림자 흐림 정도
                      // spreadRadius: 0, // 그림자 크기
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.dashboard, color: Colors.blueAccent, size: 35),
                    SizedBox(width: 8),
                    Text(
                      '전체 게시판',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: 10),
          // SizedBox(
          //   height: 60,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => DetailScreen()),
          //       );
          //     },
          //     child: Container(
          //       // decoration: BoxDecoration(
          //       //   boxShadow: [
          //       //     BoxShadow(
          //       //       color: Colors.white54.withOpacity(0.2), // 시작 색상
          //       //       offset: Offset(0, 2), // 그림자 위치 (x, y)
          //       //       blurRadius: 90, // 그림자 흐림 정도
          //       //       spreadRadius: 0, // 그림자 크기
          //       //     ),
          //       //     BoxShadow(
          //       //       color: Colors.blue.withOpacity(0.8), // 끝 색상
          //       //       offset: Offset(0, 2), // 그림자 위치 (x, y)
          //       //       blurRadius: 50, // 그림자 흐림 정도
          //       //       spreadRadius: 0, // 그림자 크기
          //       //     ),
          //       //   ],
          //       //   borderRadius: BorderRadius.circular(10),
          //       //
          //       // ),
          //       decoration: BoxDecoration(
          //         border: Border(
          //           bottom: BorderSide(
          //             color: Colors.blue.withOpacity(0.8), // 그림자 색상
          //             width: 2.0, // 그림자 두께
          //             style: BorderStyle.solid, // 그림자 스타일
          //             // 그림자 속성
          //             // offset: Offset(0, 2), // 그림자 위치 (x, y)
          //             // blurRadius: 50, // 그림자 흐림 정도
          //             // spreadRadius: 0, // 그림자 크기
          //           ),
          //         ),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Icon(Icons.child_care_rounded, color: Colors.blueAccent, size:35),
          //           SizedBox(width: 8),
          //           Text(
          //             '영유아 게시판',
          //             style: TextStyle(
          //               fontFamily: 'NotoSans',
          //               fontWeight: FontWeight.w700,
          //               fontSize: 20,
          //               color: Colors.blueGrey,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue.withOpacity(0.8), // 그림자 색상
                      width: 2.0, // 그림자 두께
                      style: BorderStyle.solid, // 그림자 스타일
                      // 그림자 속성
                      // offset: Offset(0, 2), // 그림자 위치 (x, y)
                      // blurRadius: 50, // 그림자 흐림 정도
                      // spreadRadius: 0, // 그림자 크기
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                // decoration: BoxDecoration(
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.white54.withOpacity(0.2), // 시작 색상
                //       offset: Offset(0, 2), // 그림자 위치 (x, y)
                //       blurRadius: 90, // 그림자 흐림 정도
                //       spreadRadius: 0, // 그림자 크기
                //     ),
                //     BoxShadow(
                //       color: Colors.blue.withOpacity(0.8), // 끝 색상
                //       offset: Offset(0, 2), // 그림자 위치 (x, y)
                //       blurRadius: 50, // 그림자 흐림 정도
                //       spreadRadius: 0, // 그림자 크기
                //     ),
                //   ],
                //   borderRadius: BorderRadius.circular(10),
                //
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.
                    elderly_rounded, color: Colors.blueAccent, size:35),
                    SizedBox(width: 8),
                    Text(
                      '노년층 게시판',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontWeight:  FontWeight.w700,
                        fontSize: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue.withOpacity(0.8), // 그림자 색상
                      width: 2.0, // 그림자 두께
                      style: BorderStyle.solid, // 그림자 스타일
                      // 그림자 속성
                      // offset: Offset(0, 2), // 그림자 위치 (x, y)
                      // blurRadius: 50, // 그림자 흐림 정도
                      // spreadRadius: 0, // 그림자 크기
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                // decoration: BoxDecoration(
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.white54.withOpacity(0.2), // 시작 색상
                //       offset: Offset(0, 2), // 그림자 위치 (x, y)
                //       blurRadius: 90, // 그림자 흐림 정도
                //       spreadRadius: 0, // 그림자 크기
                //     ),
                //     BoxShadow(
                //       color: Colors.blue.withOpacity(0.8), // 끝 색상
                //       offset: Offset(0, 2), // 그림자 위치 (x, y)
                //       blurRadius: 50, // 그림자 흐림 정도
                //       spreadRadius: 0, // 그림자 크기
                //     ),
                //   ],
                //   borderRadius: BorderRadius.circular(10),
                //
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.pregnant_woman, color: Colors.blueAccent, size:35),
                    SizedBox(width: 8),
                    Text(
                      '임산부 게시판',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 나머지 2개의 게시판 목록 추가
        ],
      ),
    );
  }
}