
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'splash/provider/go_router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';

late MyDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  database = MyDatabase();
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

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
// import 'splash/provider/go_router.dart';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';
//
// late MyDatabase database;
// void main() async{
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform);
//
//   database = MyDatabase();
//   runApp(
//       const ProviderScope(
//         child: MyApp(),
//       )
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
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("백그라운드 메시지 처리.. ${message.notification!.body!}");
// }
//
// void initializeNotification() async {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(const AndroidNotificationChannel(
//       'high_importance_channel', 'high_importance_notification',
//       importance: Importance.max));
//
//   await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
//     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//   ));
//
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
// }
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   initializeNotification();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   var messageString = "";
//
//   void getMyDeviceToken() async {
//     final token = await FirebaseMessaging.instance.getToken();
//     print("내 디바이스 토큰: $token");
//   }
//
//   @override
//   void initState() {
//     getMyDeviceToken();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       RemoteNotification? notification = message.notification;
//
//       if (notification != null) {
//         FlutterLocalNotificationsPlugin().show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'high_importance_channel',
//               'high_importance_notification',
//               importance: Importance.max,
//             ),
//           ),
//         );
//         setState(() {
//           messageString = message.notification!.body!;
//           print("Foreground 메시지 수신: $messageString");
//         });
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("메시지 내용: $messageString"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
// import 'splash/provider/go_router.dart';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';

// late MyDatabase database;
// void main() async{
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform);
//
//   database = MyDatabase();
//   runApp(
//       const ProviderScope(
//         child: MyApp(),
//       )
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

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
// import 'splash/provider/go_router.dart';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';

// late MyDatabase database;
// void main() async{
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform);
//
//   database = MyDatabase();
//   runApp(
//       const ProviderScope(
//         child: MyApp(),
//       )
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

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/second.dart';
//
// import 'notification.dart';
//
// //! Notification을 위한 StreamController 전역 변수 선언
//
// StreamController<String> streamController = StreamController.broadcast();
//
// Future<void> main() async {
//   //! Binding부터 해줍니다.
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   //! Background에서 Notification를 탭해서 앱을 여는 경우를 위한 메소드
//
//   FlutterLocalNotification.onBackgroundNotificationResponse();
//
//   //! 메인 앱 실행
//
//   runApp(const MaterialApp(
//     title: 'Flutter App',
//     home: HomePage(),
//   ));
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     // 초기화
//
//     FlutterLocalNotification.init();
//
//     // 3초 후 권한 요청
//
//     Future.delayed(const Duration(seconds: 3),
//         FlutterLocalNotification.requestNotificationPermission());
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     streamController.close();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<String>(
//
//         //! Stream을 전달합니다.
//
//           stream: streamController.stream,
//           builder: (context, snapshot) {
//             //! snapshot을 통해 데이터를 확인합니다.
//
//             if (snapshot.hasData) {
//               //! 데이터가 'HELLOWORLD'라면 SecondPage로 이동
//
//               if (snapshot.data == 'HELLOWORLD') {
//                 //! 빌드가 먼저 완료된 후에 호출하기 위해 addPostFrameCallback 사용
//
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return const SecondPage();
//                   }));
//                 });
//               }
//             }
//
//             return Center(
//               child: TextButton(
//                 onPressed: () {
//                   //! 알림 전송
//
//                   FlutterLocalNotification.showNotification();
//                 },
//                 child: const Text("알림 보내기"),
//               ),
//             );
//           }),
//     );
//   }
