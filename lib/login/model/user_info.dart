import 'package:flutter/cupertino.dart';

import '../../database/drift_database.dart';
class UserInfo extends ChangeNotifier {
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

//
// class UserInfo extends ChangeNotifier {
//   String _userId = '';
//   String _name = '';
//
//   String get userId => _userId;
//   String get name => _name;
//
//   void setUserId(String userId) {
//     _userId = userId;
//     notifyListeners();
//   }
//   void setName(String name) {
//     _name = name;
//     notifyListeners();
//   }
//
// }
