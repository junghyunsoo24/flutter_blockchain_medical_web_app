import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

class PrescriptionRepository {
  final _databaseService = MyDatabase();

  Future<void> insertPrescription (
      PrescriptionsCompanion prescriptionsCompanion) async {
    await _databaseService.insertPrescription(prescriptionsCompanion);
  }

  Future<List<Prescription>> getAllPrescriptions() async {
    return await _databaseService.getAllPrescriptions();
  }
}