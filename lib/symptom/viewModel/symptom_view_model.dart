import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/repository/symptom_repository.dart';

class SymptomViewModel extends ChangeNotifier {
  final _repository = SymptomRepository();
  Symptom? _currentSymptom;
  final MyDatabase _database;
  SymptomViewModel(this._database);
  void updateSymptom(Symptom symptom) {
    _currentSymptom = symptom;
    notifyListeners();
  }

    Future<void> saveSymptom(String symptom, DateTime startDate, DateTime endDate) async {
    await _database.insertSymptom(SymptomsCompanion(
      symptom: Value(symptom),
      startDate: Value(startDate),
      endDate: Value(endDate),
    ));
  }
  // Future<void> saveSymptom(SymptomsCompanion symptom) async {
  //   await _repository.insertSymptom(symptom);
  //   _currentSymptom = null;
  //   notifyListeners();
  // }

  Future<List<Symptom>> getAllSymptoms() async {
    return await _repository.getAllSymptoms();
  }

  // Future<List<Symptom>> getSymptomsByFilter(SymptomFilter filter) async {
  //   return await _repository.getSymptomsByFilter(filter);
  // }
}
