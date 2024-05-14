import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_entire_view_model.dart';

final boardEntireViewModelProvider = StateNotifierProvider<BoardEntireViewModel, List<Question>>((ref) => BoardEntireViewModel());

class BoardEntireScreen extends ConsumerStatefulWidget {
  @override
  _BoardEntireScreenState createState() => _BoardEntireScreenState();
}

class _BoardEntireScreenState extends ConsumerState<BoardEntireScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(boardEntireViewModelProvider.notifier).fetchQuestions();
    print("실행?");
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(boardEntireViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('전체 게시판'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return ListTile(
            title: Text(question.title),
            subtitle: Text(question.content),
            trailing: Text(
              '${question.createdAt.year}-${question.createdAt.month}-${question.createdAt.day}',
            ),
          );
        },
      ),
    );
  }
}
