import 'package:flutter/material.dart';
import '../repository/comment_repository.dart';
import '../viewModel/comment_view_model.dart';

class CommentView extends StatefulWidget {
  final int questionId;

  const CommentView({super.key, required this.questionId});

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  late final CommentViewModel _commentViewModel;

  @override
  void initState() {
    super.initState();
    _commentViewModel = CommentViewModel(CommentRepository());
    _commentViewModel.fetchComments(widget.questionId);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _commentViewModel,
      builder: (context, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _commentViewModel.comments.length,
          itemBuilder: (context, index) {
            final comment = _commentViewModel.comments[index];
            return ListTile(
              leading: const Icon(Icons.comment),
              title: Text(comment.content),
              subtitle: Text('작성자: ${comment.userId}'),
            );
          },
        );
      },
    );
  }
}
