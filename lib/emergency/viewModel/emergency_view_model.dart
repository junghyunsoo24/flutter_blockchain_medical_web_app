import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';

class EmergencyInsertViewModel extends ChangeNotifier {
  String? baseUrl = dotenv.env['BASE_URL'];

  String _contents = '';

  String get contents => _contents;

  void setEmergency(String value) {
    _contents = value;
    notifyListeners();
  }

  Future<void> submitEmergencyForm(String userId, BuildContext context) async {
    final url = Uri.parse('$baseUrl/patient/enroll-urgent-data');
    final body = jsonEncode(
      {
        'id': userId,
        'content': _contents,
      },
    );
    print(body);
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);
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