import 'package:drift/drift.dart';

class DoctorAlarms extends Table {
  IntColumn get id => integer().autoIncrement()();//고유번호
  TextColumn get userName => text()();
  TextColumn get medicine => text()();
  TextColumn get symptom => text()();
  TextColumn get detail => text()();
}