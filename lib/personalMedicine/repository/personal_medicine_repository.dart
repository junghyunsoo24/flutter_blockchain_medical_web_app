import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

class PersonalMedicineRepository {
  final _databaseService = MyDatabase();

  Future<void> insertPersonalMedicine(
      PersonalMedicinesCompanion personalmedicinesCompanion) async {
    await _databaseService.insertPersonalMedicine(personalmedicinesCompanion);
  }

  Future<void> updatePersonalMedicine(PersonalMedicine personalMedicine) async {
    await _databaseService.updatePersonalMedicine(personalMedicine);
  }

  Future<void> deletePersonalMedicine(PersonalMedicine personalMedicine) async {
    await _databaseService.deletePersonalMedicine(personalMedicine);
  }

  Future<List<PersonalMedicine>> getAllPersonalMedicines() async {
    return await _databaseService.getAllPersonalMedicines();
  }
}