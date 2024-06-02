import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_category_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_detail_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_entire_view_model.dart';

import '../../login/model/user_info.dart';
import '../../login/view/login_screen.dart';
import 'comment_insert_view.dart';

final questionViewModelProvider =
    ChangeNotifierProvider((ref) => QuestionViewModel(QuestionRepository()));

class BoardListScreen extends ConsumerStatefulWidget {
  final String category;

  const BoardListScreen({Key? key, required this.category}) : super(key: key);

  @override
  ConsumerState<BoardListScreen> createState() => _BoardListScreenState();
}

class _BoardListScreenState extends ConsumerState<BoardListScreen> {
  String getCategoryDisplayName(String category) {
    switch (category) {
      case 'ENTIRE':
        return '전체';
      case 'ELDERS':
        return '노약자';
      case 'MATERNITY':
        return '임산부';
      default:
        return category;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions(widget.category);
    print('Received category: ${widget.category}');
  }

  void _fetchQuestions(String selectedCategory) {
    final category = _getEnglishCategory(selectedCategory);
    ref.read(questionViewModelProvider).fetchQuestions(category: category);
  }
  String _getEnglishCategory(String koreanCategory) {
    final Map<String, String> korToEng = {
      '전체': 'ENTIRE',
      '노약자': 'ELDERS',
      '임산부': 'MATERNITY',
    };
    return korToEng[koreanCategory] ?? 'ENTIRE';
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(questionViewModelProvider);
    final userInfo = ref.watch(userInfoProvider);
    final categoryTitle = '${getCategoryDisplayName(widget.category)} 게시판';
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: Colors.blue[50],
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              '우측에 위치한 점 아이콘을 누르면, 삭제하실 수 있습니다.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: _buildQuestionList(viewModel, userInfo),
          ),
        ],
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoardScreen()),
          );
        },
        backgroundColor: Colors.blue[50],
        child: const Icon(Icons.add),
      )
          : null,
    );
  }

  @override
  Widget _buildQuestionList(QuestionViewModel viewModel, UserInformation userInfo) {
    if (viewModel.questions.isEmpty) {
      return Center(
        child: Text(
          '아직 등록된 게시글이 없습니다.'
              '질문을 등록해보세요!',
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
          final isOwnQuestion = question.uid == userInfo.userId;
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BoardDetailScreen(question: question),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 32.0,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            question.title,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '작성자: ${question.uid}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
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
              if (isOwnQuestion)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: Text('게시물 삭제'),
                              content: Text('게시물을 삭제하시겠습니까?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('취소'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(questionViewModelProvider)
                                        .deleteQuestion(question);
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
    }
  }
}