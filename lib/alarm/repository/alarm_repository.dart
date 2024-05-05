import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

class AlarmRepository {
  final _databaseService = MyDatabase();

  Future<void> insertAlarm (
      AlarmsCompanion alarmsCompanion) async {
    await _databaseService.insertAlarm(alarmsCompanion);
  }

  Future<List<Alarm>> getAllAlarms() async {
    return await _databaseService.getAllAlarms();
  }
}