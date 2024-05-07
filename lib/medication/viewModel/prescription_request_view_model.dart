import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/model/prescript_request_model.dart';

class PrescriptionRequestViewModel {
  Future<void> requestPrescriptionHistory(
      String name,
      String birthday,
      String phone,
      String provider,
      ) async {
    final model = PrescriptionRequestModel(
      name: name,
      birthday: birthday,
      phone: phone,
      provider: provider,
    );

    final url = Uri.parse('http://localhost:5000/api/v1/medical-api/treatment-imformation/first-request'); //일단 임시 URL
    final response = await http.post(
      url,
      body: jsonEncode(model.toJson()), //model의 내용을 json 타입으로 변경해서 전달
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // 요청 성공 처리
      print('Prescription history request successful');
    } else {
      // 요청 실패 처리
      print('Prescription history request failed: ${response.statusCode}');
    }
  }
}
