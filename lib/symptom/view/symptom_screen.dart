import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/view/symptom_form_widget.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/viewModel/symptom_view_model.dart';

class SymptomScreen extends StatefulWidget{
  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}
class _SymptomScreenState extends State<SymptomScreen> {
  final _viewModel = SymptomViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("추가 증상 등록"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SymptomFormWidget(
          viewModel: _viewModel,
          onSymptomSaved: (symptoms) {
            for (final symptom in symptoms) {
              _viewModel.saveSymptom(symptom).then((_) {
                // Show success message to the user
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Symptom saved successfully!'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }).catchError((error) {
                // Show error message to the user
                print('Error saving symptom: $error');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error saving symptom: $error'),
                    duration: Duration(seconds: 3),
                  ),
                );
              });
            }
          },
        ),
      ),
    );
  }
}
