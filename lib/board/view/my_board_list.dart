import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_category_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_detail_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_entire_view_model.dart';

import '../../login/view/login_screen.dart';

final questionViewModelProvider = ChangeNotifierProvider((ref) => QuestionViewModel(QuestionRepository()));

class MyBoardListScreen extends ConsumerStatefulWidget {

  const MyBoardListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyBoardListScreen> createState() => _MyBoardListScreenState();
}

class _MyBoardListScreenState extends ConsumerState<MyBoardListScreen> {

  @override
  void initState() {
    super.initState();
    _myBoardList(ref.read(userInfoProvider).userId);
  }

  void _myBoardList(String userId) {
    ref.read(questionViewModelProvider).myBoardQuestion(userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(questionViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("나의 게시글"),
        backgroundColor: Colors.blue[50],
        elevation: 0,
      ),
      body: _buildQuestionList(viewModel),
    );
  }
  @override
  Widget _buildQuestionList(QuestionViewModel viewModel) {
    if (viewModel.questions.isEmpty) {
      return Center(
        child: Text(
          '아직 등록된 게시글이 없습니다.',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: viewModel.questions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final question = viewModel.questions[index];
          return Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoardDetailScreen(question: question,   isMyPost: true,),
                  ),
                );
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
                    Text(
                      question.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      question.content,
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
