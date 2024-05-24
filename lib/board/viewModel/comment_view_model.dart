import 'package:flutter/cupertino.dart';

import '../model/comment.dart';
import '../repository/comment_repository.dart';

class CommentViewModel extends ChangeNotifier {
  final CommentRepository _commentRepository;
  List<Comments> _comments = [];

  CommentViewModel(this._commentRepository);

  List<Comments> get comments => _comments;

  Future<void> fetchComments(int questionId) async {
    try {
      _comments = await _commentRepository.fetchComments(questionId);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching comments: $e');
    }
  }

  Future<void> addComment(int questionId, String content) async {
    print(questionId);
    try {
      final newComment = await _commentRepository.addComment(questionId, content);
      //_comments.add(newComment);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error adding comment: $e');
    }
  }

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

}
