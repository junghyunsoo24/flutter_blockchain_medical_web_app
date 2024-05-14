// import 'package:flutter/widgets.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
//
// class BoardEntireViewModel extends ChangeNotifier {
//   final _questionRepository = BoardRepository();
//   List<Question> _questions = [];
//
//   List<Question> get questions => _questions;
//
//   Future<void> fetchQuestions() async {
//     try {
//       _questions = await _questionRepository.getQuestions();
//       notifyListeners();
//     } catch (e) {
//       // 에러 처리
//     }
//   }
// }
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
