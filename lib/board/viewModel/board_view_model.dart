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
  String _selectedBodyPart = '머리';
  String _selectedCategory = '전체';
  String _symptomDescription = '';
  String _additionalInfo = '';
  int? _age;
  String _selectedGender = '남성';
  String _disease = '';
  String _medication = '';
  bool _showPersonalDataFields = false;

  final Map<String, String> _korToEng = {
    '전체': 'ENTIRE',
    '임산부': 'MATERNITY',
    '노약자': 'ELDERS',
    '남성': 'MALE',
    '여성': 'FEMALE',
    '머리': 'HEAD',
    '손': 'HAND',
    '손목': 'WRIST',
    '발': 'FOOT',
    '발목': 'ANKLE',
    '목': 'NECK',
    '목구멍': 'THROAT',
    '팔': 'ARM',
    '심장': 'HEART',
    '허리': 'WAIST',
    '눈': 'EYE',
    '치아': 'TEETH',
    '무릎': 'KNEE',
    '귀': 'EAR',
    '피부': 'SKIN',
    '배': 'STOMACH',
    '허벅지': 'THIGH',
    '종아리': 'CALF',
    '등': 'BACK',
  };

  final List<String> _symptoms = ['머리', '치아', '열'];
  final List<String> _bodyParts = ['머리', '손', '손목', '발', '발목', '목', '목구멍', '팔', '심장', '허리', '눈', '치아', '무릎', '귀', '피부', '배', '허벅지', '종아리', '등'];
  final List<String> _categories = ['전체', '임산부', '노약자'];
  final List<String> _genders = ['남성', '여성'];

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
    _title = value;
    notifyListeners();
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
      'bodyParts': [_korToEng[_selectedBodyPart] ?? 'HEAD'],
      'category': _korToEng[_selectedCategory]!,
      'title': _title,
      'symptom': _symptomDescription,
      'content': _additionalInfo,
      'personalData': _showPersonalDataFields
          ? {
        'age': _age,
        'gender': _korToEng[_selectedGender]!,
        'disease': _disease,
        'medication': _medication,
      }
          : null,
    });

    try {
      final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      final responseData = jsonDecode(response.body);
      if (responseData['result'] == 'success') {
        print('요청 성공: ${response.body}');
        _showSuccessSnackBar(context);
      } else {
        print('요청 실패: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('예외 발생: $e');
    }
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('질문 등록이 완료되었습니다.'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
// class BoardViewModel extends ChangeNotifier {
//   String? baseUrl = dotenv.env['BASE_URL'];
//
//   Question? _question;
//
//   Question? get question => _question;
//
//   void setQuestion(Question? value) {
//     _question = value;
//     print(_question);
//     notifyListeners();
//   }
//
//   String _title = '';
//   String _selectedSymptom = '머리';
//   String _selectedBodyPart = 'HEAD';
//   String _selectedCategory = 'ENTIRE';
//   String _symptomDescription = '';
//   String _additionalInfo = '';
//   int? _age;
//   String _selectedGender = 'MALE';
//   String _disease = '';
//   String _medication = '';
//   bool _showPersonalDataFields = false;
//
//   final List<String> _symptoms = ['머리', '치아', '열'];
//   final List<String> _bodyParts = ['HAND', 'WRIST', 'FOOT', 'ANKLE', 'NECK', 'THROAT',
//   'HEAD', 'ARM', 'HEART','WAIST', 'EYE', 'TEETH', 'KNEE', 'EAR', 'SKIN','STOMACH', 'THIGH',
//   'CALF', 'BACK'];
//   final List<String> _categories = ['ENTIRE', 'MATERNITY', 'ELDERS'];
//   final List<String> _genders = ['MALE', 'FEMALE'];
//
//   String get title => _title;
//   String get selectedBodyPart => _selectedBodyPart;
//   String get selectedCategory => _selectedCategory;
//   String get symptomDescription => _symptomDescription;
//   String get additionalInfo => _additionalInfo;
//   int? get age => _age;
//   String get selectedGender => _selectedGender;
//   String get disease => _disease;
//   String get medication => _medication;
//   bool get showPersonalDataFields => _showPersonalDataFields;
//
//
//   List<String> get symptoms => _symptoms;
//   List<String> get bodyParts => _bodyParts;
//   List<String> get categories => _categories;
//   List<String> get genders => _genders;
//
//   void setTitle(String value) {
//     print("여기");
//     print(value);
//     _title = value;
//     notifyListeners(); //리렌더링 하는 함수
//   }
//
//   void setSelectedSymptom(String value) {
//     _selectedSymptom = value;
//     notifyListeners();
//   }
//
//   void setSelectedBodyPart(String value) {
//     _selectedBodyPart = value;
//     notifyListeners();
//   }
//
//   void setSelectedCategory(String value) {
//     _selectedCategory = value;
//     notifyListeners();
//   }
//
//   void setSymptomDescription(String value) {
//     _symptomDescription = value;
//     notifyListeners();
//   }
//
//   void setAdditionalInfo(String value) {
//     _additionalInfo = value;
//     notifyListeners();
//   }
//
//   void setAge(String value) {
//     _age = int.tryParse(value);
//     notifyListeners();
//   }
//
//   void setSelectedGender(String value) {
//     _selectedGender = value;
//     notifyListeners();
//   }
//
//   void setDisease(String value) {
//     _disease = value;
//     notifyListeners();
//   }
//
//   void setMedication(String value) {
//     _medication = value;
//     notifyListeners();
//   }
//
//   void toggleShowPersonalDataFields(bool show) {
//     _showPersonalDataFields = show;
//     notifyListeners();
//   }
//
//   Future<void> submitForm(String userId, BuildContext context) async {
//     final url = Uri.parse('$baseUrl/question/enroll');
//     final body = jsonEncode({
//       'userId': userId,
//       'bodyParts': [_selectedBodyPart.toUpperCase()],
//       'category': _selectedCategory.toUpperCase(),
//       'title': _title,
//       'symptom': _symptomDescription,
//       'content': _additionalInfo,
//       'personalData': _showPersonalDataFields
//           ? {
//         'age': _age,
//         'gender': _selectedGender,
//         'disease': _disease,
//         'medication': _medication,
//       }
//           : null,
//     },
//
//     );
//     print(body);
//     try {
//       final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
//       final responseData = jsonDecode(response.body);
//       if (responseData['result'] == 'success') {
//         print('요청 성공: ${response.body}');
//         _showSuccessSnackBar(context);
//       } else {
//         // 요청 실패 시 처리
//         print('요청 실패: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       // 예외 처리
//       print('예외 발생: $e');
//     }
//   }
//
//   void _showSuccessSnackBar(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('질문 등록이 완료되었습니다.'),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }
