import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/pages/navigation_page.dart';
import 'package:papi_gold/app/core/constants/index.dart';

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
    GoRoute(
      name: Routes.navigation,
      path: '/${Routes.navigation}',
      builder: (context, state) => NavigationPage(),
      routes: [
         GoRoute(
          name: Routes.order,
          path: '/${Routes.order}/:id',
          builder: (context, state) => OrderPage(orderId: state.pathParameters['id']!,),
        ),
      ]
    ),
  ],
);
