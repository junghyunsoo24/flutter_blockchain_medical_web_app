import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
class BoardViewModel extends ChangeNotifier {
  String? baseUrl = dotenv.env['BASE_URL'];

  Question? _question;

  Question? get question => _question;

  void setQuestion(Question? value) {
    _question = value;
    print(_question);
    notifyListeners();
  }

  String _title = '';
  String _selectedSymptom = '머리';
  String _selectedBodyPart = 'HEAD';
  String _selectedCategory = 'ENTIRE';
  String _symptomDescription = '';
  String _additionalInfo = '';
  int? _age;
  String _selectedGender = 'MALE';
  String _disease = '';
  String _medication = '';
  bool _showPersonalDataFields = false;

  final List<String> _symptoms = ['머리', '치아', '열'];
  final List<String> _bodyParts = ['HAND', 'WRIST', 'FOOT', 'ANKLE', 'NECK', 'THROAT',
  'HEAD', 'ARM', 'HEART','WAIST', 'EYE', 'TEETH', 'KNEE', 'EAR', 'SKIN','STOMACH', 'THIGH',
  'CALF', 'BACK'];
  final List<String> _categories = ['ENTIRE', 'MATERNITY', 'ELDERS'];
  final List<String> _genders = ['MALE', 'FEMALE'];

  String get title => _title;
  String get selectedBodyPart => _selectedBodyPart;
  String get selectedCategory => _selectedCategory;
  String get symptomDescription => _symptomDescription;
  String get additionalInfo => _additionalInfo;
  int? get age => _age;
  String get selectedGender => _selectedGender;
  String get disease => _disease;
  String get medication => _medication;
  bool get showPersonalDataFields => _showPersonalDataFields;


  List<String> get symptoms => _symptoms;
  List<String> get bodyParts => _bodyParts;
  List<String> get categories => _categories;
  List<String> get genders => _genders;

  void setTitle(String value) {
    print("여기");
    print(value);
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

  void setAge(String value) {
    _age = int.tryParse(value);
    notifyListeners();
  }

  void setSelectedGender(String value) {
    _selectedGender = value;
    notifyListeners();
  }

  void setDisease(String value) {
    _disease = value;
    notifyListeners();
  }

  void setMedication(String value) {
    _medication = value;
    notifyListeners();
  }

  void toggleShowPersonalDataFields(bool show) {
    _showPersonalDataFields = show;
    notifyListeners();
  }

  Future<void> submitForm(String userId, BuildContext context) async {
    final url = Uri.parse('$baseUrl/question/enroll');
    final body = jsonEncode({
      'userId': userId,
      'bodyParts': [_selectedBodyPart.toUpperCase()],
      'category': _selectedCategory.toUpperCase(),
      'title': _title,
      'symptom': _symptomDescription,
      'content': _additionalInfo,
      'personalData': _showPersonalDataFields
          ? {
        'age': _age,
        'gender': _selectedGender,
        'disease': _disease,
        'medication': _medication,
      }
          : null,
    },

    );
    print(body);
    try {
      final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      final responseData = jsonDecode(response.body);
      if (responseData['result'] == 'success') {
        print('요청 성공: ${response.body}');
        _showSuccessSnackBar(context);
      } else {
        // 요청 실패 시 처리
        print('요청 실패: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // 예외 처리
      print('예외 발생: $e');
    }
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('긴급데이터 등록이 완료되었습니다.'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
