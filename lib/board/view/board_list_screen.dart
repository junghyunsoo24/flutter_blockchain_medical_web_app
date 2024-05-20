import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_detail_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_entire_view_model.dart';

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
    final userId = 'patientId';
    ref.read(questionViewModelProvider).fetchQuestions(category: category, userId: userId);
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
          // Navigate to the create question screen
        },
        backgroundColor: Colors.blue[50],
        child: const Icon(Icons.add),
      ),
    );
  }
  Widget _buildQuestionList(QuestionViewModel viewModel) {
    if (viewModel.questions.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: viewModel.questions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final question = viewModel.questions[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the question detail page and pass the selected question
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BoardDetailScreen(question: question),
                ),
              );
            },
            child: Card(
              // ... (existing card content)
            ),
          );
        },
      );
    }
  }


// Widget _buildQuestionList(QuestionViewModel viewModel) {
  //   if (viewModel.questions.isEmpty) {
  //     return const Center(
  //       child: CircularProgressIndicator(
  //         color: Colors.blue,
  //       ),
  //     );
  //   } else {
  //     return ListView.separated(
  //       padding: const EdgeInsets.all(16.0),
  //       itemCount: viewModel.questions.length,
  //       separatorBuilder: (context, index) => const SizedBox(height: 16.0),
  //       itemBuilder: (context, index) {
  //         final question = viewModel.questions[index];
  //         return Card(
  //           elevation: 4.0,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(8.0),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         '작성자: ${question.uid}',
  //                         style: const TextStyle(
  //                           fontSize: 16.0,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 8.0),
  //                       Text(
  //                         '제목: ${question.title}',
  //                         style: const TextStyle(
  //                           fontSize: 18.0,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 8.0),
  //                       Text(
  //                         '증상: ${question.symptom}',
  //                         style: const TextStyle(
  //                           fontSize: 16.0,
  //                           color: Colors.grey,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 8.0),
  //                       Text(
  //                         '${question.content}',
  //                         style: const TextStyle(
  //                           fontSize: 16.0,
  //                           color: Colors.grey,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const SizedBox(width: 16.0),
  //                 Text(
  //                   '${question.category}',
  //                   style: const TextStyle(
  //                     fontSize: 16.0,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

}
