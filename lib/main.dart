import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/view/login_screen.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import 'deliver/alarm_template.dart';
import 'notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:get_it/get_it.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  final database = MyDatabase();
  GetIt.I.registerSingleton<MyDatabase>(database);

  FlutterLocalNotification flutterLocalNotification = FlutterLocalNotification();
  GetIt.I.registerSingleton<FlutterLocalNotification>(flutterLocalNotification);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  GetIt.I.registerSingleton<FlutterLocalNotificationsPlugin>(flutterLocalNotificationsPlugin);

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        name: 'medical-block-app', options: DefaultFirebaseOptions.currentPlatform);
  }

  else if (Platform.isWindows) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  await dotenv.load(fileName: 'asset/config/.env');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      navigatorKey: FlutterLocalNotification.navigatorKey,
      home: const LoginScreen(),
    );
  }
}