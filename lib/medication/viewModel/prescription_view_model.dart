import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/repository/prescription_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/repository/personal_medicine_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/repository/symptom_repository.dart';

import '../../main.dart';

class PrescriptionViewModel extends ChangeNotifier {
  final ValueNotifier<List<Prescription>> _prescription = ValueNotifier<List<Prescription>>([]);

  final _repository = PrescriptionRepository();
  Prescription? _currentPrescription;
  PrescriptionViewModel();

  void updatePrescription(Prescription prescription) {
    _currentPrescription = prescription;
    notifyListeners();
  }

  ValueNotifier<List<Prescription>> get prescription => _prescription;

  Future<void> loadSymptoms() async {
    final prescriptionList = await getPrescriptions();
    _prescription.value = prescriptionList;
  }

  Future<void> savePrescription(String resHospitalName, DateTime resTreatDate,String resPrescribeDrugName, String resPrescribeDrugEffect,
      String resMedicationDirection, String resPrescribeDays, int count, String resDrugImageLink) async {
    await GetIt.I<MyDatabase>().insertPrescription(PrescriptionsCompanion(
        resHospitalName: Value(resHospitalName),
        resTreatDate: Value(resTreatDate),
        resPrescribeDrugName: Value(resPrescribeDrugName),
        resPrescribeDrugEffect: Value(resPrescribeDrugEffect),
        resMedicationDirection: Value(resMedicationDirection),
        resPrescribeDays: Value(resPrescribeDays),
        count: Value(count),
        resDrugImageLink: Value(resDrugImageLink),
    ));
    loadSymptoms();
  }
  Future<List<Prescription>> getPrescriptions() async {
    return await _repository.getAllPrescriptions();
  }

}
