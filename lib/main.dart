// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
// import 'splash/provider/go_router.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';
//
// late MyDatabase database;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   database = MyDatabase();
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends ConsumerWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final router = ref.watch(routerProvider);
//
//     return MaterialApp.router(
//       theme: ThemeData(
//         fontFamily: 'NotoSans',
//       ),
//       debugShowCheckedModeBanner: false,
//       routerDelegate: router.routerDelegate,
//       routeInformationParser: router.routeInformationParser,
//       routeInformationProvider: router.routeInformationProvider,
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/second.dart';
import 'notification.dart';

StreamController<String> streamController = StreamController.broadcast(); //Notification을 위한 StreamController 전역 변수 선언

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotification.onBackgroundNotificationResponse(); //Background에서 Notification를 탭해서 앱을 여는 경우를 위한 메소드

  runApp(const MaterialApp(
    title: 'Flutter App',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    FlutterLocalNotification.init();

    Future.delayed(const Duration(seconds: 3), FlutterLocalNotification.requestNotificationPermission());

    super.initState();
  }

  @override
  void dispose() {
    streamController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<String>(//Stream 전달
          stream: streamController.stream, builder: (context, snapshot) {//snapshot을 통해 데이터를 확인
            if (snapshot.hasData) {
              if (snapshot.data == 'HELLOWORLD') {
                WidgetsBinding.instance.addPostFrameCallback((_) {//빌드가 먼저 완료된 후에 호출하기 위해 addPostFrameCallback 사용
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const SecondPage();
                  }));
                });
              }
            }

            return Center(
              child: TextButton(
                onPressed: () {//알림 전송
                  FlutterLocalNotification.showNotification();
                },
                child: const Text("알림 보내기"),
              ),
            );
          }),
    );
  }
}