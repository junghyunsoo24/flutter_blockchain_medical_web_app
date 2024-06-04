import 'package:drift/drift.dart';

class DoctorAlarms extends Table {
  IntColumn get id => integer().autoIncrement()();//고유번호
  TextColumn get patientId => text()();
  TextColumn get userName => text()();
  TextColumn get medicine => text()();
  TextColumn get symptom => text()();
  TextColumn get detail => text()();
  TextColumn get resHospitalName => text()();
  TextColumn get resTreatDate => text()();
  TextColumn get resPrescribeDrugName => text()();
  TextColumn get resPrescribeDrugEffect => text()();
  TextColumn get resPrescribeDays => text()();
}