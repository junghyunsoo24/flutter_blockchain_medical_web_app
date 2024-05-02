import 'package:drift/drift.dart';


class PersonalMedicines extends Table {
  IntColumn get id => integer().autoIncrement()(); //고유번호
  TextColumn get pillName => text()(); // 의약품명
  DateTimeColumn get creationTime => dateTime().withDefault(Constant(DateTime.now()))(); // 등록일
  DateTimeColumn get startDate => dateTime()(); // 복용 시작 날짜
  DateTimeColumn get endDate => dateTime()(); // 복용 끝 날짜
  TextColumn get dosage => text()(); // 복용 양
}