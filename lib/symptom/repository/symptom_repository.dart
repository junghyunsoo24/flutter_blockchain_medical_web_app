import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

class SymptomRepository{
  final _databaseService = MyDatabase();

  Future<void> insertSymptom(SymptomsCompanion symptom) async {
    await _databaseService.insertSymptom(symptom);
  }

  Future<void> updateSymptom(Symptom symptom) async {
    await _databaseService.updateSymptom(symptom);
  }

  Future<void> deleteSymptom(Symptom symptom) async {
    await _databaseService.deleteSymptom(symptom);
  }

  Future<List<Symptom>> getAllSymptoms() async {
    return await _databaseService.getAllSymptoms();
  }

  // Future<List<Symptom>> getSymptomsByFilter(SymptomFilter filter) async {
  //   return await _databaseService.getSymptomsByFilter(filter);
  // }
}