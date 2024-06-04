import 'package:flutter/cupertino.dart';
import '../../database/drift_database.dart';

class DoctorInfo extends ChangeNotifier {
  String _userId = '';
  String _name = '';
  String _field = '';
  String _hospital = '';
  String _introduction = '';

  String get userId => _userId;
  String get name => _name;
  String get field => _field;
  String get hospital => _hospital;
  String get introduction => _introduction;

  void setDoctorId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setDoctorName(String doctorName) {
    _name = doctorName;
    notifyListeners();
  }

  void updateDoctorInfo({
    String? name,
    String? field,
    String? hospital,
    String? introduction,
  }) {
    if (name != null) _name = name;
    if (field != null) _field = field;
    if (hospital != null) _hospital = hospital;
    if (introduction != null) _introduction = introduction;
    notifyListeners(); // 변경 사항 알림
  }

  void setDoctorInfo(Doctor doctor) {
    _userId = doctor.userID;
    _name = doctor.name;
    _field = doctor.field;
    _hospital = doctor.hospital;
    _introduction = doctor.introduction;
    notifyListeners();
  }


}