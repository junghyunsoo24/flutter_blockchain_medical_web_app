
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../login/view/login_screen.dart';
import '../repository/comment_repository.dart';
import '../viewModel/comment_view_model.dart';
import 'comment_view.dart';

class CommentInsertView extends ConsumerStatefulWidget {
  final int questionId;

  const CommentInsertView({super.key, required this.questionId});

  @override
  _CommentInsertViewState createState() => _CommentInsertViewState();
}

class _CommentInsertViewState extends ConsumerState<CommentInsertView> {
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
    final userInfo = ref.watch(userInfoProvider);

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
                  _commentViewModel.addComment(widget.questionId, content, userInfo.userId);
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
                final isOwnComment = comment.userId == userInfo.userId;
                return Stack(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.comment),
                      title: Text(comment.content),
                      subtitle: Text('작성자: ${comment.userId}'),
                    ),
                    if (isOwnComment)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('댓글 삭제'),
                                content: Text('댓글을 삭제하시겠습니까?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('취소'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _commentViewModel.deleteComment(comment.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('삭제'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
