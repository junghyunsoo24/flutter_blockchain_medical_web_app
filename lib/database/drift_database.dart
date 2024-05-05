import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/model/alarm.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/model/prescription.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/model/personal_medicine.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/model/symptom.dart';

part 'drift_database.g.dart';


LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
    tables: [
        Alarms, Symptoms, PersonalMedicines, Prescriptions
])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.

  Future<int> insertAlarm(AlarmsCompanion alarmsCompanion) { //알람 insert
    return into(alarms).insert(alarmsCompanion);
  }

  // Future<List<Alarm>> get allAlarm => select(alarms).get();
  Future<List<Alarm>> getAllAlarms() async{
    return await select(alarms).get();
  }

  Future deleteAlarm(Alarm alarm) {
    return delete(alarms).delete(alarm);
  }
  Future<void> updateAlarm(Alarm alarm) async {
    await update(alarms)
        .replace(alarm);
  }
  // Future<int> insertSymptom(Symptom symptom) {
  //   return into(symptoms).insert(symptom);
  // }

  Future<int> insertSymptom(SymptomsCompanion symptomsCompanion){ //추가 증상
    return into(symptoms).insert(symptomsCompanion);
  }

  Future<void> updateSymptom(Symptom symptom) async {
    await update(symptoms).replace(symptom);
  }

  Future<void> deleteSymptom(Symptom symptom) async {
    await delete(symptoms).delete(symptom);
  }

  Future<List<Symptom>> getAllSymptoms() async {
    return await select(symptoms).get();
  }


  Future<int> insertPersonalMedicine(PersonalMedicinesCompanion personalmedicinesCompanion){ //개인 구매 의약품
    return into(personalMedicines).insert(personalmedicinesCompanion);
  }

  Future<void> updatePersonalMedicine(PersonalMedicine personalMedicine) async {
    await update(personalMedicines).replace(personalMedicine);
  }

  Future<void> deletePersonalMedicine(PersonalMedicine personalMedicine) async {
    await delete(personalMedicines).delete(personalMedicine);
  }

  Future<List<PersonalMedicine>> getAllPersonalMedicines() async {
    return await select(personalMedicines).get();
  }

  Future<int> insertPrescription(PrescriptionsCompanion prescriptionsCompanion){
    return into(prescriptions).insert(prescriptionsCompanion);
  }

  Future<List<Prescription>> getAllPrescriptions() async {
    return await select(prescriptions).get();
  }

  @override
  int get schemaVersion => 1; //테이블 변화 감지를 위한 필수 지정

}
