import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/repository/symptom_repository.dart';

class SymptomViewModel extends ChangeNotifier {
  final _repository = SymptomRepository();
  Symptom? _currentSymptom;

  void updateSymptom(Symptom symptom) {
    _currentSymptom = symptom;
    notifyListeners();
  }

  Future<void> saveSymptom(Symptom symptom) async {
    await _repository.insertSymptom(symptom);
    _currentSymptom = null;
    notifyListeners();
  }

  Future<List<Symptom>> getAllSymptoms() async {
    return await _repository.getAllSymptoms();
  }

  // Future<List<Symptom>> getSymptomsByFilter(SymptomFilter filter) async {
  //   return await _repository.getSymptomsByFilter(filter);
  // }
}
