import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../login/view/login_screen.dart';
import '../../splash/view/splash_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  });

  List<GoRoute> get routes => [
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.routeName,
      builder: (_, __) => const LoginScreen(),
    ),
  ];

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    // // final UserModelBase? user = ref.read(userMeProvider);
    //
    // final logginIn = state.matchedLocation == '/login';
    //
    // // 유저 정보가 없는데
    // // 로그인중이면 그대로 로그인 페이지에 두고
    // // 만약에 로그인중이 아니라면 로그인 페이지로 이동
    // if (user == null) {
    //   return logginIn ? null : '/login';
    // }
    //
    // // user가 null이 아님
    //
    // // UserModel
    // // 사용자 정보가 있는 상태면
    // // 로그인 중이거나 현재 위치가 SplashScreen이면
    // // 홈으로 이동
    // if (user is UserModel) {
    //   if (logginIn || state.matchedLocation == '/splash') {
    //     if (MediaQuery.of(context).size.width > 600) {
    //       return '/doctor';
    //     } else {
    //       return '/';
    //     }
    //   }
    // }
    return'/login'; // 조건에 맞지 않는 경우, 리디렉션하지 않음
  }
}