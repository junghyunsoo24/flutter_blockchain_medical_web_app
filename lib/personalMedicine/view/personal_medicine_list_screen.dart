import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/view/personal_medicine_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/viewModel/personal_medicine_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/viewModel/symptom_view_model.dart';

class PersonalMedicineListScreen extends StatefulWidget{
  const PersonalMedicineListScreen({Key? key}) : super(key: key);

  @override
  _PersonalMedicineListScreenState createState() => _PersonalMedicineListScreenState();
}

class _PersonalMedicineListScreenState extends State<PersonalMedicineListScreen>{
  late List<PersonalMedicine> medicines = [];
  late final MyDatabase _database;
  late final PersonalMedicineViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = PersonalMedicineViewModel();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    final medicineList = await _viewModel.getAllMedicines(); //모든 의약품 가져오기
    print("의약품 작동");
    print(medicineList);
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
          Expanded(
            child: ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                PersonalMedicine medicine = medicines[index];
                return ListTile(
                  title: Text("약물명 : "+medicine.pillName),
                  subtitle: Text('${medicine.startDate} 부터 ${medicine.endDate} 까지'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('복용양: ${medicine.dosage}'),
                      SizedBox(width: 8.0),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteMedicine(medicine),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the medication setup screen
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