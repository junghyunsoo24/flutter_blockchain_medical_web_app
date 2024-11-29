import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/api/diagnosis/diagnosis.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/api/healthCheck/view/healthCheck_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/api/prescriptionHistory/view/prescription_history_list.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_list_screen.dart';
import '../../deliver/view/mobile/web_deliver_screen.dart';
import '../../emergency/view/emergency_list_screen.dart';
import '../../login/view/login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final userInfo = ref.watch(userInfoProvider);
    final userName = userInfo.name;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: screenWidth * 0.005,
            ),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.23,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SymptomListScreen()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightBlueAccent),
                              borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            ),
                            margin: EdgeInsets.all(screenWidth * 0.01),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '추가 증상',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.033),
                                      ),
                                      // SizedBox(height: 8.0),
                                      // Text(
                                      //   '회원님의 증상을 기록해주세요.',
                                      //   style: TextStyle(fontSize: 12, color: Colors.grey),
                                      // ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.01),
                                    child: Icon(Icons.sick_rounded, color: Colors.red, size: screenWidth * 0.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(width: 5), // 두 영역 사이의 간격
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EmergencyListScreen()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightBlueAccent),
                              borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            ),
                            margin: EdgeInsets.all(screenWidth * 0.01),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '긴급데이터',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.033),
                                      ),
                                      // SizedBox(height: 8.0),
                                      // Text(
                                      //   '비상상황 시 의료진이 열람하는 데이터입니다.',
                                      //   style: TextStyle(fontSize: 12, color: Colors.grey),
                                      // ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.01),
                                    child: Icon(Icons.emergency_share, color: Colors.red, size: screenWidth * 0.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PersonalMedicineListScreen()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightBlueAccent),
                              borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            ),
                            margin: EdgeInsets.all(screenWidth * 0.01),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '개인구매 의약품',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.033)
                                      ),
                                      // SizedBox(height: 8.0),
                                      // Text(
                                      //   '비상상황 시 의료진이 열람하는 데이터입니다.',
                                      //   style: TextStyle(fontSize: 12, color: Colors.grey),
                                      // ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.01),
                                    child: Icon(Icons.medication_liquid, color: Colors.red, size: screenWidth * 0.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: Text(
                    '의료진에게 $userName님의 데이터를 전송하세요!',
                    style: TextStyle(
                      fontSize: screenWidth * 0.027,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ),// 두 영역 사이의 간격
                SizedBox(
                  height: screenHeight * 0.12,
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
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(screenWidth * 0.03)),
                    ),
                    margin: EdgeInsets.all(screenWidth * 0.01),
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
                                fontSize: screenWidth * 0.035
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
                                  MaterialPageRoute(builder: (context) => WebDeliverScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: Text(
                    '건강 서비스',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    // height: 150,
                    // viewportFraction: 0.9,
                    // enableInfiniteScroll: false,
                    height: screenHeight * 0.24,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    viewportFraction: 0.8,
                  ),
                  items: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrescriptionHistoryListScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        margin: EdgeInsets.all(screenWidth * 0.01),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '처방 내역',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05),
                                  ),
                                  Text(
                                    '건강보험공단에서 제공하는 데이터입니다.',
                                    style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.01),
                                child: Icon(Icons.emergency_share, color: Colors.red, size: screenWidth * 0.15,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Diagnosis()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        margin: EdgeInsets.all(screenWidth * 0.01),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '진료내용',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05),
                                  ),
                                  Text(
                                    '건강보험공단에서 제공하는 데이터입니다.',
                                    style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.01),
                                child: Icon(Icons.emergency_share, color: Colors.red, size: screenWidth * 0.15,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HealthCheckScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        margin: EdgeInsets.all(screenWidth * 0.01),
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
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '건강검진 기록을 보여드립니다.',
                                    style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.01),
                                child: Icon(Icons.health_and_safety_rounded, color: Colors.red, size: screenWidth * 0.15,),
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