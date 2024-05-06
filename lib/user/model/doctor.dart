import 'package:drift/drift.dart';

class Doctors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userID => text()();
  TextColumn get userPW => text()();
  TextColumn get name => text()();
  TextColumn get field => text()();
  TextColumn get hospital => text()();
  TextColumn get introduction => text()();
  IntColumn get role => integer()();
}