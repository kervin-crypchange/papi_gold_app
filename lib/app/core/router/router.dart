import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/presentation/pages/index.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(path: '/', name: 'home', builder: (context, state) => HomePage()),
  ],
);
