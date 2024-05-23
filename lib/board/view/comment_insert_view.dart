import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../repository/comment_repository.dart';
import '../viewModel/comment_view_model.dart';
import 'comment_view.dart';

class CommentInsertView extends StatefulWidget {
  final int questionId;

  const CommentInsertView({super.key, required this.questionId});

  @override
  _CommentInsertViewState createState() => _CommentInsertViewState();
}

class _CommentInsertViewState extends State<CommentInsertView> {
  final TextEditingController _commentController = TextEditingController();
  late final CommentViewModel _commentViewModel;

  @override
  void initState() {
    super.initState();
    _commentViewModel = CommentViewModel(CommentRepository());
    _commentViewModel.fetchComments(widget.questionId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        const Text(
          '댓글',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: '댓글을 입력하세요',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final content = _commentController.text.trim();
                if (content.isNotEmpty) {
                  _commentViewModel.addComment(widget.questionId, content);
                  _commentController.clear();
                }
              },
              child: const Text('등록'),
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _commentViewModel,
          builder: (context, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _commentViewModel.comments.length,
              itemBuilder: (context, index) {
                final comment = _commentViewModel.comments[index];
                return Dismissible(
                  key: Key(comment.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16.0),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    _commentViewModel.deleteComment(comment.id);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.comment),
                    title: Text(comment.content),
                    subtitle: Text('작성자: ${comment.userId}'),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

