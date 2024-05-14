import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'splash/provider/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:get_it/get_it.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
late MyDatabase database;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  final database = MyDatabase();
  GetIt.I.registerSingleton<MyDatabase>(database);

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        name: 'medical-block-app', options: DefaultFirebaseOptions.currentPlatform);
  } else if (Platform.isWindows) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  await dotenv.load(fileName: 'asset/config/.env');

  // tz.initializeTimeZones();
  // tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

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
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}