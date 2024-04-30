import 'package:drift/drift.dart';

class Symptoms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symptom => text()();
  DateTimeColumn get creationTime => dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
}