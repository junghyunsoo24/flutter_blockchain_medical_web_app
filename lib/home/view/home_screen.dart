import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/MedicalView/DetailScreen.dart';
import '../../user/provider/user_me_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5.0), // 상하좌우 여백 설정
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white, // 테두리 색상 설정
              width: 2, // 테두리 두께 설정
            ),
            borderRadius: BorderRadius.circular(20), // 모서리 둥글기 설정
            // color: Color(0xFFE1F5FE)
          ),
          child: Padding(
            padding: EdgeInsets.all(3.0), // 내부 여백 설정
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
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
                          child: Icon(Icons.medication_liquid, color: Colors.red),
                        ),
                        Expanded(
                          child: ExpandableText(
                            '처방 내역',
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
                SizedBox(
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlueAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_hospital_rounded,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '진료내용',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFB9E8FF),
                          Colors.blue,
                        ],
                      ),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                    margin: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.monitor_heart,
                              color: Colors.pink,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '건강검진 기록',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    viewportFraction: 0.9,
                    enableInfiniteScroll: false,
                  ),
                  items: [
                    // 첫 번째 카루셀 영역
                    InkWell(
                      onTap: () {
                        // 첫 번째 카루셀 영역 클릭 시 이동할 페이지
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.white.withOpacity(0.5), // 흰색 그림자
                          //     spreadRadius: 1,
                          //     blurRadius: 10,
                          //     offset: Offset(0, 3), // 그림자 위치 (수직으로 아래로)
                          //   ),
                          //   BoxShadow(
                          //     color: Colors.blue.withOpacity(0.5), // 파란색 그림자
                          //     spreadRadius: 1,
                          //     blurRadius: 40,
                          //     offset: Offset(0, 3), // 그림자 위치 (수직으로 아래로)
                          //   ),
                          //],
                        ),
                        margin: EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            Center(
                              child: Text('추가증상 등록', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.sick_rounded, color: Colors.red, size: 50,),
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // 첫 번째 카루셀 영역 클릭 시 이동할 페이지
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.white.withOpacity(0.5), // 흰색 그림자
                          //     spreadRadius: 1,
                          //     blurRadius: 10,
                          //     offset: Offset(0, 3), // 그림자 위치 (수직으로 아래로)
                          //   ),
                          //   BoxShadow(
                          //     color: Colors.blue.withOpacity(0.5), // 파란색 그림자
                          //     spreadRadius: 1,
                          //     blurRadius: 40,
                          //     offset: Offset(0, 3), // 그림자 위치 (수직으로 아래로)
                          //   ),
                          // ],
                        ),
                        margin: EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            Center(
                              child: Text('특이사항 등록', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.pending_actions, color: Colors.red, size: 50,),
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // 첫 번째 카루셀 영역 클릭 시 이동할 페이지
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.white.withOpacity(0.5), // 흰색 그림자
                          //     spreadRadius: 1,
                          //     blurRadius: 10,
                          //     offset: Offset(0, 3), // 그림자 위치 (수직으로 아래로)
                          //   ),
                          //   BoxShadow(
                          //     color: Colors.blue.withOpacity(0.5), // 파란색 그림자
                          //     spreadRadius: 1,
                          //     blurRadius: 40,
                          //     offset: Offset(0, 3), // 그림자 위치 (수직으로 아래로)
                          //   ),
                          // ],

                        ),
                        margin: EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            Center(
                              child: Text('의료진 조회', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.person_2_rounded, color: Colors.red, size: 50,),
                              ),
                            )
                          ],
                        ),

                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
