import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/comment_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_category_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_detail_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_entire_view_model.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/comment_view_model.dart';

final commentViewModelProvider = ChangeNotifierProvider((ref) => CommentViewModel(CommentRepository()));

class MyCommentList extends ConsumerStatefulWidget {

  const MyCommentList({Key? key}) : super(key: key);

  @override
  ConsumerState<MyCommentList> createState() => _MyCommentListScreenState();
}

class _MyCommentListScreenState extends ConsumerState<MyCommentList> {

  @override
  void initState() {
    super.initState();
    _myCommentList("string");
    //print('Received category: ${widget.category}');
  }

  void _myCommentList(String userId) {
    //final userId = userId;
    //final userId = 'patientId';
    ref.read(commentViewModelProvider).myCommentList(userId: userId);
    //ref.read(questionViewModelProvider).fetchQuestions(category: category, userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(commentViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("나의 댓글"),
        backgroundColor: Colors.blue[50],
        elevation: 0,
      ),
      body: _buildCommentList(viewModel),
    );
  }
  @override
  Widget _buildCommentList(CommentViewModel viewModel) {
    if (viewModel.comments.isEmpty) {
      return Center(
        child: Text(
          '아직 등록한 댓글이 없습니다.'
              '댓글을 달아 보세요!',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: viewModel.comments.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final comment = viewModel.comments[index];
          return Container(
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BoardDetailScreen(question: comment),
                //   ),
                // );
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 32.0,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Text(
                      comment.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
