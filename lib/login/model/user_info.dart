import 'package:flutter/cupertino.dart';

import '../../database/drift_database.dart';
class UserInformation extends ChangeNotifier {
  String _userId = '';
  String _name = '';
  String _birthday = '';
  int _gender = 0;
  double _height = 0.0;
  double _weight = 0.0;

  String get userId => _userId;
  String get name => _name;
  String get birthday => _birthday;
  int get gender => _gender;
  double get height => _height;
  double get weight => _weight;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setUserName(String userName) {
    _name = userName;
    notifyListeners();
  }

  void updateUserInfo({
    String? name,
    double? height,
    double? weight,
  }) {
    if (name != null) _name = name;
    if (height != null) _height = height;
    if (weight != null) _weight = weight;
    notifyListeners(); // 변경 사항 알림
  }

  void setUserInfo(Patient patient) {
    _userId = patient.userID;
    _name = patient.name;
    _birthday = patient.birthday;
    _gender = patient.gender;
    _height = patient.height;
    _weight = patient.weight;
    notifyListeners();
  }
}