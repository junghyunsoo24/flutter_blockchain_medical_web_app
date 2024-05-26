import 'package:flutter/cupertino.dart';

class UserInfo extends ChangeNotifier {
  String _userId = '';

  String get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

}
