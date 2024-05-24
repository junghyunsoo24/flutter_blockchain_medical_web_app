import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_category_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_detail_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_entire_view_model.dart';

import 'comment_insert_view.dart';

final questionViewModelProvider = ChangeNotifierProvider((ref) => QuestionViewModel(QuestionRepository()));

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
      case 'ElDERS':
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
    final category = selectedCategory;
    //final userId = 'patientId';
    ref.read(questionViewModelProvider).fetchQuestions(category: category);
    //ref.read(questionViewModelProvider).fetchQuestions(category: category, userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(questionViewModelProvider);
    final categoryTitle = '${getCategoryDisplayName(widget.category)} 게시판';
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: Colors.blue[50],
        elevation: 0,
      ),
      body: _buildQuestionList(viewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoardScreen()),
          );
        },
        backgroundColor: Colors.blue[50],
        child: const Icon(Icons.add),
      ),
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
          return Dismissible(
            key: Key(question.id.toString()),
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
            onDismissed: (_) {
              ref.read(questionViewModelProvider).deleteQuestion(question);
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoardDetailScreen(question: question),
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
