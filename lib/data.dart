import 'dart:io';
import 'package:flutter/foundation.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

const emulatorIp = '10.0.2.2:3000';
const realPhoneIp = '192.168.248.103:3000';
const webIp = 'localhost:3000';

String getIp() {
  if (kIsWeb) {
    return webIp;
  } else {
    // if (Platform.isAndroid) {
    //   return emulatorIp;
    // } else{
    //   return realPhoneIp;
    // }
      return emulatorIp;
  }
}
final ip = getIp();