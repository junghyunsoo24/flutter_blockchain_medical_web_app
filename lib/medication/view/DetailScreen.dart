import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_list_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('처방 내용 불러오기', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(16.0),
          child: Text(
            '공공기관에서 데이터를 가져오기 위해 인증절차를 진행해야 합니다.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: (){
                // _authenticateWithKakao();
              },
              child: Text('카카오톡 인증'),
            ),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the medication setup screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PersonalMedicineListScreen()),
          );
        },
        child: Icon(Icons.double_arrow_rounded, color: Colors.white70),
        backgroundColor: Colors.red,
      ),
    );
  }
}