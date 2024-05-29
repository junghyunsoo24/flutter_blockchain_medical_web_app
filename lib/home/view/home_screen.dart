import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/view/emergency_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/view/DetailScreen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/api/prescriptionHistory/view/prescription_history_list.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_list_screen.dart';

import '../../deliver/view/web_deliver_screen.dart';
import '../../emergency/view/emergency_list_screen.dart';
import '../../login/view/login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final userName = userInfo.name;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(5.0),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '추가 증상',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.sick_rounded, color: Colors.red, size: 40),
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
                              borderRadius: BorderRadius.circular(10),
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
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.emergency_share, color: Colors.red, size: 40),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(5.0),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '개인구매 의약품',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
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
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.medication_liquid, color: Colors.red, size: 40),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '의료진에게 $userName님의 데이터를 전송하세요!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ),// 두 영역 사이의 간격
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '건강 서비스',
                    style: TextStyle(
                      fontSize: 18,
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
                    height: 150.0,
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
                                    '처방 내역',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '건강보험공단에서 제공하는 데이터입니다.',
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
                                    '진료내용',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '건강보험공단에서 제공하는 데이터입니다.',
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
                    InkWell(
                      onTap: () {
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

    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Container(
    //       margin: EdgeInsets.all(5.0), // 상하좌우 여백 설정
    //       decoration: BoxDecoration(
    //         border: Border.all(
    //           color: Colors.white, // 테두리 색상 설정
    //           width: 2, // 테두리 두께 설정
    //         ),
    //         borderRadius: BorderRadius.circular(20), // 모서리 둥글기 설정
    //         // color: Color(0xFFE1F5FE)
    //       ),
    //       child: Padding(
    //         padding: EdgeInsets.all(3.0), // 내부 여백 설정
    //         child: Column(
    //           children: <Widget>[
    //             SizedBox(
    //               height: 150,
    //               child: InkWell(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(builder: (context) => SymptomListScreen()),
    //                   );
    //                 },
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     border: Border.all(color: Colors.lightBlueAccent),
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                   margin: EdgeInsets.all(5.0),
    //                   child: Stack(
    //                     children: [
    //                       Center(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               '추가 증상',
    //                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                             ),
    //                             SizedBox(height: 8.0),
    //                             Text(
    //                               '회원님읮 증상을 기록해주세요.',
    //                               style: TextStyle(fontSize: 12, color: Colors.grey),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Align(
    //                         alignment: Alignment.bottomRight,
    //                         child: Padding(
    //                           padding: EdgeInsets.all(8.0),
    //                           child: Icon(Icons.sick_rounded, color: Colors.red, size: 50),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 150,
    //               child: InkWell(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(builder: (context) => EmergencyListScreen()),
    //                   );
    //                 },
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     border: Border.all(color: Colors.lightBlueAccent),
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                   margin: EdgeInsets.all(5.0),
    //                   child: Stack(
    //                     children: [
    //                       Center(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               '긴급데이터',
    //                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                             ),
    //                             SizedBox(height: 8.0),
    //                             Text(
    //                               '비상상황 시 의료진이 열람하는 데이터입니다.',
    //                               style: TextStyle(fontSize: 12, color: Colors.grey),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Align(
    //                         alignment: Alignment.bottomRight,
    //                         child: Padding(
    //                           padding: EdgeInsets.all(8.0),
    //                           child: Icon(Icons.emergency_share, color: Colors.red, size: 50),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 70,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   gradient: LinearGradient(
    //                     begin: Alignment.centerLeft,
    //                     end: Alignment.centerRight,
    //                     colors: [
    //                       Color(0xFFB9E8FF),
    //                       Colors.blue,
    //                     ],
    //                   ),
    //                   borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    //                 ),
    //                 margin: EdgeInsets.all(5.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Icon(
    //                           Icons.send_rounded,
    //                           color: Colors.pink,
    //                         ),
    //                         SizedBox(width: 8.0),
    //                         Text(
    //                           '의료데이터 전송',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     Expanded(
    //                       child: Align(
    //                         alignment: Alignment.centerRight,
    //                         child: IconButton(
    //                           icon: Icon(
    //                             Icons.send_to_mobile_rounded,
    //                             color: Colors.white,
    //                           ),
    //                           onPressed: () {
    //                             Navigator.push(
    //                               context,
    //                               MaterialPageRoute(builder: (context) => WebDeliverScreen()),
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             CarouselSlider(
    //               options: CarouselOptions(
    //                 // height: 150,
    //                 // viewportFraction: 0.9,
    //                 // enableInfiniteScroll: false,
    //                 height: 150.0,
    //                 enlargeCenterPage: true,
    //                 //autoPlay: true,
    //                 aspectRatio: 16 / 9,
    //                 //autoPlayCurve: Curves.fastOutSlowIn,
    //                 enableInfiniteScroll: true,
    //                 //autoPlayAnimationDuration: Duration(milliseconds: 800),
    //                 viewportFraction: 0.7,
    //               ),
    //               items: [
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(builder: (context) => PrescriptionHistoryListScreen()),
    //                     );
    //                   },
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.lightBlueAccent),
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                     margin: EdgeInsets.all(5.0),
    //                     child: Stack(
    //                       children: [
    //                         Center(
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Text(
    //                                 '처방 내역',
    //                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                               ),
    //                               SizedBox(height: 8.0),
    //                               Text(
    //                                 '건강보험공단에서 제공하는 데이터입니다.',
    //                                 style: TextStyle(fontSize: 12, color: Colors.grey),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Align(
    //                           alignment: Alignment.bottomRight,
    //                           child: Padding(
    //                             padding: EdgeInsets.all(8.0),
    //                             child: Icon(Icons.emergency_share, color: Colors.red, size: 50,),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(builder: (context) => PrescriptionHistoryListScreen()),
    //                     );
    //                   },
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.lightBlueAccent),
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                     margin: EdgeInsets.all(5.0),
    //                     child: Stack(
    //                       children: [
    //                         Center(
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Text(
    //                                 '진료내용',
    //                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                               ),
    //                               SizedBox(height: 8.0),
    //                               Text(
    //                                 '건강보험공단에서 제공하는 데이터입니다.',
    //                                 style: TextStyle(fontSize: 12, color: Colors.grey),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Align(
    //                           alignment: Alignment.bottomRight,
    //                           child: Padding(
    //                             padding: EdgeInsets.all(8.0),
    //                             child: Icon(Icons.emergency_share, color: Colors.red, size: 50,),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(builder: (context) => PersonalMedicineListScreen()),
    //                     );
    //                   },
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.lightBlueAccent),
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                     margin: EdgeInsets.all(5.0),
    //                     child: Stack(
    //                       children: [
    //                         // Center(
    //                         //   child: Text('개인구매 의약품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    //                         // ),
    //                         Center(
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Text(
    //                                 '개인구매 의약품',
    //                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                               ),
    //                               SizedBox(height: 8.0),
    //                               Text(
    //                                 '처방받은 의약품 외 약국에서 별도로 구매한 의약품을 등록해주세요.',
    //                                 style: TextStyle(fontSize: 12, color: Colors.grey),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Align(
    //                           alignment: Alignment.bottomRight,
    //                           child: Padding(
    //                             padding: EdgeInsets.all(8.0),
    //                             child: Icon(Icons.medication_liquid, color: Colors.red, size: 50,),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(builder: (context) => DetailScreen()),
    //                     );
    //                   },
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.lightBlueAccent),
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                     margin: EdgeInsets.all(5.0),
    //                     child: Stack(
    //                       children: [
    //                         // Center(
    //                         //   child: Text('건강검진', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    //                         // ),
    //                         Center(
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Text(
    //                                 '건강검진',
    //                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                               ),
    //                               SizedBox(height: 8.0),
    //                               Text(
    //                                 '건강검진 기록을 보여드립니다.',
    //                                 style: TextStyle(fontSize: 12, color: Colors.grey),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Align(
    //                           alignment: Alignment.bottomRight,
    //                           child: Padding(
    //                             padding: EdgeInsets.all(8.0),
    //                             child: Icon(Icons.health_and_safety_rounded, color: Colors.red, size: 50,),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
