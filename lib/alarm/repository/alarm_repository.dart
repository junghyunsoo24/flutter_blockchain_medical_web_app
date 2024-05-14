import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

import '../../main.dart';

class AlarmRepository {

  Future<void> insertAlarm (
      AlarmsCompanion alarmsCompanion) async {
    await GetIt.I.registerSingleton<MyDatabase>(database).insertAlarm(alarmsCompanion);
  }

  Future<List<Alarm>> getAllAlarms() async {
    return await GetIt.I.registerSingleton<MyDatabase>(database).getAllAlarms();
  }

  Future<void> deleteAlarm(Alarm alarm) async {
    await GetIt.I.registerSingleton<MyDatabase>(database).deleteAlarm(alarm);
  }
}