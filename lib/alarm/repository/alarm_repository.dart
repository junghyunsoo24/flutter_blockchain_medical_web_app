import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

import '../../main.dart';

class AlarmRepository {

  Future<void> insertAlarm (
      AlarmsCompanion alarmsCompanion) async {
    await GetIt.I<MyDatabase>().insertAlarm(alarmsCompanion);
  }

  Future<List<Alarm>> getAllAlarms() async {
    return await GetIt.I<MyDatabase>().getAllAlarms();
  }

  Future<void> deleteAlarm(Alarm alarm) async {
    await GetIt.I<MyDatabase>().deleteAlarm(alarm);
  }
  Future<List<Alarm>> getAlarmsWithNonNullTakeTime() async{
    return await GetIt.I<MyDatabase>().getAlarmsWithNonNullTakeTime();
  }
}