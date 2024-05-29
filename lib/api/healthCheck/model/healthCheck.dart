import 'package:drift/drift.dart';

class HealthChecks extends Table {
  IntColumn get id => integer().autoIncrement()();//고유번호
  TextColumn get resOrganizationName => text()();// 병원명
  DateTimeColumn get resCheckupDate => dateTime()();// 일시
  RealColumn get resHeight => real()();//키
  RealColumn get resWeight => real()();//몸무게
  RealColumn get resWaist => real()();//허리둘레
  RealColumn get resBMI => real()();//비만도
  TextColumn get resSight => text()();//시력
  TextColumn get resHearing => text()();//청력
  TextColumn get resBloodPressure => text()();//혈압
  RealColumn get resFastingBloodSuger => real()();//혈당
  TextColumn get resTotalCholesterol => text()();//콜레스테롤
}