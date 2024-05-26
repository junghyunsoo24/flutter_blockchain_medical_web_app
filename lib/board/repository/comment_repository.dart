import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/comment.dart';

class CommentRepository {
  String? baseUrl = dotenv.env['BASE_URL'];

  Future<List<Comments>> fetchComments(int questionId) async {
    final uri = Uri.parse('$baseUrl/api/test-1/opinions')
        .replace(queryParameters: {
      'questionId': questionId.toString(),
    });
    final response = await http.get(uri);
    print(uri);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final comments = (data['opinions'] as List)
          .map((comment) => Comments.fromJson(comment))
          .toList();
      return comments;
    } else {
      throw Exception('Failed to fetch comments');
    }
  }



  Future<void> addComment(int questionId, String content, String userId) async {
    final uri = Uri.parse('$baseUrl/api/v1/opinion/enroll');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'questionId': questionId.toString(),
        'content': content,
      }),
    );
    print(uri);
    print(response.body);
    if (response.statusCode == 200) {
      print("? 성공");
      print('요청 성공: ${response.body}');
      // final data = json.decode(utf8.decode(response.bodyBytes));
      // print(data);
      // return Comments.fromJson(data['comment']);
    } else {
      throw Exception('Failed to add comment');
    }
  }

  Future<void> deleteComment(int commentId) async {
    final uri = Uri.parse('$baseUrl/api/test-0/opinion/$commentId');
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      print('Comment deleted successfully');
    } else {
      throw Exception('Failed to delete comment');
    }
  }

  Future<List<Comments>> myCommentList({String? userId}) async {
    final uri = Uri.parse('$baseUrl/api/test-1/opinions')
        .replace(queryParameters: {
      'userId': userId,
    });

    print(uri);
    final response = await http.get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final opinions = (data['opinions'] as List)
          .map((question) => Comments.fromJson(question))
          .toList();
      return opinions;
    } else {
      throw Exception('Failed to fetch opinions');
    }
  }


}
