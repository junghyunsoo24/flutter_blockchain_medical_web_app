import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/repository/symptom_repository.dart';

import '../../main.dart';

class SymptomViewModel extends ChangeNotifier {
  final ValueNotifier<List<Symptom>> _symptoms = ValueNotifier<List<Symptom>>([]);

  final _repository = SymptomRepository();
  Symptom? _currentSymptom;
  void updateSymptom(Symptom symptom) {
    _currentSymptom = symptom;
    notifyListeners();
  }
  ValueNotifier<List<Symptom>> get symptoms => _symptoms;

  Future<void> loadSymptoms() async {
    final symptomsList = await getAllSymptoms();
    _symptoms.value = symptomsList;
  }

    Future<void> saveSymptom(String symptom, DateTime startDate, DateTime endDate) async {
    await GetIt.I.registerSingleton<MyDatabase>(database).insertSymptom(SymptomsCompanion(
      symptom: Value(symptom),
      startDate: Value(startDate),
      endDate: Value(endDate),
    ));
    loadSymptoms();
  }
  Future<List<Symptom>> getAllSymptoms() async {
    return await _repository.getAllSymptoms();
  }

  Future<void> deleteSymptom(Symptom symptom) async {
    try {
      await _repository.deleteSymptom(symptom);
    } catch (e) {
      rethrow;
    }
  }
}
