import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'splash/provider/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
late MyDatabase database;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: 'my-app', options: DefaultFirebaseOptions.currentPlatform);


  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/firebase_options.dart';
// import 'notification.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       navigatorKey: FlutterLocalNotification.navigatorKey,
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final Stream<QuerySnapshot> _messagesStream =
//   FirebaseFirestore.instance.collection('messages').snapshots();
//
//   void getMyDeviceToken() async {
//     final token = await FirebaseMessaging.instance.getToken();
//     print("내 디바이스 토큰: $token");
//   }
//
//   @override
//   void initState() {
//     getMyDeviceToken();
//     super.initState();
//     FlutterLocalNotification.init();
//     _messagesStream.listen((querySnapshot) {
//       querySnapshot.docChanges.forEach((change) {
//         if (change.type == DocumentChangeType.added) {
//           Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
//           FlutterLocalNotification.showNotification(data);
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           child: const Text('Send Data'),
//           onPressed: () {
//             FirebaseFirestore.instance.collection('messages').add({
//               'title': '긴급 데이터',
//               'body': '환자는 rh- 혈액형이 필요합니다',
//               'sender': '의사 김정민',
//             });
//           },
//         ),
//       ),
//     );
//   }
// }