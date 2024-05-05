import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/repository/alarm_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/repository/prescription_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/repository/personal_medicine_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/repository/symptom_repository.dart';

class AlarmViewModel extends ChangeNotifier {
  final ValueNotifier<List<Alarm>> _alarm = ValueNotifier<List<Alarm>>([]);

  final _repository = AlarmRepository();
  Alarm? _currentAlarm;
  final MyDatabase _database;
  AlarmViewModel(this._database);

  void updateAlarm(Alarm alarm) {
    _currentAlarm = alarm;
    notifyListeners();
  }

  ValueNotifier<List<Alarm>> get alarm => _alarm;

  Future<void> loadAlarms() async {
    final alarmList = await getAlarms();
    _alarm.value = alarmList;
  }

  Future<void> saveAlarm(String medicationName, String dosage, DateTime time, bool isEnabled,
      ) async {
    await _database.insertAlarm(AlarmsCompanion(
        medicationName: Value(medicationName),
        dosage : Value(dosage),
        time: Value(time),
        isEnabled: Value(isEnabled),
        // takeTime: takeTime != null ? Value(takeTime) : const Value.absent(),
    ));
    loadAlarms();
  }
  Future<List<Alarm>> getAlarms() async {
    return await _repository.getAllAlarms();
  }

}
