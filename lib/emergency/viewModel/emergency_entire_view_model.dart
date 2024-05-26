import 'package:flutter/widgets.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/model/emergency.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/repository/emergency_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class EmergencyViewModel extends ChangeNotifier {

  final EmergencyRepository _repository;
  List<Emergency> _emergency = [];

  EmergencyViewModel(this._repository);

  List<Emergency> get emergency => _emergency;

  Future<void> fetchEmergency(String? userId) async {
    try {
      print("실행?");
      _emergency = await _repository.fetchEmergency(userId);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching questions: $e');
    }
  }
  //
  // Future<void> deleteQuestion(Question question) async {
  //   try {
  //     await _repository.deleteQuestion(question.id);
  //     _questions.remove(question);
  //     notifyListeners();
  //   } catch (e) {
  //     // Handle error
  //     print('Error deleting question: $e');
  //   }
  // }
  //
  // Future<void> myBoardQuestion( {String? userId}) async {
  //   try {
  //     _questions = await _repository.myBoardList(userId: userId);
  //     notifyListeners();
  //   } catch (e) {
  //     // Handle error
  //     print('Error deleting question: $e');
  //   }
  // }
  //
  // Future<void> updateQuestion(
  //     int questionId,
  //     String title,
  //     String symptom,
  //     String content,
  //     ) async {
  //   try {
  //     print(questionId);
  //     print(title);
  //     print(symptom);
  //     print(content);
  //     await _repository.updateQuestion(
  //       questionId,
  //       title,
  //       symptom,
  //       content,
  //     );
  //     // 질문 목록 업데이트
  //     await fetchQuestions();
  //   } catch (e) {
  //     // Handle error
  //     print('Error updating question: $e');
  //   }
  // }
}
