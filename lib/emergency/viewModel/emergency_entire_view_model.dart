import 'package:flutter/widgets.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/repository/board_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/model/emergency.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/emergency/repository/emergency_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/model/user_info.dart';
import 'package:state_notifier/state_notifier.dart';

class EmergencyViewModel extends ChangeNotifier {

  final EmergencyRepository _repository;
  Emergency? _emergency;

  EmergencyViewModel(this._repository);

  Emergency? get emergency => _emergency;

  Future<void> fetchEmergency(String? userId) async {
    try {
      _emergency = await _repository.fetchEmergency(userId);
      notifyListeners();
    } catch (e) {
      print('Error fetching emergency data: $e');
    }
  }

  void setEmergency(Emergency? emergency) {
    _emergency = emergency;
    notifyListeners();
  }

  Future<void> deleteMyEmergencyData(String userId) async {
    try {
      await _repository.deleteMyEmergencyData(userId);
      _emergency = null;
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error deleting question: $e');
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
