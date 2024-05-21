import 'dart:convert';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class QuestionRepository {
  String? baseUrl = dotenv.env['BASE_URL'];


  Future<List<Question>> fetchQuestions({String? category}) async {
    final uri = Uri.parse('$baseUrl/api/v1/question')
        .replace(queryParameters: {
      'category': category,
    });

    print(uri);
    final response = await http.get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final questions = (data['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList();
      return questions;
    } else {
      throw Exception('Failed to fetch questions');
    }
  }

  Future<void> deleteQuestion(int questionId) async {
    final uri = Uri.parse('$baseUrl/api/test-0/question/$questionId');
    final response = await http.delete(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete question');
    }
  }

  Future<List<Question>> myBoardList({String? userId}) async {
    final uri = Uri.parse('$baseUrl/api/v1/question')
        .replace(queryParameters: {
      'userId': userId,
    });

    print(uri);
    final response = await http.get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final questions = (data['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList();
      return questions;
    } else {
      throw Exception('Failed to fetch questions');
    }
  }


// Future<List<Question>> fetchQuestions() async {
  //   final response = await http.get(Uri.parse('$baseUrl/api/v1/question'));
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //
  //     final data = json.decode(response.body);
  //     final questions = (data['questions'] as List)
  //         .map((question) => Question.fromJson(question))
  //         .toList();
  //     return questions;
  //
  //   } else {
  //     throw Exception('Failed to fetch questions');
  //   }
  // }

  // Future<List<Question>> fetchQuestions({String? category, String? userId}) async {
  //   final uri = Uri.parse('$baseUrl/api/test-1/question/list')
  //       .replace(queryParameters: {
  //     'category': category,
  //     'userId': userId,
  //   });
  //
  //   print(uri);
  //   final response = await http.get(uri);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final questions = (data['questions'] as List)
  //         .map((question) => Question.fromJson(question))
  //         .toList();
  //     return questions;
  //   } else {
  //     throw Exception('Failed to fetch questions');
  //   }
  // }

}

