import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/model/alarm.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/api/prescriptionHistory/model/prescription.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/model/personal_medicine.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/model/symptom.dart';

import '../api/healthCheck/model/healthCheck.dart';
import '../deliver/model/doctor_alarm.dart';
import '../deliver/model/patient_alarm.dart';
import '../user/model/doctor.dart';
import '../user/model/patient.dart';

part 'drift_database.g.dart';

@DriftDatabase(
    tables: [Alarms, Symptoms, PersonalMedicines, Prescriptions, Patients, Doctors, HealthChecks, DoctorAlarms, Prescriptions, PatientAlarms],
)

class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  Future<String?> getNameFromPrescriptions() async {
    final query = select(prescriptions)..where((p) => p.name.equals("처방내역")); // 쿼리 변수 분리
    final results = await query.get(); // get() 메서드를 통해 결과 가져오기
    if (results.isNotEmpty) {
      final firstPrescription = results.first;
      print(firstPrescription.name);// 첫 번째 결과 가져오기
      return firstPrescription.name;
    }
    return null; // 결과가 없거나 타입이 맞지 않는 경우 null 반환
  }
  Future<void> addPrescriptions(PrescriptionsCompanion data) async {
    await into(prescriptions).insert(data);
  }

  Future<void> addHealthCheck(HealthChecksCompanion data) async {
    await into(healthChecks).insert(data);
  }

  Future<bool> isSameExistsPrescriptions(PrescriptionsCompanion data) async {
    final existingPrescription = await (select(prescriptions)
      ..where((p) => p.resTreatDate.equals(data.resTreatDate.value))
      ..where((p) => p.resPrescribeDrugName.equals(data.resPrescribeDrugName.value))
      ..where((p) => p.resPrescribeDays.equals(data.resPrescribeDays.value))
      ..limit(1))
        .getSingleOrNull();

    return existingPrescription != null;
  }


  //patientAlarm
  Future<void> addPatientAlarm(PatientAlarmsCompanion data) async {
    await into(patientAlarms).insert(data);
  }
  Future<List<DoctorAlarm>> getTopFiveDoctorAlarms() async {
    return await (select(doctorAlarms)..limit(3)).get();
  }

  Future<List<DoctorAlarm>> getAllDoctorAlarms() async {
    return await select(doctorAlarms).get();
  }

  //doctorAlarm
  Future<void> addDoctorAlarm(DoctorAlarmsCompanion data) async {
    await into(doctorAlarms).insert(data);
  }

  //healthCheck
  // Future<void> addHealthCheck(HealthChecksCompanion data) async {
  //   await into(healthChecks).insert(data);
  // }
  Future<bool> isSameCheckupDateExists(String checkupDate) async {
    if (checkupDate.isEmpty) return false;
    final query = select(healthChecks)
      ..where((t) => t.resCheckupDate.equals(DateTime.parse(checkupDate)));
    final result = await query.get();
    return result.isNotEmpty;
  }

  //patient
  Future<void> addPatient(PatientsCompanion data) async {
    await into(patients).insert(data);
  }
  Future<int> updatePatient(Patient updatedPatient) {
    return (update(patients)..where((p) => p.id.equals(updatedPatient.id))).write(updatedPatient);
  }
  Future<Patient?> getPatientByUserIdAndPassword(String userId, String password) async {
    final query = select(patients)
      ..where((tbl) => tbl.userID.equals(userId) & tbl.userPW.equals(password));
    final patient = await query.getSingleOrNull();
    if (patient != null) {
      return patient.copyWith(name: patient.name); // 사용자 이름 반환
    }
    return null;
  }
  Future<bool> isPatientIdExists(String userId) async {
    final query = select(patients)..where((tbl) => tbl.userID.equals(userId)); // patients 테이블에서 userID가 일치하는 행 조회
    final result = await query.getSingleOrNull(); // 결과를 가져옴 (없으면 null)
    return result != null; // 결과가 있으면 true, 없으면 false 반환
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
  Future<bool> isDoctorIdExists(String userId) async {
    final query = select(doctors)..where((tbl) => tbl.userID.equals(userId)); // doctors 테이블에서 userID가 일치하는 행 조회
    final result = await query.getSingleOrNull(); // 결과를 가져옴 (없으면 null)
    return result != null; // 결과가 있으면 true, 없으면 false 반환
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
  Future<List<Alarm>> getAlarmsWithNonNullTakeTime() async {
    return await (select(alarms)
      ..where((alarm) => alarm.takeTime.isNotNull()))
        .get();
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
    if (Platform.isWindows) {
      final dbFolder = await getApplicationSupportDirectory();
      final file = File(p.join(dbFolder.path, 'desktop_db.sqlite'));
      print("Database folder path: ${dbFolder.path}");
      return NativeDatabase(file);
    } else {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'mobile_db.sqlite'));
      return NativeDatabase(file);
    }
  });
}