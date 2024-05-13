import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoardViewModel extends ChangeNotifier {
  String _title = '';
  String _selectedSymptom = '머리';
  String _selectedBodyPart = 'HEAD';
  String _selectedCategory = 'ENTIRE';
  String _symptomDescription = '';
  String _additionalInfo = '';
  String _personalData = '';
  bool _sharePersonalData = false;

  final List<String> _symptoms = ['머리', '치아', '열'];
  final List<String> _bodyParts = ['HEAD', 'TEETH', 'TETH'];
  final List<String> _categories = ['ENTIRE', 'E', 'NTIRE'];

  String get title => _title;
  String get selectedSymptom => _selectedSymptom;
  String get selectedBodyPart => _selectedBodyPart;
  String get selectedCategory => _selectedCategory;
  String get symptomDescription => _symptomDescription;
  String get additionalInfo => _additionalInfo;
  String get personalData => _personalData;
  bool get sharePersonalData => _sharePersonalData;

  List<String> get symptoms => _symptoms;
  List<String> get bodyParts => _bodyParts;
  List<String> get categories => _categories;

  void setTitle(String value) {
    _title = value;
    notifyListeners(); //리렌더링 하는 함수
  }

  void setSelectedSymptom(String value) {
    _selectedSymptom = value;
    notifyListeners();
  }

  void setSelectedBodyPart(String value) {
    _selectedBodyPart = value;
    notifyListeners();
  }

  void setSelectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void setSymptomDescription(String value) {
    _symptomDescription = value;
    notifyListeners();
  }

  void setAdditionalInfo(String value) {
    _additionalInfo = value;
    notifyListeners();
  }
  void setPersonalData(String value) {
    _personalData = value;
    notifyListeners();
  }

  // void setSharePersonalData(bool value) {
  //   _sharePersonalData = value;
  //   notifyListeners();
  // }

  Future<void> submitForm() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/v1/question/enroll');
    final body = jsonEncode({
      'userId': "patientId",
      'bodyParts': [_selectedBodyPart.toUpperCase()],
      'category': _selectedCategory.toUpperCase(),
      'title': _title,
      'symptom': _symptomDescription,
      'content': _additionalInfo,
      'personalData': null,
    },

    );
    print(body);
    try {
      final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      if (response.statusCode == 200) {
        // 요청 성공 시 처리
        print("? 성공");
        print('요청 성공: ${response.body}');
      } else {
        // 요청 실패 시 처리
        print('요청 실패: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // 예외 처리
      print('예외 발생: $e');
    }
  }
}
