import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/viewModel/personal_medicine_view_model.dart';

class PersonalMedicineListScreen extends StatefulWidget {
  const PersonalMedicineListScreen({Key? key}) : super(key: key);

  @override
  _PersonalMedicineListScreenState createState() => _PersonalMedicineListScreenState();
}

class _PersonalMedicineListScreenState extends State<PersonalMedicineListScreen> {
  late List<PersonalMedicine> medicines = [];
  late final PersonalMedicineViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PersonalMedicineViewModel();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    final medicineList = await _viewModel.getAllMedicines();
    setState(() {
      medicines = medicineList;
    });
  }

  Future<void> _deleteMedicine(PersonalMedicine medicine) async {
    await _viewModel.deleteMedicine(medicine);
    _loadMedicines();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('의약품이 삭제되었습니다.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('개인 구매 의약품 목록', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '의약품을 좌측으로 스와이프하여 삭제할 수 있습니다.',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                PersonalMedicine medicine = medicines[index];
                return Dismissible(
                  key: Key(medicine.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteMedicine(medicine);
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        medicine.pillName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                            '복용 시작일: ${DateFormat('yyyy-MM-dd').format(medicine.startDate)}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '복용 종료일: ${DateFormat('yyyy-MM-dd').format(medicine.endDate)}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '복용량: ${medicine.dosage}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PersonalMedicineScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white70),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_screen.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/viewModel/personal_medicine_view_model.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_screen.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/viewModel/symptom_view_model.dart';
//
// class PersonalMedicineListScreen extends StatefulWidget{
//   const PersonalMedicineListScreen({Key? key}) : super(key: key);
//
//   @override
//   _PersonalMedicineListScreenState createState() => _PersonalMedicineListScreenState();
// }
//
// class _PersonalMedicineListScreenState extends State<PersonalMedicineListScreen>{
//   late List<PersonalMedicine> medicines = [];
//   late final MyDatabase _database;
//   late final PersonalMedicineViewModel _viewModel;
//   @override
//   void initState() {
//     super.initState();
//     _viewModel = PersonalMedicineViewModel();
//     _loadMedicines();
//   }
//
//   Future<void> _loadMedicines() async {
//     final medicineList = await _viewModel.getAllMedicines(); //모든 의약품 가져오기
//     print("의약품 작동");
//     print(medicineList);
//     setState(() {
//       medicines = medicineList;
//     });
//   }
//   Future<void> _deleteMedicine(PersonalMedicine medicine) async {
//     await _viewModel.deleteMedicine(medicine);
//     _loadMedicines();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('의약품이 삭제되었습니다.'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('개인 구매 의약품 목록', style: TextStyle(fontWeight: FontWeight.bold)),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: medicines.length,
//               itemBuilder: (context, index) {
//                 PersonalMedicine medicine = medicines[index];
//                 return ListTile(
//                   title: Text("약물명 : "+medicine.pillName),
//                   subtitle: Text('${medicine.startDate} 부터 ${medicine.endDate} 까지'),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text('복용양: ${medicine.dosage}'),
//                       SizedBox(width: 8.0),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () => _deleteMedicine(medicine),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to the medication setup screen
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => PersonalMedicineScreen()),
//           );
//         },
//         child: Icon(Icons.add, color: Colors.white70),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
// }