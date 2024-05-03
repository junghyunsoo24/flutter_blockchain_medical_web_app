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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'notification.dart';
import 'second.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _messagesStream =
  FirebaseFirestore.instance.collection('messages').snapshots();

  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");
  }

  @override
  void initState() {
    getMyDeviceToken();
    super.initState();
    FlutterLocalNotification.init();
    _messagesStream.listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
          FlutterLocalNotification.showNotification(data);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Send Data'),
          onPressed: () {
            FirebaseFirestore.instance.collection('messages').add({
              'title': '테스트테스트',
              'body': 'This is a new message',
              'sender': 'Your Name',
            });
          },
        ),
      ),
    );
  }
}