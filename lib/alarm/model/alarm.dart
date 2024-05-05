import 'package:drift/drift.dart';


class Alarms extends Table {
  IntColumn get id => integer().autoIncrement()(); // 고유번호
  TextColumn get medicationName => text()(); // 복용약 명
  TextColumn get dosage => text()(); // 복용 양
  DateTimeColumn get time => dateTime()(); // 사용자가 설정한 시간
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))(); // 알림 설정 활성화 여부
  DateTimeColumn? get takeTime => dateTime().nullable()(); // 복용 일시 (선택적 필드)
}
