// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_form_widget.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/viewModel/symptom_view_model.dart';
//
// class SymptomScreen extends StatefulWidget{
//   @override
//   _SymptomScreenState createState() => _SymptomScreenState();
// }
// class _SymptomScreenState extends State<SymptomScreen> {
//   final _viewModel = SymptomViewModel();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("추가 증상 등록"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: SymptomFormWidget(
//           viewModel: _viewModel,
//           onSymptomSaved: (symptoms) {
//             for (final symptom in symptoms) {
//               _viewModel.saveSymptom(symptom).then((_) {
//                 // Show success message to the user
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Symptom saved successfully!'),
//                     duration: Duration(seconds: 3),
//                   ),
//                 );
//               }).catchError((error) {
//                 // Show error message to the user
//                 print('Error saving symptom: $error');
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Error saving symptom: $error'),
//                     duration: Duration(seconds: 3),
//                   ),
//                 );
//               });
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/viewModel/symptom_view_model.dart';

// class SymptomViewModel {
//   final MyDatabase _database;
//
//   SymptomViewModel(this._database);
//
//   Future<void> saveSymptom(String symptom, DateTime startDate, DateTime endDate) async {
//     await _database.insertSymptom(SymptomsCompanion(
//       symptom: Value(symptom),
//       startDate: Value(startDate),
//       endDate: Value(endDate),
//     ));
//   }
// }

class SymptomScreen extends StatefulWidget {
  SymptomScreen({Key? key}) : super(key: key);

  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  final borderside = OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  TextEditingController _symptomController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late final SymptomViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SymptomViewModel(MyDatabase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("추가 증상 등록"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: "증상을 입력해주세요", border: borderside),
                controller: _symptomController,
                validator: (symptom) {
                  if (symptom != null && symptom.isNotEmpty) {
                    return null;
                  } else {
                    return "증상을 입력해주세요";
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "증상 시작 날짜를 입력해주세요", border: borderside),
                controller: _startDateController,
                validator: (startDate) {
                  if (startDate != null && startDate.isNotEmpty) {
                    return null;
                  } else {
                    return "증상 시작 날짜를 입력해주세요";
                  }
                },
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                    _startDateController.text = formattedDate;
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "증상 종료 날짜를 입력해주세요", border: borderside),
                controller: _endDateController,
                validator: (endDate) {
                  if (endDate != null && endDate.isNotEmpty) {
                    return null;
                  } else {
                    return "증상 종료 날짜를 입력해주세요";
                  }
                },
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                    _endDateController.text = formattedDate;
                  }
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState != null) {
                    bool passed = _formKey.currentState!.validate();
                    if (passed) {
                      await _viewModel.saveSymptom(
                        _symptomController.text,
                        DateTime.parse(_startDateController.text),
                        DateTime.parse(_endDateController.text),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("증상이 저장되었습니다."),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  }
                },
                child: Text("저장", style: Theme.of(context).textTheme.button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
