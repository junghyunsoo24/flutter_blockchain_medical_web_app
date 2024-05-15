import 'package:flutter/widgets.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class BoardEntireViewModel extends StateNotifier<List<Question>> {

  final _questionRepository = BoardRepository();

  BoardEntireViewModel() : super([]);

  Future<void> fetchQuestions() async {
    try {
      state = await _questionRepository.getQuestions();
      print("실행???");
    } catch (e) {
      // 에러 처리
    }
  }
}
