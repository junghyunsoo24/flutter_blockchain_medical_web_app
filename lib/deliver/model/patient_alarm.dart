import 'package:drift/drift.dart';

class PatientAlarms extends Table {
  IntColumn get id => integer().autoIncrement()();//고유번호
  TextColumn get userName => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
}