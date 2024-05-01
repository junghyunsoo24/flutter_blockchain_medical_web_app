import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/viewModel/symptom_view_model.dart';

class SymptomListScreen extends StatefulWidget{
  const SymptomListScreen({Key? key}) : super(key: key);

  @override
  _SymptomListScreenState createState() => _SymptomListScreenState();
}

class _SymptomListScreenState extends State<SymptomListScreen>{
  late List<Symptom> symptoms = [];
  late final MyDatabase _database;
  late final SymptomViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _database = MyDatabase();
    _viewModel = SymptomViewModel(MyDatabase());
    _loadSymptoms();
  }

  Future<void> _loadSymptoms() async {
    final symptomsList = await _viewModel.getAllSymptoms(); //모든 증상내용 가져오기
    print("증상 작동");
    print(symptomsList);
    setState(() {
      symptoms = symptomsList;
    });
  }
  Future<void> _deleteSymptom(Symptom symptom) async {
    await _viewModel.deleteSymptom(symptom);
    _loadSymptoms();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('증상이 삭제되었습니다.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Future<void> deleteSymptom(Symptom symptom) async {
  //   try {
  //     await _database.deleteSymptom(symptom);
  //     await _loadSymptoms();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('증상이 삭제되었습니다.'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('증상 삭제 중 오류가 발생했습니다.'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('증상 목록', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                Symptom symptom = symptoms[index];
                return ListTile(
                  title: Text(symptom.symptom),
                  subtitle: Text('${symptom.startDate} - ${symptom.endDate}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteSymptom(symptom),
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
            MaterialPageRoute(builder: (context) => SymptomScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white70),
        backgroundColor: Colors.blue,
      ),
    );
  }
}