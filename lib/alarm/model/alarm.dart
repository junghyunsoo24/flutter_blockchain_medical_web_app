import 'package:drift/drift.dart';


class Alarms extends Table{ //별도의 설정이 없으면, 클래스명에 뒤에 s는 코드 제너레이션 과정에서 떨어져 나가서 Alarm이라는 클래스로 만들어짐.
  IntColumn get id => integer().autoIncrement()();
  TextColumn get medicationName => text()();
  TextColumn get dosage => text()();
  DateTimeColumn   get time => dateTime()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}