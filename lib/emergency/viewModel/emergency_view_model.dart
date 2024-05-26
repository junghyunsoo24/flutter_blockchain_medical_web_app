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

  Future<void> submitEmergencyForm(String userId) async {
    final url = Uri.parse('$baseUrl/api/v1/patient/enroll-urgent-data');
    final body = jsonEncode({
      'id': userId,
      'content': _contents,
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
