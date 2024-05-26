import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/deliver/view/deliver_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/view/emergency_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/view/DetailScreen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/view/prescription_history_list.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_list_screen.dart';

import '../../emergency/view/emergency_list_screen.dart';

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
                              MaterialPageRoute(builder: (context) => PrescriptionHistoryListScreen()),
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
                              Icons.send_rounded,
                              color: Colors.pink,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '의료데이터 전송',
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
                            child: IconButton(
                              icon: Icon(
                                Icons.send_to_mobile_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DeliverScreen()),
                                );
                              },
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EmergencyListScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '긴급데이터',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '비상상황 시 의료진이 열람하는 데이터입니다.',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.emergency_share, color: Colors.red, size: 50,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // 첫 번째 카루셀 영역
                    InkWell(
                      onTap: () {
                        // 첫 번째 카루셀 영역 클릭 시 이동할 페이지
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SymptomListScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            // Center(
                            //   child: Text('추가증상', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            // ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '추가 증상',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '회원님의 증상을 기록해주세요.',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
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
                          MaterialPageRoute(builder: (context) => PersonalMedicineListScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            // Center(
                            //   child: Text('개인구매 의약품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            // ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '개인구매 의약품',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '처방받은 의약품 외 약국에서 별도로 구매한 의약품을 등록해주세요.',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.medication_liquid, color: Colors.red, size: 50,),
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
                        ),
                        margin: EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            // Center(
                            //   child: Text('건강검진', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            // ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '건강검진',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '건강검진 기록을 보여드립니다.',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.health_and_safety_rounded, color: Colors.red, size: 50,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
