import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/model/doctor_info.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/model/user_info.dart';
import '../data.dart';

class BlockchainService {
  static const String baseUrl = 'http://$firstBlockchainIp';

  Future<void> registerNodes() async {
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var data1 = {'nodes': 'http://$secondBlockchainIp'};
    var data2 = {'nodes': 'http://$thirdBlockchainIp'};

    await http.post(Uri.parse('$baseUrl/nodes/register'),
        headers: headers, body: jsonEncode(data1));
    await http.post(Uri.parse('$baseUrl/nodes/register'),
        headers: headers, body: jsonEncode(data2));
  }

  String calculateHash(Map<String, dynamic> medicalData) {
    var dataBytes = utf8.encode(jsonEncode(medicalData));
    var hashBytes = sha256.convert(dataBytes);
    return hashBytes.toString();
  }

  Future<String> storeHashOnBlockchain(String dataHash, int sender) async {
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var data = {
      "sender": sender,
      "recipient": "blockchain",
      "amount": 0,
      "smart_contract": {
        "contract_code": "def store_hash():\n    return '$dataHash'"
      }
    };

    var response = await http.post(Uri.parse('$baseUrl/transactions/new'),
        headers: headers, body: jsonEncode(data));
    var contractAddress = jsonDecode(response.body)['contract_address'];

    await http.get(Uri.parse('$baseUrl/mine'));
    return contractAddress;
  }

  Future<String> getHashFromBlockchain(String contractAddress) async {
    var response = await http.get(Uri.parse('$baseUrl/chain'));
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