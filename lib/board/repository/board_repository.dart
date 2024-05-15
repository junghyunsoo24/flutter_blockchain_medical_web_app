import 'dart:convert';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class BoardRepository {
  String? baseUrl = dotenv.env['BASE_URL'];

  Future<List<Question>> getQuestions() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/question'));
    print(response.body);
    if (response.statusCode == 200) {
      print("응답 왔니?");
      final List<dynamic> data = json.decode(response.body);

      return data.map((item) => Question.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch questions');
    }
  }
}