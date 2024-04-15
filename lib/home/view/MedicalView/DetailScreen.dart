import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 예시 데이터 리스트
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<String> dates = <String>['2023-04-01', '2023-04-02', '2023-04-03'];
    final List<String> pillName = <String>['타이레놀 외 3종', '영진세파클러캅셀 외 4종', '팜피린 외 2종'];

    return Scaffold(
      appBar: AppBar(
        title: Text('처방 내용', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue),
              borderRadius: BorderRadius.circular(20), // 둥근 모서리
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Chip(
                  label: Text('처방조제', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),),
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // 더 둥근 모서리
                    side: BorderSide.none,
                  ),
                ),
                Text('${entries[index]} 약국', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(dates[index], style: TextStyle(fontSize: 12)),
                Text(pillName[index], style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}