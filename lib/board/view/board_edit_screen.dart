import 'package:flutter/cupertino.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_list_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/question.dart';
final boardViewModelProvider = ChangeNotifierProvider((ref) => BoardViewModel());
class BoardEditScreen extends ConsumerWidget {
  const BoardEditScreen({super.key, this.question});

  final Question? question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionViewModel = ref.watch(questionViewModelProvider);

    // 텍스트 필드 컨트롤러 정의
    final titleController = TextEditingController(text: question?.title);
    final symptomController = TextEditingController(text: question?.symptom);
    final contentController = TextEditingController(text: question?.content);

    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 수정'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '제목',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: symptomController,
              decoration: const InputDecoration(
                labelText: '증상',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: '내용',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // 수정된 데이터를 저장
                questionViewModel.updateQuestion(
                  question!.id,
                  titleController.text,
                  symptomController.text,
                  contentController.text,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoardListScreen(category: question!.category),
                  ),
                );
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
