import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/presentation/pages/index.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/', 
      name: 'wrapper', 
      builder: (context, state) => WrapperPage(),
    ),
    GoRoute(
      path: '/${Routes.home}',
      name: Routes.home, 
      builder: (context, state) => WrapperPage(),
    ),
    GoRoute(
      path: '/${Routes.login}',
      name: Routes.login,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/${Routes.register}',
      name: Routes.register,
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/${Routes.recovery}',
      name: Routes.recovery,
      builder: (context, state) => RecoveryPasswordPage(),
    ),
  ],
);
