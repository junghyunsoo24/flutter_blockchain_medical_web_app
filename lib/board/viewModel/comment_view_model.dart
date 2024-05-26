import 'package:flutter/cupertino.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';

import '../model/comment.dart';
import '../repository/comment_repository.dart';

class CommentViewModel extends ChangeNotifier {
  final CommentRepository _commentRepository;
  List<Comments> _comments = [];
  List<Question> _questions = [];
  CommentViewModel(this._commentRepository);

  List<Comments> get comments => _comments;
  List<Question> get questions => _questions;

  Future<void> fetchComments(int questionId) async {
    try {
      _comments = await _commentRepository.fetchComments(questionId);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching comments: $e');
    }
  }

  Future<void> addComment(int questionId, String content, String userId) async {
    try {
      final newComment = await _commentRepository.addComment(questionId, content, userId);
      _comments.add(newComment); // 새로운 댓글을 _comments 리스트에 추가
      notifyListeners(); // 상태 변경 알림
    } catch (e) {
      // 에러 처리
      print('Error adding comment: $e');
    }
  }


  // Future<void> addComment(int questionId, String content, String userId) async {
  //   print(questionId);
  //   print("userId잘 넘어왔나 보자");
  //   print(userId);
  //   try {
  //     final newComment = await _commentRepository.addComment(questionId, content, userId);
  //     //_comments.add(newComment);
  //     notifyListeners();
  //   } catch (e) {
  //     // Handle error
  //     print('Error adding comment: $e');
  //   }
  // }

  Future<void> deleteComment(int commentId) async {
    try {
      await _commentRepository.deleteComment(commentId);
      _comments.removeWhere((comment) => comment.id == commentId);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error deleting comment: $e');
    }
  }

  Future<void> myCommentList( {String? userId}) async {
    try {
      print("유저 아이디 출력해보자.");
      print(userId);
      _questions = await _commentRepository.myCommentQuestionList(userId: userId);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error deleting question: $e');
    }
  }

}
