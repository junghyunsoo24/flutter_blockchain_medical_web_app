import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/main.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/user/provider/auth_provider.dart';

import '../../deliver/view/deliver_screen.dart';
import '../../notification.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // watch - 값이 변경될때마다 다시 빌드
  // read - 한번만 읽고 값이 변경돼도 다시 빌드하지 않음
  final provider = ref.read(authProvider);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    routes: provider.routes,
    initialLocation: '/login',
    refreshListenable: provider,
    // redirect: provider.redirectLogic,
    navigatorKey: navigatorKey,
  );
});