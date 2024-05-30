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

  void setDoctorInfo(Doctor doctor) {
    _userId = doctor.userID;
    _name = doctor.name;
    _field = doctor.field;
    _hospital = doctor.hospital;
    _introduction = doctor.introduction;
    notifyListeners();
  }
}