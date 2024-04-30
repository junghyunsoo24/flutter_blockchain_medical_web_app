import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_screen.dart';

class SymptomListScreen extends StatefulWidget{
  const SymptomListScreen({Key? key}) : super(key: key);

  @override
  _SymptomListScreenState createState() => _SymptomListScreenState();
}

class _SymptomListScreenState extends State<SymptomListScreen>{
  late List<Symptom> symptoms = [];
  late final MyDatabase _database;

  @override
  void initState() {
    super.initState();
    _database = MyDatabase();
    _loadMedications();
  }

  Future<void> _loadMedications() async {
    final symptomsList = await _database.getAllSymptoms(); //모든 증상내용 가져오기
    print("증상 작동");
    print(symptomsList);
    setState(() {
      symptoms = symptomsList;
    });
  }


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
                  subtitle: Text('${symptom.startDate.toString()} - ${symptom.endDate.toString()}'),
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