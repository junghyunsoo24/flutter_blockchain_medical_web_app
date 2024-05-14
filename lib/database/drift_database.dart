import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/model/alarm.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/model/prescription.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/model/personal_medicine.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/model/symptom.dart';

import '../user/model/doctor.dart';
import '../user/model/patient.dart';

part 'drift_database.g.dart';

@DriftDatabase(
    tables: [Alarms, Symptoms, PersonalMedicines, Prescriptions, Patients, Doctors],
)

class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  //patient
  Future<void> addPatient(PatientsCompanion data) async {
    await into(patients).insert(data);
  }
  Future<void> updatePatient(Patient patient) async {
    await update(patients)
        .replace(patient);
  }
  Future<Patient?> getPatientByUserIdAndPassword(String userId, String password) async {
    final query = select(patients)
      ..where((tbl) => tbl.userID.equals(userId) & tbl.userPW.equals(password));
    return query.getSingleOrNull();
  }

  //doctor
  Future<void> addDoctor(DoctorsCompanion data) async {
    await into(doctors).insert(data);
  }
  Future<void> updateDoctor(Doctor doctor) async {
    await update(doctors)
        .replace(doctor);
  }
  Future<Doctor?> getDoctorByUserIdAndPassword(String userId, String password) async {
    final query = select(doctors)
      ..where((tbl) => tbl.userID.equals(userId) & tbl.userPW.equals(password));
    return query.getSingleOrNull();
  }


  //alarm
  Future<int> insertAlarm(AlarmsCompanion alarmsCompanion) { //알람 insert
    return into(alarms).insert(alarmsCompanion);
  }
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

  //symptom
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

  //personal medicine
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

  //prescription
  Future<int> insertPrescription(PrescriptionsCompanion prescriptionsCompanion){
    return into(prescriptions).insert(prescriptionsCompanion);
  }
  Future<List<Prescription>> getAllPrescriptions() async {
    return await select(prescriptions).get();
  }

  @override
  int get schemaVersion => 2; //테이블 변화 감지를 위한 필수 지정

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        // 마이그레이션 로직: 새로운 테이블 생성
        await migrator.createTable(doctors);
        await migrator.createTable(patients);
      }
    },
    onCreate: (Migrator m) {
      return m.createAll();
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}