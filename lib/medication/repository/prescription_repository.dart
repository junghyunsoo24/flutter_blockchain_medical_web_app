import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

import '../../main.dart';

class PrescriptionRepository {

  Future<void> insertPrescription (
      PrescriptionsCompanion prescriptionsCompanion) async {
    await GetIt.I<MyDatabase>().insertPrescription(prescriptionsCompanion);
  }

  Future<List<Prescription>> getAllPrescriptions() async {
    return await GetIt.I<MyDatabase>().getAllPrescriptions();
  }
}