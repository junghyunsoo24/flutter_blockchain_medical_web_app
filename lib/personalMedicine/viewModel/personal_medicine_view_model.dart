import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/repository/personal_medicine_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/repository/symptom_repository.dart';

import '../../main.dart';

class PersonalMedicineViewModel extends ChangeNotifier {
  final ValueNotifier<List<PersonalMedicine>> _medicines = ValueNotifier<List<PersonalMedicine>>([]);

  final _repository = PersonalMedicineRepository();
  PersonalMedicine? _currentSymptom;
  PersonalMedicineViewModel();
  void updateSymptom(PersonalMedicine medicine) {
    _currentSymptom = medicine;
    notifyListeners();
  }
  ValueNotifier<List<PersonalMedicine>> get medicine => _medicines;

  Future<void> loadSymptoms() async {
    final medicineList = await getAllMedicines();
    _medicines.value = medicineList;
  }

  Future<void> savePersoanlMedicine(String pillName, DateTime startDate, DateTime endDate, String dosage) async {
    await GetIt.I.registerSingleton<MyDatabase>(database).insertPersonalMedicine(PersonalMedicinesCompanion(
      pillName: Value(pillName),
      startDate: Value(startDate),
      endDate: Value(endDate),
      dosage: Value(dosage)
    ));
    loadSymptoms();
  }
  Future<List<PersonalMedicine>> getAllMedicines() async {
    return await _repository.getAllPersonalMedicines();
  }

  Future<void> deleteMedicine(PersonalMedicine medicine) async {
    try {
      await _repository.deletePersonalMedicine(medicine);
    } catch (e) {
      rethrow;
    }
  }
}
