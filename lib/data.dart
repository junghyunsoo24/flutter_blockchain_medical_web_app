import 'dart:io';
import 'package:flutter/foundation.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

const emulatorIp = '10.0.2.2:8080';
const webIp = '192.168.219.102:8080';
const realPhoneIp = '192.168.219.102:8080';
const firstBlockchainIp = '192.168.219.102:5000';
const secondBlockchainIp = '192.168.219.102:5001';
const thirdBlockchainIp = '192.168.219.102:5002';


String getIp() {
  if (Platform.isAndroid) {
    return realPhoneIp;
  } else if (Platform.isIOS) {
    return realPhoneIp;
  } else if (Platform.isWindows) {
    return webIp;
  } else {
    return webIp;
  }

}
final ip = getIp();