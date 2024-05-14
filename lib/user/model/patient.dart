import 'package:drift/drift.dart';

class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userID => text()();
  TextColumn get userPW => text()();
  TextColumn get name => text()();
  TextColumn get birthday => text()();
  IntColumn get gender => integer()();
  RealColumn get height => real()();
  RealColumn get weight => real()();
  TextColumn get role => text()();
}