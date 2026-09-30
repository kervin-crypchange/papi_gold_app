import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/pages/navigation_page.dart';
import 'package:papi_gold/app/core/class/app_navigation.dart';
import 'package:papi_gold/app/core/constants/index.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: AppNavigation.navigatorKey,
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
      path: '/${Routes.otp}',
      name: Routes.otp,
      builder: (context, state) {
        final typeStr = state.uri.queryParameters['type'];
        final type = OptTypeEnum.fromString(typeStr);
        return OptVerificationPage(type: type);
      },
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
          builder: (context, state) =>
              OrderPage(orderId: state.pathParameters['id']!),
        ),
        GoRoute(
          name: Routes.product,
          path: '/${Routes.product}/:id',
          builder: (context, state) =>
              ProductPage(id: state.pathParameters['id']!),
        ),
        GoRoute(
          name: Routes.profile,
          path: Routes.profile,
          builder: (context, state) => ProfilePage(),
        ),
        GoRoute(
          name: Routes.cart,
          path: Routes.cart,
          builder: (context, state) => CartPage(),
        ),
        GoRoute(
          name: Routes.changePassword,
          path: Routes.changePassword,
          builder: (context, state) => ChangePasswordPage(),
        ),
        GoRoute(
          name: Routes.notifications,
          path: Routes.notifications,
          builder: (context, state) => NotificationsPage(),
          routes: [
            GoRoute(
              name: Routes.notification,
              path: '${Routes.notifications}/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return NotificationPage(
                  id: id,
                  not: state.extra as Map<String, dynamic>,
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: Routes.about,
          path: Routes.about,
          builder: (context, state) => AboutPage(),
        ),
        GoRoute(
          name: Routes.address,
          path: Routes.address,
          builder: (context, state) => DirectionsPage(key: UniqueKey()),
          routes: [
            GoRoute(
              name: Routes.newAddress,
              path: Routes.newAddress,
              builder: (context, state) => DirectionPage(),
            ),
            GoRoute(
              name: Routes.map,
              path: Routes.map,
              builder: (context, state) => MapPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
