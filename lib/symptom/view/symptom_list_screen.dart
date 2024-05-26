import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/viewModel/symptom_view_model.dart';

class SymptomListScreen extends StatefulWidget {
  const SymptomListScreen({Key? key}) : super(key: key);

  @override
  _SymptomListScreenState createState() => _SymptomListScreenState();
}

class _SymptomListScreenState extends State<SymptomListScreen> {
  late List<Symptom> symptoms = [];
  late final SymptomViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SymptomViewModel();
    _loadSymptoms();
  }

  Future<void> _loadSymptoms() async {
    final symptomsList = await _viewModel.getAllSymptoms();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('증상 목록', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '증상을 좌측으로 밀면 삭제할 수 있습니다.',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                Symptom symptom = symptoms[index];
                return Dismissible(
                  key: Key(symptom.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteSymptom(symptom);
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        symptom.symptom,
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
                            '증상 시작일: ${DateFormat('yyyy-MM-dd').format(symptom.startDate)}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '증상 종료일: ${DateFormat('yyyy-MM-dd').format(symptom.endDate)}',
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
            MaterialPageRoute(builder: (context) => SymptomScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white70),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
