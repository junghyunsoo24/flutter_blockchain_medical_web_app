import 'package:drift/drift.dart';


class Prescriptions extends Table {
  IntColumn get id => integer().autoIncrement()(); // 고유번호
  TextColumn get resTreatDate => text()(); // 진료/처방일자
  TextColumn get resTreatTypeDet => text()(); // 진료형태 및 상태
  TextColumn get resPrescribeCntDet => text()(); // 처방횟수_상세
  TextColumn get resPrescribeDrugName => text()(); // 처방약품명
  TextColumn get resPrescribeDrugEffect => text()(); // 처방약품효능
  TextColumn get resPrescribeDays => text()(); // 투약일수
  TextColumn get resDrugCode => text()(); // 약품 코드
  TextColumn get resDrugImageLink => text()(); // 약품이미지
  TextColumn get resMedicationDirection => text()(); // 복약지도
  TextColumn get resBrand => text()(); // 브랜드
  TextColumn get resATCCode => text()(); // ATC 코드
  TextColumn get resFormula => text()(); // 처방전 정보
  TextColumn get resHospitalName => text()(); // 병의원(약국) 명칭
  TextColumn get resTreatStartDate => text()(); // 진료개시일
  TextColumn get resTreatType => text()(); // 진료형태
  TextColumn get resVisitDays => text()(); // 방문(입원)일수
  TextColumn get resPrescribeCnt => text()(); // 처방횟수
  TextColumn get resMedicationCnt => text()(); //	투약(요양)횟수
  TextColumn get resType => text()(); // 구분
}
