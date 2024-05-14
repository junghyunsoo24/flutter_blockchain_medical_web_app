import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

import '../../main.dart';

class SymptomRepository{

  Future<void> insertSymptom(SymptomsCompanion symptom) async {
    await GetIt.I<MyDatabase>().insertSymptom(symptom);
  }

  Future<void> updateSymptom(Symptom symptom) async {
    await GetIt.I<MyDatabase>().updateSymptom(symptom);
  }

  Future<void> deleteSymptom(Symptom symptom) async {
    await GetIt.I<MyDatabase>().deleteSymptom(symptom);
  }

  Future<List<Symptom>> getAllSymptoms() async {
    return await GetIt.I<MyDatabase>().getAllSymptoms();
  }

  // Future<List<Symptom>> getSymptomsByFilter(SymptomFilter filter) async {
  //   return await _databaseService.getSymptomsByFilter(filter);
  // }
}