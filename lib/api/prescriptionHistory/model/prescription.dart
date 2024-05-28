import 'package:drift/drift.dart';


class Prescriptions extends Table {
  IntColumn get id => integer().autoIncrement()(); //고유번호
  TextColumn get resHospitalName => text()(); // 약국명
  DateTimeColumn get creationTime => dateTime().withDefault(Constant(DateTime.now()))(); //디비 insert 일자
  DateTimeColumn get resTreatDate => dateTime()(); // 처방일자
  TextColumn get resPrescribeDrugName => text()(); // 의약품명
  TextColumn get resPrescribeDrugEffect => text()(); // 처방약품효능
  TextColumn get resMedicationDirection => text()(); // 복약지도
  TextColumn get resPrescribeDays => text()(); // 복약일수
  IntColumn get count => integer()(); //투약횟수
  TextColumn get resDrugImageLink => text()(); // 약 이미지
}