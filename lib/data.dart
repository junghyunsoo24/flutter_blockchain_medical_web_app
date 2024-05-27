import 'dart:io';
import 'package:flutter/foundation.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

const emulatorIp = '10.0.2.2:3000';

// const realPhoneIp = '192.168.248.103:3000';

//const realPhoneIp = '172.30.67.135:8080';
const webIp = 'localhost:8080';
const realPhoneIp = '172.30.66.77:8080';
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