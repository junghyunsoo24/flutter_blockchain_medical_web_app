import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/model/doctor_info.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/model/user_info.dart';
import '../data.dart';

class BlockchainService {
  String? FIRST_BLOCK_URL = dotenv.env['FIRST_BLOCK_URL'];
  String? SECOND_BLOCK_URL = dotenv.env['SECOND_BLOCK_URL'];
  String? THIRD_BLOCK_URL = dotenv.env['THIRD_BLOCK_URL'];

  String? _baseUrl;

  Future<void> registerNodes() async {

    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var data1 = {'nodes': SECOND_BLOCK_URL};
    var data2 = {'nodes': THIRD_BLOCK_URL};

    await http.post(Uri.parse('$FIRST_BLOCK_URL/nodes/register'),
        headers: headers, body: jsonEncode(data1));
    await http.post(Uri.parse('$FIRST_BLOCK_URL/nodes/register'),
        headers: headers, body: jsonEncode(data2));
  }

  String calculateHash(Map<String, dynamic> medicalData) {
    var dataBytes = utf8.encode(jsonEncode(medicalData));
    var hashBytes = sha256.convert(dataBytes);
    return hashBytes.toString();
  }

  Future<String> storeHashOnBlockchain(String dataHash, dynamic sender) async {
    String senderString = sender is int ? sender.toString() : sender;

    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var data = {
      "sender": senderString,
      "recipient": "blockchain",
      "amount": 0,
      "smart_contract": {
        "contract_code": "def store_hash():\n    return '$dataHash'"
      }
    };

    var response = await http.post(Uri.parse('$FIRST_BLOCK_URL/transactions/new'),
        headers: headers, body: jsonEncode(data));
    var contractAddress = jsonDecode(response.body)['contract_address'];

    await http.get(Uri.parse('$FIRST_BLOCK_URL/mine'));
    return contractAddress;
  }

  Future<String> getHashFromBlockchain(String contractAddress) async {
    var response = await http.get(Uri.parse('$FIRST_BLOCK_URL/chain'));
    var resJson = jsonDecode(response.body);
    for (var block in resJson['chain']) {
      for (var tx in block['transactions']) {
        if (tx['smart_contract']['contract_address'] == contractAddress) {
          var storedHash = tx['smart_contract']['contract_code'].split('return ')[1];
          return storedHash.substring(1, storedHash.length - 1);
        }
      }
    }
    return '';
  }

  Future<bool> verifyMedicalData(String originHash, String storedHash) async {
    return originHash == storedHash;
  }
}